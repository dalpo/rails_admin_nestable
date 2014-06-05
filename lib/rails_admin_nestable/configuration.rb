module RailsAdminNestable
  class Configuration

    TREE_DEFAULT_OPTIONS = { live_update: true, enable_callback: false, scope: nil }
    LIST_DEFAULT_OPTIONS = { position_field: :position, max_depth: 1, live_update: true, enable_callback: false, scope: nil }

    def initialize(abstract_model)
      @abstract_model = abstract_model
    end

    def tree?
      tree.present?
    end

    def list?
      list.present? && !tree?
    end

    def options
      @nestable_options ||= begin
        options = self.tree_options if tree?
        options = self.list_options if list?
        options || {}
      end
    end

    protected

      def tree_options
        tree.class == Hash ? TREE_DEFAULT_OPTIONS.merge(tree) : TREE_DEFAULT_OPTIONS
      end

      def list_options
        LIST_DEFAULT_OPTIONS.merge(list.class == Hash ? list : {})
      end

      def tree
        @nestable_tree ||= ::RailsAdmin::Config.model(@abstract_model.model).nestable_tree
      end

      def list
        @nestable_list ||= ::RailsAdmin::Config.model(@abstract_model.model).nestable_list
      end

  end
end
