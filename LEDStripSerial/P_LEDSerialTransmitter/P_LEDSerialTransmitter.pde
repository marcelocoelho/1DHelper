
import processing.serial.*;

// The serial port:
Serial myPort;

final static int START_POS = 0;
final static int DISPLAY_SIZE = 3;

color[] displayBuffer;
color initColor = color(0, 0, 0);



void setup() {
  
  displayBuffer = new color[DISPLAY_SIZE];
  for(int i = START_POS; i < DISPLAY_SIZE; i++) {    // initialize display with black
    displayBuffer[i] = initColor; 
  }
  
  displayBuffer[0] = color(125,1,1);
  displayBuffer[1] = color(1,125,1);
  displayBuffer[2] = color(1,1,125);
  
  
  // List all the available serial ports:
  printArray(Serial.list());

  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[5], 115200);



}

void draw() {
  
  // Send a capital "A" out the serial port
  //myPort.write(65);
  
  //myPort.write(displayBuffer);
  
  /*
  for(int i = START_POS; i < DISPLAY_SIZE; i++) {    // initialize display with black
    println(displayBuffer[0]);
    myPort.write(byte(red(displayBuffer[0])));
    //displayBuffer[i] = initColor; 
  }
  */
  
  
}


void keyPressed() {

    //myPort.write(98);
    
    if (key == 'a') {
      myPort.write(byte(red(displayBuffer[0])));
      myPort.write(byte(green(displayBuffer[0])));
      myPort.write(byte(blue(displayBuffer[0]))); 
      myPort.write(0);
      
    }
    
    if (key == 's') {
      myPort.write(byte(red(displayBuffer[1])));
      myPort.write(byte(green(displayBuffer[1])));
      myPort.write(byte(blue(displayBuffer[1])));  
      myPort.write(0);
    }
    
    if (key == 'd') {
      myPort.write(byte(red(displayBuffer[2])));
      myPort.write(byte(green(displayBuffer[2])));
      myPort.write(byte(blue(displayBuffer[2])));  
      myPort.write(0);      
    }    
    

}
