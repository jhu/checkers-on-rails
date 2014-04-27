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
      lockTheBoard();
      return xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    },
    success: function (data) {
      console.log(data);
      if (data.board !== undefined) {
        populateBoard(data.board);
      }
      if (data.valid) {
        // give up turn and start timer
        lockTheBoard();
        clearInterval(window.refreshIntervalId);
        window.refreshIntervalId = setInterval(function () {
          sendHeartbeat();
        }, 3000);
      } else {
        // revert until valid move
        populateBoard(data.board);
        unlockTheBoard();
      }
      // display message?
      if (data.message !== undefined) {
        alert(message);
      }
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
      return sendMove(MY_TURN_COLOR, getMovetext(x0, y0, x1, y1))
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
var myTurn = false;
var MY_TURN_COLOR;
var pieceImages = {
  '1': '/assets/images/pr.png',
  '2': '/assets/images/kr.png',
  '-1': '/assets/images/pw.png',
  '-2': '/assets/images/kw.png'
};
var redPieces = [1, 2];

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
        // stop the heartbeat
        myTurn = false;
        clearInterval(window.refreshIntervalId);
        populateBoard(o.board);
        unlockTheBoard();
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
      var image = "<img src='" + pieceImages[board[y][x].toString()] + "'/>";
      if (MY_TURN_COLOR === 'red' && board[y][x] > 0) {
        image = "<img src='" + pieceImages[board[y][x].toString()] +
          "' class='dojoDndItem ui-draggable'/>";
      } else if (MY_TURN_COLOR === 'white' && board[y][x] < 0) {
        image = "<img src='" + pieceImages[board[y][x].toString()] +
          "' class='dojoDndItem ui-draggable'/>";
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