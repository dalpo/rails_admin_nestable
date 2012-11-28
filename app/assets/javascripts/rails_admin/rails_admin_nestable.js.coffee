//= require rails_admin/jquery.nestable.js
//= require_self

$(document).ready ->
  $tree_nodes = $('#tree_nodes')
  $tree_nodes_options = {}
  $tree_nodes_max_depth = $tree_nodes.data('max-depth')

  if $tree_nodes_max_depth && $tree_nodes_max_depth != 'false'
    $tree_nodes_options['maxDepth'] = $tree_nodes_max_depth

  $tree_nodes
    .nestable( $tree_nodes_options )
    .on
      change: (event) ->
        serialized_tree = $tree_nodes.nestable('serialize')

        $.ajax
          url: $tree_nodes.data('update-path'),
          type: 'POST',
          data:
            tree_nodes: serialized_tree
          success: (data) ->
            $flash = $('<div>')
              .addClass('nestable-flash alert')
              .append( $('<button>').addClass('close').data('dismiss', 'alert').html('&times;') )
              .append( $('<span>').addClass('body').html( data ) )

            $('#rails_admin_nestable')
              .append( $flash )

            $flash.fadeIn(200)
              .delay(2000).fadeOut 200, ->
                $(this).remove()
