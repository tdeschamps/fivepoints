jQuery ->
  if $('#sortable').length > 0
    ##table_width = $('#sortable').width()
    ##cells = $('.table').find('tr')[0].cells.length
    ##desired_width = table_width / cells + 'px'
    ##$('.table td').css('width', desired_width)

    $('#sortable').sortable(
      #axis: 'y'
      items: '.item'
      cursor: 'move'

      sort: (e, ui) ->
        ui.item.addClass('active-item-shadow')
      stop: (e, ui) ->
        ui.item.removeClass('active-item-shadow')
        # highlight the row on drop to indicate an update
        ui.item.children('li').effect('highlight', {}, 1000)
      update: (e, ui) ->
        item_id = ui.item.data('item-id')
        position = ui.item.index() + 1 # this will not work with paginated items, as the index is zero on every page
        l = $('#sortable > li.item').not('.ui-sortable-placeholder').length
        i = 0
        while i < l - 1
          $('#sortable > li.item').not('.ui-sortable-placeholder').find($('.rank-square')).find($('h1'))[i].innerHTML = i + 1
          i++
          
        $.ajax(
          type: 'POST'
          url: '/city_guide_places/update_position'
          dataType: 'json'
          data: { city_guide_place: {city_guide_place_id: item_id, position: position } }
        )
    )