
import gifAnimation.*;

PImage[] animation;
int animationSize;
int currentFrame;

color[] displayBuffer;


import processing.serial.*;
Serial myPort;

char START = 255;
char END = 254;

final static int DISPLAY_SIZE = 30;



public void setup() {
  size(30, 1);
  
  frameRate(30);
  
  animation = Gif.getPImages(this, "Animation.gif");
  animationSize = animation.length; 
  currentFrame = 0;
 
  displayBuffer = new color[animationSize]; 
 
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[5], 115200);
 
}

void draw() {
 
  image(animation[nextFrame()], 0,0);    // displays image on screen
 
   // move all pixels in current GIF frame to display buffer
   int frameToShow = nextFrame();
   for (int i = 0; i < animation[0].width; i++) {
     displayBuffer[i] = animation[frameToShow].pixels[i];
   }
 
  transmitFullBuffer();
}



// Transmits current frame on screen
void transmitFullBuffer() {
  
  myPort.write(START);
  
  for (int pixel = 0; pixel < DISPLAY_SIZE; pixel++){
    myPort.write(byte(safe(red(displayBuffer[pixel]))));
    myPort.write(byte(safe(green(displayBuffer[pixel]))));
    myPort.write(byte(safe(blue(displayBuffer[pixel]))));  
  }
  
  myPort.write(END);
}


// this makes sure values don't overlap with START and END commands
float safe (float _c) {
  
  if (_c > 253) {
    _c = 253;
  }
  
  return _c;
}



// Little helper function to advance frames and loop 
int nextFrame() {
  if (currentFrame < animationSize-1) {
    currentFrame++;
  } else {
    currentFrame = 0;
  }
  return currentFrame;
}
