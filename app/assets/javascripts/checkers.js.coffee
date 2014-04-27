# $(() ->
#   window.sourceElement
#   window.destinationElement
#   x0 = null
#   y0 = null
#   x1 = null
#   y1 = null

#   $(".dojoDndItem").draggable ({
#     create: () -> $(this).data('position',$(this).position())
#     start: () ->
#       y0 = $(this).closest("tr").attr('class')
#       x0 = $(this).closest("td").attr('class').split(' ')[0]
#       console.log("start Location" + "[" + x0 + ","+ y0 + "]")
#   })

#   #add the droppable type to just the highlighted squares
#   $("td.dp").droppable({
#     over: (event, ui) ->
#       $(ui.helper).unbind("mouseup")
#     drop:(event, ui) ->
#       snapToMiddle(ui.draggable,$(this));
#       y1 = $(this).closest("tr").attr('class')
#       x1 = $(this).closest("td").attr('class').split(' ')[0]
#       console.log("end Location" + "[" + x1 + "," + y1 + "]")

#       $.ajax({
#         type: 'POST',
#         beforeSend: (xhr) -> xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')),
#         url: location.pathname + '/play',
#         success: (data) -> console.log(data),
#         crossDomain: true,
#         data: {
#           #board: JSON.stringify(board)
#           turn: 'white',
#           movetext: getMovetext(x0,y0,x1,y1)
#         },
#         dataType: 'json'
#       });

#     out: (event, ui) ->
#       $(ui.helper).mouseup( () ->
#         snapToStart(ui.draggable,$(this))
#         );
#   });

#   snapToMiddle = (dragger, target) ->
#     topMove = target.position().top - dragger.data('position').top + (target.outerHeight(true) - dragger.outerHeight(true)) / 2
#     leftMove= target.position().left - dragger.data('position').left + (target.outerWidth(true) - dragger.outerWidth(true)) / 2
#     dragger.animate({top:topMove,left:leftMove},{duration:100,easing:'easeOutBack'})

#   snapToStart = (dragger, target) ->
#     dragger.animate({top:0,left:0},{duration:100,easing:'easeOutBack'})

# );
