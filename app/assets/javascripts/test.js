(function ($) {
  /*var request = new XMLHttpRequest();
  //request.onload = callback;
  request.open("post", location.pathname + "/curl_example");
  var formData = new FormData();
  formData.append('my_data',
    "[[0,-1,0,-1,0,-1, 0,-1],[-1,0,-1,0,-1,0,-1,0],[0,-1,0,-1,0,-1,0,-1],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[1,0,1,0,1,0,1,0],[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]"
  )
  request.send(formData);
  var request = new XMLHttpRequest();
  request.open("post", location.pathname + "/curl_example");
  request.setRequestHeader("Content-Type", "application/json");
  var move = {};
  move.turn = "black";
  move.movetext = "22x32";
  request.send(JSON.stringify(move));*/

  function CSRFProtection(xhr) {
 var token = $('meta[name="csrf-token"]').attr('content');
 if (token) xhr.setRequestHeader('X-CSRF-Token', token);
}
if ('ajaxPrefilter' in $) $.ajaxPrefilter(function(options, originalOptions, xhr) { CSRFProtection(xhr); });
else $(document).ajaxSend(function(e, xhr) { CSRFProtection(xhr); });

  var request = new XMLHttpRequest();
  request.open("post", location.pathname + "/play");
  request.setRequestHeader("Content-Type", "application/json");
  var move = {};
  move.turn = "black";
  move.movetext = "22x32";
  move.board = [[0,-1,0,-1,0,-1, 0,-1],[-1,0,-1,0,-1,0,-1,0],[0,-1,0,-1,0,-1,0,-1],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[1,0,1,0,1,0,1,0],[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]
  request.send(JSON.stringify(move));

  //JSON.stringify(move);


  $.ajax({
    url: location.pathname + '/play',
    type: 'POST',
    dataType: 'html',
    data: JSON.stringify(move),
    contentType: 'application/json',
    mimeType: 'application/json',
    success: function (data) {
      //not currently able to use the 'new RedirectView("/games/" + gameId, true);' returned by controller
      /*Draw(game.board);
      $.data(document.body, 'myTurn', false);*/
    },
    error: function (data, status, er) {
      /*alert(data.status + ": " + data.statusText);
      game.board.populateFromArray(boardStatePriorToMove);*/
      alert("error in ajax call!");
    }
  });
})(jQuery);