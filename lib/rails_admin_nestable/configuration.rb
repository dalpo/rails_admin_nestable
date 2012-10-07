module RailsAdminNestable
  class Configuration

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
        @nestable_options ||= (tree.class == Hash ? tree : {})
      elsif list?
        @nestable_options ||= { position_field: :position, max_depth: 1 }.merge(list.class == Hash ? list : {})
      end

      @nestable_options || {}
    end

  protected

    def tree
      @nestable_tree ||= ::RailsAdmin::Config.model(@abstract_model.model).nestable_tree
    end

    def list
      @nestable_list ||= ::RailsAdmin::Config.model(@abstract_model.model).nestable_list
    end

  end
end
