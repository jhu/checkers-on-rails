// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
//= require jquery.ui.all

var sendMove = function (turn, move) {
  data = {
    'turn': turn,
    'movetext': move
  };
  var request = $.ajax({
    url: location.pathname + '/play',
    type: 'POST',
    dataType: 'json',
    data: JSON.stringify(data),
    contentType: 'application/json',
    mimeType: 'application/json',
    beforeSend: function (xhr) {
      $("#game-message").html("Sending...").attr('class', 'alert alert-info');
      lockTheBoard();
      // return xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    },
    success: function (data) {
      console.log(data);
      if (data.board !== undefined) {
        populateBoard(data.board);
      }
      
      if (data['gameover'] === true) {
        return $("#game-message").html(data.message).attr('class', 'alert alert-success');
      }

      if (data.valid) {
        // give up turn and start timer
        $("#game-message").html(data.message + ' Waiting for other player...').attr('class', 'alert alert-success');
        lockTheBoard();
        var otherColor = (MY_TURN_COLOR !== 'red' ? 'red' : 'white');
        $("#turn-color").empty().html(otherColor + " turn");
        clearInterval(window.refreshIntervalId);
        window.refreshIntervalId = setInterval(function () {
          sendHeartbeat();
        }, 3000);
      } else {
        $("#game-message").html(data.message).attr('class', 'alert alert-danger');
        // revert until valid move
        // alert(data.message);
        // $(".alert").alert();

        // populateBoard(data.board);
        // unlockTheBoard();
      }
      // display message?
      // if (data.message !== undefined) {
        // alert(data.message);
      // }
    },
    error: function (data, status, er) {}
  });
}
var setDroppable = function () {
  var snapToMiddle, snapToStart, x0, x1, y0, y1;
  window.sourceElement;
  window.destinationElement;
  var x0, y0, x1, y1;
  $(".dojoDndItem").draggable({
    create: function () {
      return $(this).data('position', $(this).position());
    },
    start: function () {
      y0 = $(this).closest("tr").attr('class');
      x0 = $(this).closest("td").attr('class').split(' ')[0];
      return console.log("start Location" + "[" + x0 + "," + y0 + "]");
    }
  });
  $("td.dp").droppable({
    over: function (event, ui) {
      return $(ui.helper).unbind("mouseup");
    },
    drop: function (event, ui) {
      snapToMiddle(ui.draggable, $(this));
      y1 = $(this).closest("tr").attr('class');
      x1 = $(this).closest("td").attr('class').split(' ')[0];
      console.log("end Location" + "[" + x1 + "," + y1 + "]");
      return sendMove(MY_TURN_COLOR, getMovetext(x0, y0, x1, y1));
    },
    out: function (event, ui) {
      return $(ui.helper).mouseup(function () {
        return snapToStart(ui.draggable, $(this));
      });
    }
  });
  snapToMiddle = function (dragger, target) {
    var leftMove, topMove;
    topMove = target.position().top - dragger.data('position').top + (target.outerHeight(true) - dragger.outerHeight(
      true)) / 2;
    leftMove = target.position().left - dragger.data('position').left + (target.outerWidth(true) - dragger.outerWidth(
      true)) / 2;
    return dragger.animate({
      top: topMove,
      left: leftMove
    }, {
      duration: 100,
      easing: 'easeOutBack'
    });
  };
  snapToStart = function (dragger, target) {
    return dragger.animate({
      top: 0,
      left: 0
    }, {
      duration: 100,
      easing: 'easeOutBack'
    });
  };
}

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

// var myTurn = false;
var MY_TURN_COLOR;
var pieceImages = {};
var pieceDraggableImages = {};
var redPieces = [1, 2];

var started = false;

function setTurnColor(t) {
  MY_TURN_COLOR = t;
}

function sendHeartbeat() {
  var request = $.ajax({
    url: location.pathname + '/myturn',
    type: 'GET',
    dataType: 'html',
    contentType: 'application/json',
    mimeType: 'application/json',
    beforeSend: function (data) {},
    success: function (data) {
      console.log(data);
      var o = JSON.parse(data);
      if (o.myturn) {
        if(!started){
          $.ajax({
            url: location.pathname + '/update_match_title',
            type: 'GET',
            dataType: 'script',
            contentType: 'text/javascript',
            success: function(){started = true;}
          });
        }
        // stop the heartbeat
        $("#game-message").html('Your turn!').attr('class', 'alert alert-info');
        clearInterval(window.refreshIntervalId);
        populateBoard(o.board);
        // $("#turn-color").empty().html(MY_TURN_COLOR + " turn");
        // $(".wait-alert").alert('close');
        // $(".turn-alert").alert();
        // $(".turn-alert").alert('close');
      } else {
        $("#game-message").html('Wait for your turn').attr('class', 'alert alert-warning');
        // lockTheBoard();
        // $(".turn-alert").alert('close');
        // $(".wait-alert").alert();
        // var otherColor = (MY_TURN_COLOR !== 'red' ? 'red' : 'white');
        // $("#turn-color").empty().html(otherColor + " turn");
      }
    },
    error: function (data, status, er) {}
  });
}

function clearBoard() {
  $("#board-container #board tr td").empty();
}

function getBoardState() {
  // TODO: get current state of this board
}

function populateBoard(board) {
  clearBoard();
  $.each(board, function (y, row) {
    $.each(row, function (x, piece) {
      var image = pieceImages[board[y][x].toString()];
      if (MY_TURN_COLOR === 'red' && board[y][x] > 0) {
        image = pieceDraggableImages[board[y][x].toString()];
      } else if (MY_TURN_COLOR === 'white' && board[y][x] < 0) {
        image = pieceDraggableImages[board[y][x].toString()];
      }
      if (board[y][x] !== 0) {
        $("tr.y" + y + " td.x" + x).append(image);
      }

    });
  });
  setDroppable();
}

function lockTheBoard() {
  // will basically remove the dojoDndItem class from images
  $(".dojoDndItem").draggable('disable');
}

function unlockTheBoard() {
  $(".dojoDndItem").draggable('enable');
}

function getMovetext(x0, y0, x1, y1) {
  var from = x0.toString()[1] + y0.toString()[1];
  var to = x1.toString()[1] + y1.toString()[1];
  var board_map = {
    '10':1,'30':2,'50':3,'70':4,
    '01':5,'21':6,'41':7,'61':8,
    '12':9,'32':10,'52':11,'72':12,
    '03':13,'23':14,'43':15,'63':16,
    '14':17,'34':18,'54':19,'74':20,
    '05':21,'25':22,'45':23,'65':24,
    '16':25,'36':26,'56':27,'76':28,
    '07':29,'27':30,'47':31,'67':32
  };
  return board_map[from] + 'x' + board_map[to];
}

function setImageHash(red1,red2,white1,white2){
  pieceImages['1'] = red1;
  pieceImages['2'] = red2;
  pieceImages['-1'] = white1;
  pieceImages['-2'] = white2;
}

function setDraggableImageHash(red1,red2,white1,white2){
  pieceDraggableImages['1'] = red1;
  pieceDraggableImages['2'] = red2;
  pieceDraggableImages['-1'] = white1;
  pieceDraggableImages['-2'] = white2;
}