// _____________________________
//|......***CATCHBANANA***......|
//|.....part of RobotMonkey.....|
//|........version 2.0..........|
//|..Created by: Wikke Andeweg..|
//|https://github.com/WyzzyMoon |
//|_____________________________|

import com.neovisionaries.ws.client.*;
import controlP5.*;
import java.awt.Robot;
import java.awt.event.KeyEvent;

//receive commands
String msgcrop;
String WSlink = "ws://localhost:33594/socket.io/?EIO=3&transport=websocket";
String presID = "";
String name;
String command;
String WSerror = "";
Boolean firstConnect = false;
Boolean connected = false;
Boolean socketcreated = false;
color cw;
Robot robot;

//websocket
WebSocket ws;

//input
ControlP5 cp5;

void setup() {
  size(400, 130);
  cw = color(255, 0, 0);
  try {
    robot = new Robot();
  }
  catch (Exception e) {
    e.printStackTrace();
  }

  cp5 = new ControlP5(this);
  cp5.setColorForeground(color(100, 100, 100));
  cp5.setColorBackground(color(51, 51, 51));
  cp5.addTextfield("WebSocket Link")
    .setValue(WSlink)
    .setSize(300, 20)
    .setPosition(20, 20)
    .setAutoClear(false)
    ;
  cp5.addBang("connect")
    .setPosition(330, 20)
    .setSize(40, 20)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
  cp5.addTextfield("ID")
    .setValue(presID)
    .setSize(300, 20)
    .setPosition(20, 70)
    .setAutoClear(false)
    ;
  ;

  connect();
}

void draw() {
  background(0);
  text("CatchBanana V2.0: RobotMonkey controller by Wikke Andeweg", 20, 120);
  text(WSerror, 320, 53);
  presID = cp5.get(Textfield.class, "ID").getText();
  WSlink = cp5.get(Textfield.class, "WebSocket Link").getText();

  fill(cw);
  ellipse(385, 30, 10, 10);

  textSize(9);
  fill(255);

  if (firstConnect == true) {
    CheckSocket();
  }
}

void webSocketEvent(String msg) {
  int firstB = msg.indexOf("{");
  int secondB = msg.indexOf("}");


  if (firstB != -1)
  {
    msgcrop = msg.substring(firstB, secondB+1);
    JSONObject obj = parseJSONObject(msgcrop);
    name = obj.getString("name");
    command = obj.getString("command");

    if (name != null && command != null) {
      if (name.equals(presID) == true) {
        if (command.equals("next") == true) {
          //println("NEXT");
          robot.keyPress(KeyEvent.VK_RIGHT);
          robot.keyRelease(KeyEvent.VK_RIGHT);
        } else if (command.equals("prev") == true) {
          //println("PREV");
          robot.keyPress(KeyEvent.VK_LEFT);
          robot.keyRelease(KeyEvent.VK_LEFT);
        }
      }
    }
  }
}

public void connect() {
  try {
    ws = new WebSocketFactory().createSocket(WSlink);
    ws.connect();
    socketcreated = true;
    ws.addListener(new WebSocketAdapter() {
      public void onTextMessage(WebSocket websocket, String message) throws Exception {
        webSocketEvent(message);
      }
    }
    );
    connected = true;
    println("succes");
    WSerror = "succes";
    firstConnect = true;
  }
  catch(Exception e)
  {
    connected = false;
    println("Connection Failed for Reason: "+ e.toString());
    WSerror = "Failed to connect";
  };
}



void CheckSocket() {
  if (connected == true) {
    cw = color(0, 255, 0);
  } else {
    cw = color(255, 0, 0);
    connect();
  };

  if (socketcreated.equals(true)) {
    boolean check = ws.isOpen();
    if (check == true) {
      connected = true;
    } else {
      connected = false;
    };
  }
}
