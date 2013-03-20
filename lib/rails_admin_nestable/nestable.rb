module RailsAdmin
  module Config
    module Actions
      class Nestable < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :pjax? do
          false
        end

        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          true
        end

        register_instance_option :member? do
          false
        end

        register_instance_option :controller do
          Proc.new do |klass|
            @nestable_conf = ::RailsAdminNestable::Configuration.new @abstract_model

            def update_tree(tree_nodes, parent_node = nil)
              tree_nodes.each do |key, value|
                model = @abstract_model.model.find(value['id'])
                if parent_node.present?
                  model.parent = parent_node
                else
                  model.parent = nil
                end

                if @nestable_conf.options[:position_field].present?
                  model.send("#{@nestable_conf.options[:position_field]}=".to_sym, (key.to_i + 1))
                end

                model.save!(validate: @nestable_conf.options[:enable_callback])

                if value.has_key?('children')
                  update_tree(value['children'], model)
                end
              end
            end

            def update_list(model_list)
              model_list.each do |key, value|
                model = @abstract_model.model.find(value['id'])
                model.send("#{@nestable_conf.options[:position_field]}=".to_sym, (key.to_i + 1))
                model.save!(validate: @nestable_conf.options[:enable_callback])
              end
            end

            if params['tree_nodes'].present?
              begin
                ActiveRecord::Base.transaction do
                  if @nestable_conf.tree?
                    update_tree params[:tree_nodes]
                  end

                  if @nestable_conf.list?
                    update_list params[:tree_nodes]
                  end
                end
                message = "<strong>#{I18n.t('admin.actions.nestable.success')}!</strong>"
              rescue Exception => e
                message = "<strong>#{I18n.t('admin.actions.nestable.error')}</strong>: #{e}"
              end

              render text: message
            else
              if @nestable_conf.tree?
                @tree_nodes = list_entries(@model_config, :nestable, nil, nil).arrange(order: @nestable_conf.options[:position_field])
              end

              if @nestable_conf.list?
                @tree_nodes = list_entries(@model_config, :nestable, nil, nil).reorder(@nestable_conf.options[:position_field])
              end

              render action: @action.template_name
            end
          end
        end

        register_instance_option :link_icon do
          'icon-move'
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :visible? do
          current_model = ::RailsAdmin::Config.model(bindings[:abstract_model])
          authorized? && (current_model.nestable_tree || current_model.nestable_list)
        end
      end
    end
  end
end
