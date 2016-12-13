console.log("app.js loaded");

var ws = new WebSocket('ws://localhost:8080/ws');
ws.onmessage = function(e) {console.log(e)};


var ws_start = function ws_start() {
    var player_id = document.getElementById("player_id").value;
    console.log(player_id);
    // 本当は header に player_id 入れて送りたい
    ws.send('player_id: ' + player_id);
};


var send_comment = function send_comment() {
    var comment = document.getElementById("comment").value;
    ws.send('comment: ' + comment);
};
