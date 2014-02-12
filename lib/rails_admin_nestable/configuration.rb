module RailsAdminNestable
  class Configuration

    TREE_DEFAULT_OPTIONS = { live_update: true, falseenable_callback: false, scope: nil }
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
      if tree?
        @nestable_options ||= self.tree_options
      elsif list?
        @nestable_options ||= self.list_options
      end

      @nestable_options || {}
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
