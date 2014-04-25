(function ($) {
  function test() {
    function CSRFProtection(xhr) {
      var token = $('meta[name="csrf-token"]')
        .attr('content');
      if (token) xhr.setRequestHeader('X-CSRF-Token', token);
    }
    if ('ajaxPrefilter' in $) {
      $.ajaxPrefilter(function (options, originalOptions, xhr) {
        CSRFProtection(xhr);
      });
    } else {
      $(document)
        .ajaxSend(function (e, xhr) {
          CSRFProtection(xhr);
        });
    }
    var request = new XMLHttpRequest();
    request.open("post", location.pathname + "/play");
    request.setRequestHeader("Content-Type", "application/json");
    var i = 0;
    //setInterval(function(){sendmove(i++)},3000);

    // var moves = ["11x18","12x32","8x12","11x15"];
    var moves = ['21x17','22x18','18x14','24x20','28x24'];
    $.each(moves, function(index, val){
      sendmove(index);
    });
// setInterval(function(){sendmove(i++)},3000);
    function sendmove(num) {
      // var pieceImages = {'1'=>'pr.png','2'=>'kr.png','-1'=>'pw.png','-2'=>'kw.png'}
      var move = {};
      move.turn = "white";
      move.movetext = moves[num];
      move.boardState = [[1, -1, 0, -1, 0, -1, 0, -1], [-1, 0, -1,0, -1,0, -1, 0], [0, -1, 0, -1, 0, -1, 0, -1], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 1, 0, 1, 0, 1, 0], [0, 1, 0,1, 0, 1, 0, 1], [1, 0, 1, 0, 1, 0, 1, 0]]
      //request.send(JSON.stringify(move));
      //JSON.stringify(move);
      var request = $.ajax({
        url: location.pathname + '/play',
        type: 'POST',
        dataType: 'html',
        data: JSON.stringify(move),
        contentType: 'application/json',
        mimeType: 'application/json',
        beforeSend: function (data) {
          
        },
        success: function (data) {
          // $(".testboard").append('<span>'+data+'</span>');
          // $( ".inner" ).append( "test" );
          $("#board-container #board tr td").empty();
          $.each(move.boardState, function(y, row){
            $.each(row, function(x,piece){
              
              $("tr.y"+y+" td.x"+x).append(move.boardState[y][x]);
            });
          });
          //not currently able to use the 'new RedirectView("/games/" + gameId, true);' returned by controller
          /*Draw(game.board);
      $.data(document.body, 'myTurn', false);*/
        },
        error: function (data, status, er) {
          /*alert(data.status + ": " + data.statusText);
      game.board.populateFromArray(boardStatePriorToMove);*/
          //alert("error in ajax call!");
        }
      });
    }
  }
  window.onload = test;
})(jQuery);