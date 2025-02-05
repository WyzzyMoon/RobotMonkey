// _____________________________
//|......***THROWBANANA***......|
//|.....part of RobotMonkey.....|
//|........version 1.0..........|
//|..Created by: Wikke Andeweg..|
//|https://github.com/WyzzyMoon |
//|_____________________________|

var express = require('express');

var app = express();
var server = app.listen(33594);
// var server = app.listen(0, () => {
//   console.log('Listening on port:', server.address().port);
// });

app.use(express.static(__dirname + '/public'));

console.log("Server is running");

var socket = require('socket.io');

var io = socket(server);

io.sockets.on('connection', newConnection);

function newConnection(socket) {
  console.log('new connection: ' + socket.id);
socket.on('controll', sendControll);

function sendControll(data) {
  console.log(data);
  socket.broadcast.emit(data);
}

}
