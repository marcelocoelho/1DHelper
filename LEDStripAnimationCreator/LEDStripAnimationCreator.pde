
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
  
  frameRate(1);
  
  animation = Gif.getPImages(this, "Animation.gif");
  animationSize = animation.length; 
  currentFrame = 0;
 
  displayBuffer = new color[animationSize]; 
 
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[5], 115200);
 
}

void draw() {
 
  image(animation[nextFrame()], 0,0);    // displays image on screen
 
 //println(animation[nextFrame()].width); // grabing pixel width of GIF
 //println(int(red(animation[nextFrame()].pixels[15])));
 
   // move all pixels in GIF frame to display buffer
   for (int i = 0; i < animation[0].width; i++) {
     displayBuffer[i] = animation[nextFrame()].pixels[i];
   }
 
 
  transmitFullBuffer();
 
  
}



void transmitFullBuffer() {
  
  myPort.write(START);
  
  for (int pixel = 0; pixel < DISPLAY_SIZE; pixel++){
    //int pixel = 0;
    
    //myPort.write(safe(byte(red(displayBuffer[pixel]))));
    
    myPort.write(safeRed(displayBuffer[pixel]));
    myPort.write(safeRed(displayBuffer[pixel]));
    myPort.write(safeRed(displayBuffer[pixel]));
    
    //myPort.write(safeColor(red(displayBuffer[pixel])));
    //myPort.write(byte(green(displayBuffer[pixel])));
    //myPort.write(byte(blue(displayBuffer[pixel])));  
  }
  
  myPort.write(END);
}


byte safeRed(color _c) {
  
  byte limitColor = byte(253);
  
  if (int(red(_c)) > limitColor) {
      _c = limitColor;
  } 
    
  return limitColor;
    
}



// little helper function to advance frames and loop 
int nextFrame() {
  if (currentFrame < animationSize-1) {
    currentFrame++;
  } else {
    currentFrame = 0;
  }
  return currentFrame;
}
