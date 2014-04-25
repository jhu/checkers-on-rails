$(() ->
  window.sourceElement
  window.destinationElement

  $(".dojoDndItem").draggable ({
    create: () -> $(this).data('position',$(this).position())
    start: () ->
      xO = $(this).closest("tr").attr('class')
      yO = $(this).closest("td").attr('class').split(' ').join('.')
      console.log("start Location" + "[" + xO + ","+ yO + "]")

  })

  #add the droppable type to just the highlighted squares
  $("td.dp").droppable({
    over: (event, ui) ->
      $(ui.helper).unbind("mouseup")
    drop:(event, ui) ->
      snapToMiddle(ui.draggable,$(this));
      xX = $(this).closest("tr").attr('class')
      yX = $(this).closest("td").attr('class').split(' ').join('.')
      console.log("end Location" + "[" + xX + "," + yX + "]")
    out: (event, ui) ->
      $(ui.helper).mouseup( () ->
        snapToStart(ui.draggable,$(this))
        );
  });

  snapToMiddle = (dragger, target) ->
    topMove = target.position().top - dragger.data('position').top + (target.outerHeight(true) - dragger.outerHeight(true)) / 2
    leftMove= target.position().left - dragger.data('position').left + (target.outerWidth(true) - dragger.outerWidth(true)) / 2
    dragger.animate({top:topMove,left:leftMove},{duration:100,easing:'easeOutBack'})

  snapToStart = (dragger, target) ->
    dragger.animate({top:0,left:0},{duration:100,easing:'easeOutBack'})

);
