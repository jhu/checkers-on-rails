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
    request.open("post", "/play");
    request.setRequestHeader("Content-Type", "application/json");
    var i = 0;
    //setInterval(function(){sendmove(i++)},3000);
    // var moves = ["11x18","12x32","8x12","11x15"];
    var moves = ['21x17', /*'22x18','18x14','24x20','28x24'*/ ];
    var sample_moves = ["11x15", "24x20", "8x11", "28x24", "4x8", "23x19",
        "15x18", "22x15", "11x18", "32x28", "10x14", "26x23", "9x13",
        "19x15", "7x11", "31x26", "2x7", "26x22", "13x17", "22x13", "6x9",
        "13x6", "1x26", "30x23", "11x15", "25x22", "18x25", "29x22",
        "7x10", "23x19", "5x9", "22x17", "9x13", "20x16", "13x22",
        "16x11", "22x26", "11x4", "26x31", "4x8", "3x7", "8x3", "31x26",
        "19x16", "12x19", "27x23", "26x22", "23x16", "22x18", "3x8",
        "7x11", "16x7", "15x19", "24x6", "14x17", "21x14", "18x4",
        "28x24", "4x8", "24x19", "8x11", "19x15", "11x18"];
    /*$.each(sample_moves, function (index, val) {
      sendmove(index);
    });*/
    // var timer = setInterval(function(){sendmove(i++)},3000);

    function sendmove(num) {
      // if(i > sample_moves.length){
      //   clearTimeout(timer);
      // }
      // var pieceImages = {'1'=>'pr.png','2'=>'kr.png','-1'=>'pw.png','-2'=>'kw.png'}
      var move = {};
      move.turn = "white";
      move.movetext = sample_moves[num];
      move.boardState = [[1, -1, 0, -1, 0, -1, 0, -1], [-1, 0, -1,
        0, -1, 0, -1, 0], [0, -1, 0, -1, 0, -1, 0, -1], [0, 0, 0,
        0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 1, 0, 1,
        0, 1, 0], [0, 1, 0, 1, 0, 1, 0, 1], [1, 0, 1, 0, 1, 0, 1,
        0]]
      //request.send(JSON.stringify(move));
      //JSON.stringify(move);
      var request = $.ajax({
        url: location.pathname + '/play',
        type: 'POST',
        dataType: 'html',
        data: JSON.stringify(move),
        contentType: 'application/json',
        mimeType: 'application/json',
        beforeSend: function (data) {},
        success: function (data) {
          // $(".testboard").append('<span>'+data+'</span>');
          // $( ".inner" ).append( "test" );
          $("#board-container #board tr td").empty();
          var results = JSON.parse(data);
          $.each(data, function (y, row) {
            $.each(row, function (x, piece) {
              $("tr.y" + y + " td.x" + x).append(move.boardState[y][x]);
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