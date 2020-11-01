# RobotMonkey

RobotMonkey is an open source remote clicker for presentations.
It allows you to control a PowerPoint/Keynote that is running on a computer with an internet connection from anywhere in the world.
It doesn't require the person that controls the presentation to install anything.

RobotMonkey consists of two parts:
- **ThrowBanana** : The remote, a nodeJS application that you need to run on your webserver. This will send the controls via websockets
- **CatchBanana** : The program that receives the clicks and turns them into keypresses

## Download
Binaries for Windows and macOS are available in the [Releases](https://github.com/WyzzyMoon/RobotMonkey/releases) section.

## Customize
The code comes preconfigured to look for a local host server on port 33594
To customize this edit:

ThrowBanana/public/remote.js
```
socket = io.connect('localhost:33594/')
```

ThrowBanana/server.js (port number)
```
var server = app.listen(33594);
```

If you want CatchBanana to automatically connect change:
CatchBanana/CatchBanana.pde
```
String WSlink = "ws://localhost:33594/socket.io/?EIO=3&transport=websocket";
```
make sure to add "/socket.io/?EIO=3&transport=websocket" at the end of the link.
