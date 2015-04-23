jQuery ->
  updateNodes = (tree_nodes) ->
    serialized_tree = tree_nodes.nestable('serialize')

    $.ajax
      url: tree_nodes.data('update-path'),
      type: 'POST',
      data:
        tree_nodes: serialized_tree
      success: (data) ->
        $flash = $('<div>')
          .addClass('nestable-flash alert alert-success')
          .append( $('<button>').addClass('close').data('dismiss', 'alert').html('&times;') )
          .append( $('<span>').addClass('body').html( data ) )

        $('#rails_admin_nestable')
          .append( $flash )

        $flash.fadeIn(200)
          .delay(2000).fadeOut 200, ->
            $(this).remove()

  $tree_nodes = $('#tree_nodes')
  $tree_nodes_options = {}
  $tree_nodes_max_depth = $tree_nodes.data('max-depth')
  $live_update = $('#rails_admin_nestable input[type=checkbox]')
  $update_button = $('#rails_admin_nestable button')
  live_update_mode = if (!$live_update.length && !$update_button.length) then true else $live_update.prop('checked')
  $('#rails_admin_nestable button').prop('disabled', $live_update.prop('checked'))

  $live_update.change ->
    live_update_mode = $(this).prop('checked')
    $update_button.prop('disabled', live_update_mode)

  $update_button.click ->
    updateNodes($tree_nodes)

  if $tree_nodes_max_depth && $tree_nodes_max_depth != 'false'
    $tree_nodes_options['maxDepth'] = $tree_nodes_max_depth

  $tree_nodes
    .nestable( $tree_nodes_options )
    .on
      change: (event) ->
        if live_update_mode
          updateNodes($tree_nodes)
