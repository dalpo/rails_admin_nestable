require "rails_admin_ancestry/engine"

module RailsAdminAncestry
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Ancestry < Base
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
            @tree_nodes = @abstract_model.all.arrange
            render :action => @action.template_name
          end
        end

        register_instance_option :link_icon do
          'icon-align-left'
        end
      end
    end
  end
end

