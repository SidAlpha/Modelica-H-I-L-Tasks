#include <PID_v1.h>
double Input, Output, Setpoint;
double kp, ki, kd;
bool newData;

PID myPID(&Input, &Output, &Setpoint, kp, ki, kd, DIRECT);
void setup()
{
  Serial.begin(115200); //serial begin
}

void loop()
{
  String readStr = ""; //some variables
  String readVal = "";
  
  
  if (Serial.available())
  { //when serial data comes from modelica
  while(Serial.available())
  {
    char readChar = (char)Serial.read();
    readStr+=readChar; 
    if(readChar == '\n') break;
  } //read the data and store in a string
    for (int i = 1; i < (readStr.length()-1); i++)
    {
      readVal += readStr[i];  
    }
    Setpoint = ((double)analogRead(A5))/4; 
    Input = readVal.toDouble(); //extract value
    myPID.Compute();
    double x = Output;
    Serial.println("1,"+String(x)+"\n"); //send data in same format i.e. ending with \n character
    delay(5);
  } 
}
