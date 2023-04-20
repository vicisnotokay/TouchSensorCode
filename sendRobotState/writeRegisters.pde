class RobotControl
{
ModbusClient writeClient;
String serverIP;
int serverPort = 502;
int robotState = 0;
int regNumber = 200;


    RobotControl(String _serverIP, int _serverPort, int _regNumber)
    {
        
        serverIP = _serverIP;
        serverPort = _serverPort;
        regNumber = _regNumber;
        
        
    }

    void connect()
    {
        writeClient = new ModbusClient(serverIP, serverPort);

        try
        {
            writeClient.Connect();
            println("Connected to server");
        }
        catch (Exception e)
        {
            println("Error connecting to server");
        }
        
    }

    void sendRobotState()
    {
        if(writeClient.isConnected())
        {
            stroke(0, 255, 0);
            strokeWeight(10);
            noFill();
            rect(0,0, width, height);
            try
            {
                writeClient.WriteSingleRegister(regNumber, robotState);
               // println("Sent state: " + robotState);
            }
            catch (Exception e)
            {
                println("Error sending state");
            }
        }
        else
        {

            println("Not connected to server");
            connect();
        }

    }


void oscEvent(OscMessage theOscMessage) {
  println(theOscMessage);
  if (theOscMessage.checkAddrPattern(addressName)==true) {
    robotState = theOscMessage.get(0).intValue();
    println("Received state: " + robotState);
    sendRobotState();
  }
}

 







}
