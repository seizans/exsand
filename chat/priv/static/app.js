console.log("app.js loaded");

var ws_start = function ws_start() {
    var player_id = document.getElementById("player_id").value;
    console.log(player_id);
    var ws = new WebSocket('ws://localhost:8080/ws');
    ws.onmessage = function(e) {console.log(e)};
};
