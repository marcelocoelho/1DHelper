
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
  
  // Add some random colors for testing
  displayBuffer[0] = color(250,0,0);
  displayBuffer[1] = color(0,250,0);
  displayBuffer[2] = color(0,0,250);
  
  
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




void transmitPixel(int _pixelNumber) {
  
      myPort.write(START);
      myPort.write(_pixelNumber);
      myPort.write(byte(red(displayBuffer[_pixelNumber])));
      myPort.write(byte(green(displayBuffer[_pixelNumber])));
      myPort.write(byte(blue(displayBuffer[_pixelNumber]))); 
      myPort.write(0);
  
}


void keyPressed() {

    if (key == 'l') {
      transmitFullBuffer();
    }
  
    //myPort.write(98);
    
    if (key == 'a') {
      
      transmitPixel(0);
      
    }
    
    if (key == 's') {
      
      transmitPixel(1);
      
    }
    
    if (key == 'd') {
      
      transmitPixel(2);      
         
    }    
    

}
