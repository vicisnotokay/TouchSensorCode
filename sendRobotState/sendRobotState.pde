import websockets.*;
import netP5.*;
import oscP5.*;


JSONObject projectSettings;




int portNumber = 502;
//String robotIP = "192.168.1.100";
String robotIP = "10.88.111.40";
RobotControl tellRobot;


//osc setup
OscP5 oscP5;
int sendPort = 8000;
int listenPort = 9000;
String sendIP = "localhost";
int registerNumber = 200;
String addressName = "/robotState";

void setup()
{
size(500, 240);


projectSettings = loadJSONObject("settings.json");
robotIP = projectSettings.getString("robotIP");
registerNumber = projectSettings.getInt("registerNumber");
addressName = projectSettings.getString("addressName");


//connect to the robot
tellRobot = new RobotControl(robotIP, portNumber, registerNumber);
tellRobot.connect();
rectMode(CORNERS);

oscP5 = new OscP5(this, listenPort);




}



void draw()
{
background(0);
fill(255);
tellRobot.sendRobotState();
textSize(40);
text("Robot IP: " + robotIP, 10, 50);
textSize(20);
text("Register Number: " + registerNumber, 10, 80);
text("OSC message address: " + addressName, 10, 110);
text("OSC message port: " + listenPort, 10, 140);
textSize(40);
text("Robot State: " + tellRobot.robotState, 10, 200);


}
public float roundTo(float thenumber, int decimalPlaces)
{
 float rFloat = thenumber;
 String rString = "";

try {
    rString = nf(thenumber,0,decimalPlaces);
}
catch(ArrayIndexOutOfBoundsException exception) {
    
}

if(rString.length()>0)
{
  rFloat = Float.parseFloat(rString);
}  
  return rFloat;
}
void oscEvent(OscMessage theOscMessage) {
 // println(theOscMessage);
  if (theOscMessage.checkAddrPattern(addressName)==true) {
    tellRobot.robotState = theOscMessage.get(0).intValue();
    //println("Received state: " + tellRobot.robotState);
    tellRobot.sendRobotState();
  }
}
