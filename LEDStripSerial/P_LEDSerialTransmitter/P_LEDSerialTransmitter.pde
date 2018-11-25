
import processing.serial.*;

char START = 255;
char END = 254;



// The serial port:
Serial myPort;

final static int START_POS = 0;
final static int DISPLAY_SIZE = 3;

color[] displayBuffer;
color initColor = color(0, 0, 0);



void setup() {
  
  initDisplayBuffer();
   
  // List all the available serial ports:
  printArray(Serial.list());

  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[5], 115200);

}

void draw() {
  

  
}

void initDisplayBuffer() {
  
  displayBuffer = new color[DISPLAY_SIZE];
  for(int i = START_POS; i < DISPLAY_SIZE; i++) {    // initialize display with black
    displayBuffer[i] = initColor; 
  }  
  
}


void transmitFullBuffer() {
  
  myPort.write(START);
  
  for (int pixel = 0; pixel < DISPLAY_SIZE; pixel++){
    //int pixel = 0;
    
    myPort.write(byte(red(displayBuffer[pixel])));
    myPort.write(byte(green(displayBuffer[pixel])));
    myPort.write(byte(blue(displayBuffer[pixel])));  
  }
  
  myPort.write(END);
}



void keyPressed() {

    if (key == 'l') {
      
      displayBuffer[0] = color(250,0,0);
      displayBuffer[1] = color(0,250,0);
      displayBuffer[2] = color(0,0,250);
      
      transmitFullBuffer();
    }
  
    if (key == 'm') {
      
      displayBuffer[0] = color(250,250,250);
      displayBuffer[1] = color(250,250,250);
      displayBuffer[2] = color(250,250,250);
      
      transmitFullBuffer();
    }    
    
}
