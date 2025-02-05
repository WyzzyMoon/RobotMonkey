# RobotMonkey

RobotMonkey is an open source remote clicker for presentations.
It replaces "clickmonkeys" that need to watch a skype screenshare to replicate a presentation on-site.
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

## Third-Party Libraries & Licenses

This project makes use of the following libraries:

- **nv-websocket-client** (licensed under Apache License 2.0)
  - Repository: https://github.com/TakahikoKawasaki/nv-websocket-client
  - License: Apache License 2.0 (included in `licenses/Apache-2.0.txt`)

- **controlP5** (licensed under LGPL-2.1)
  - Repository: https://github.com/sojamo/controlP5
  - License: GNU Lesser General Public License v2.1 (included in `licenses/LGPL-2.1.txt`)

The original license files for these libraries are included in the `Licenses/` directory.
