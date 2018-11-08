import dmxP512.*;
import processing.serial.*;

DmxP512 dmxOutput;
int universeSize=128;

boolean LANBOX=false;
String LANBOX_IP="192.168.1.77";

boolean DMXPRO=true;
String DMXPRO_PORT="5";//case matters ! on windows port must be upper cased.
int DMXPRO_BAUDRATE=250000;


void setup() {
  
  size(245, 245, JAVA2D);  
  
   //printArray(Serial.list());

  
  dmxOutput=new DmxP512(this,universeSize,false);
  
  if(LANBOX){
    dmxOutput.setupLanbox(LANBOX_IP);
  }
  
  if(DMXPRO){
    dmxOutput.setupDmxPro(Serial.list()[5],DMXPRO_BAUDRATE);
  }
   
}

void draw() {   
  
  //dmxOutput.set(1,100);
  
  int nbChannel=20;  
  background(0);
  for(int i=0;i<nbChannel;i++){
    int value=(int)random(10)+((i%2==0)?mouseX:mouseY);
    dmxOutput.set(i,value);
    fill(value);
    rect(0,i*height/10,width,(i+10)*height/10);    
  }
  
}
