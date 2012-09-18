module RailsAdmin
  module AncestryHelper

    def nested_tree_nodes(tree_nodes)
      tree_nodes.map do |tree_node, sub_tree_nodes|
        li_class = 'tree_node'

        content_tag :li, class: li_class, id: "tree_node_#{tree_node.id}" do
          output = link_to @model_config.with(object: tree_node).object_label, edit_path(@abstract_model, tree_node.id)
          output+= content_tag :ul, nested_tree_nodes(sub_tree_nodes), class: 'nested_tree_nodes' if sub_tree_nodes.any?
          output
        end
      end.join.html_safe
    end

  end
end
