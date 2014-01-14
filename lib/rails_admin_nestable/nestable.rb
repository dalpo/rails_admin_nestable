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
            position_field = @nestable_conf.options[:position_field]
            enable_callback = @nestable_conf.options[:enable_callback]
            nestable_scope = @nestable_conf.options[:scope]

            # Methods
            def update_tree(tree_nodes, position_field, enable_callback, parent_node = nil)
              tree_nodes.each do |key, value|
                model = @abstract_model.model.find(value['id'])
                model.parent = parent_node.present? ? parent_node : nil

                model.send("#{position_field}=".to_sym, (key.to_i + 1)) if position_field.present?
                model.save!(validate: enable_callback)

                update_tree(value['children'], position_field, enable_callback, model) if value.has_key?('children')
              end
            end

            def update_list(model_list, position_field, enable_callback)
              model_list.each do |key, value|
                model = @abstract_model.model.find(value['id'])
                model.send("#{position_field}=".to_sym, (key.to_i + 1))
                model.save!(validate: enable_callback)
              end
            end

            if request.post? && params['tree_nodes'].present?
              begin
                update_tree(params[:tree_nodes], position_field, enable_callback) if @nestable_conf.tree?
                update_list(params[:tree_nodes], position_field, enable_callback) if @nestable_conf.list?

                message = "<strong>#{I18n.t('admin.actions.nestable.success')}!</strong>"
              rescue Exception => e
                message = "<strong>#{I18n.t('admin.actions.nestable.error')}</strong>: #{e}"
              end

              render text: message
            end

            if request.get?
              scope = begin
                case nestable_scope.class.to_s
                when 'Proc'
                  nestable_scope.call
                when 'Symbol'
                  @abstract_model.model.public_send(nestable_scope)
                else
                  nil
                end
              end

              query = list_entries(@model_config, :nestable, false, false)#reorder(nil).merge(scope)

              @tree_nodes = if @nestable_conf.tree?
                query.arrange(order: position_field)
              elsif @nestable_conf.list?
                query.order_by(position_field => 1)
              end

              render action: @action.template_name
            end
          end
        end

        register_instance_option :link_icon do
          'icon-th-list'
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