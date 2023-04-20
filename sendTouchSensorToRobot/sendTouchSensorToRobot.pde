import netP5.*;
import oscP5.*;

import processing.serial.*;
import cc.arduino.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


Arduino arduino;

color off = color(4, 79, 111);
color on = color(84, 145, 158);

int readPin = 2;
int currentRead;

void setup() {
  size(400, 400);

  arduino = new Arduino(this, Arduino.list()[1], 57600);
  arduino.pinMode(readPin, Arduino.INPUT);
  
  
  // initialize OSC client
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 9000);
}

void draw() {
  background(off);

  currentRead = arduino.digitalRead(readPin);
  
  if(currentRead==1)
  {
    background(on);
  }
  
  else
  {
  background(off);
  }
  
  OscMessage myMessage = new OscMessage("/robotState");
  myMessage.add(currentRead);
  oscP5.send(myMessage, myRemoteLocation);
  

}
