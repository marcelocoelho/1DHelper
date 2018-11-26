
import processing.serial.*;

char START = 255;
char END = 254;



// The serial port:
Serial myPort;

final static int START_POS = 0;
final static int DISPLAY_SIZE = 3;

color[] displayBuffer;
color initColor = color(0, 0, 0);


color[][] animation;
int animNumberFrames = 30;
int animNumberPixels = 30;
color W = color(253, 253, 253);
color BCK = color(0, 0, 0);
color R = color(253, 0, 0);
color G = color(0, 253, 0);
color B = color(0, 0, 253);
color Y = color(253, 253, 0);
boolean animate = false;





void setup() {
  
  frameRate(60);
  
  initDisplayBuffer();
  initAnimation();
   
  // List all the available serial ports:
  printArray(Serial.list());

  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[5], 115200);

}

int frame = 0;

void draw() {
  
  if (animate) {
 
    // this is one frame
    myPort.write(START);
    for (int pixel = 0; pixel < animNumberPixels-1; pixel++){
      myPort.write(byte(red(animation[frame][pixel])));
      myPort.write(byte(green(animation[frame][pixel])));
      myPort.write(byte(blue(animation[frame][pixel])));  
    }
    myPort.write(END);    
    
    nextFrame();
    
  }

  
}

void nextFrame() {
 
  if (frame < animNumberFrames-1) {
    frame++;
  } else {
    frame = 0;
  }
  
}


void initDisplayBuffer() {
  
  displayBuffer = new color[DISPLAY_SIZE];
  for(int i = START_POS; i < DISPLAY_SIZE; i++) {    // initialize display with black
    displayBuffer[i] = initColor; 
  }   
}


void initAnimation() {
  
  animation = new color[animNumberFrames][animNumberPixels];
  for(int p = 0; p < animNumberPixels; p++) {    
    for (int f = 0; f < animNumberFrames; f++) {
      animation[f][p] = B;         // initialize all pixels in all frames with black
    }
  }   
  
  // simple moving  dot animation
  for (int i = 0; i < 30; i++) {  
    animation[i][i] = Y; 
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

  if (key == 'e') {
    animate = true;
  }
  
  
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
