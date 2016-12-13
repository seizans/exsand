console.log("app.js loaded");

var ws = new WebSocket('ws://localhost:8080/ws');
ws.onmessage = function(e) {console.log(e)};


var create_room = function create_room() {
    var room_name = document.getElementById("room_name").value;
    console.log("creating room: " + room_name);
    var payload = JSON.stringify({room_name: room_name});
    console.log(payload);
    ws.send(payload);
};

var ws_start = function ws_start() {
    var room_name = document.getElementById("room_name").value;
    var player_id = document.getElementById("player_id").value;
    console.log(player_id);
    // 本当は header に player_id 入れて送りたい
    var payload = JSON.stringify({player_id: player_id, room_name: room_name});
    console.log(payload);
    ws.send(payload);
};


var send_comment = function send_comment() {
    var room_name = document.getElementById("room_name").value;
    var player_id = document.getElementById("player_id").value;
    var comment = document.getElementById("comment").value;
    var payload = JSON.stringify({comment: comment, player_id: player_id, room_name: room_name})
    console.log(payload);
    ws.send(payload);
};
