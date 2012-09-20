require "rails_admin_Nestable/engine"

module RailsAdminNestable
end

require 'rails_admin/config/actions'
require 'rails_admin/config/model'

module RailsAdmin
  module Config
    module Actions
      class Nestable < Base
        RailsAdmin::Config::Actions.register(self)

        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          true
        end

        # Is the action on an object scope (Example: /admin/team/1/edit)
        register_instance_option :member? do
          false
        end

        register_instance_option :controller do
          Proc.new do
            def update_recoursively(tree_nodes, parent_node = nil)
              position_field = ::RailsAdmin::Config.model(@abstract_model.model).nestable_position_field

              tree_nodes.each do |key, value|
                model = @abstract_model.model.find(value['id'])
                model.parent = parent_node if parent_node.present?

                if position_field.present?
                  model.send("#{position_field}=".to_sym, (key.to_i + 1))
                end

                model.save!(validate: false)

                if value.has_key?('children')
                  update_recoursively(value['children'], model)
                end
              end
            end

            if params['tree_nodes'].present?
              ActiveRecord::Base.transaction do
                update_recoursively params[:tree_nodes]
              end
              render text: 'done'
            else
              @tree_nodes = @abstract_model.model.arrange(order: ::RailsAdmin::Config.model(@abstract_model.model).nestable_position_field)
              render action: @action.template_name
            end
          end
        end

        register_instance_option :link_icon do
          'icon-align-left'
        end

        register_instance_option :http_methods do
          [:get, :post]
        end
      end
    end
  end
end

module RailsAdmin
  module Config
    class Model

      register_instance_option :nestable_position_field do
        nil
      end

      register_instance_option :nestable_max_depth do
        nil
      end

    end
  end
end
