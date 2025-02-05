// _____________________________
//|......***THROWBANANA***......|
//|.....part of RobotMonkey.....|
//|........version 1.0..........|
//|..Created by: Wikke Andeweg..|
//|https://github.com/WyzzyMoon |
//|_____________________________|


var socket;
var next;
var prev;
var inp;
var pressID;

function setup() {
  noCanvas();
  socket = io.connect('localhost:33594/')

next = document.getElementById("NEXT");
prev = document.getElementById("PREV");
next.onclick = function() {nextSlide()};
prev.onclick = function() {prevSlide()};
}


function draw(){
  background(0);
  pressID = document.getElementById("pressID").value;

}

function nextSlide() {
  console.log('Sending: next')
  var data = {
    name: pressID,
    command: "next"

  }
  socket.emit('controll', data);

}
function prevSlide() {
  console.log('Sending: prev')
  var data = {
    name: pressID,
    command: "prev"
  }
  socket.emit('controll', data);
}
