
import processing.serial.*;

// protocol stuff
// IMPORTANT: color value cannot be higher than 254
char START = 255;
char END = 254;

// The serial port:
Serial myPort;

final static int START_POS = 0;
final static int DISPLAY_SIZE = 3;

// some vairables to make single frame testing easier
color[] displayBuffer;
color initColor = color(0, 0, 0);

// some variables to make animation testing easier
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
  //printArray(Serial.list());

  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[5], 115200);

}

int frame = 0;

void draw() {
  
  if (animate) {      // if animation enabled, then play it on a loop
 
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

//  advances frame if possible, if not loop back to zero
void nextFrame() {
 
  if (frame < animNumberFrames-1) {
    frame++;
  } else {
    frame = 0;
  } 
}


// initialize buffer with an initial color
void initDisplayBuffer() {
  displayBuffer = new color[DISPLAY_SIZE];
  for(int i = START_POS; i < DISPLAY_SIZE; i++) {    // initialize display with black
    displayBuffer[i] = initColor; 
  }   
}


// create animation with progrmmatically, for testing purposes
void initAnimation() {
  
  // initialize animation buffer with a single color
  animation = new color[animNumberFrames][animNumberPixels];
  for(int p = 0; p < animNumberPixels; p++) {    
    for (int f = 0; f < animNumberFrames; f++) {
      animation[f][p] = B;         // initialize all pixels in all frames with black
    }
  }   
  
  // then add a simple moving  dot animation
  for (int i = 0; i < 30; i++) {  
    animation[i][i] = Y; 
  }
 
}



// this transmits a single buffer frame to led strip
void transmitFullBuffer() {
  
  myPort.write(START);      // start byte to indicate new message
  
  for (int pixel = 0; pixel < DISPLAY_SIZE; pixel++){
    myPort.write(byte(red(displayBuffer[pixel])));
    myPort.write(byte(green(displayBuffer[pixel])));
    myPort.write(byte(blue(displayBuffer[pixel])));  
  }
  
  myPort.write(END);      // end byte to indicate message sending is over
}



void keyPressed() {

  // turns on strip animation
  if (key == 'e') {
    animate = true;
  }
  
  
  // sends a single frame to LED strip
  if (key == 'l') {
    
    displayBuffer[0] = color(250,0,0);
    displayBuffer[1] = color(0,250,0);
    displayBuffer[2] = color(0,0,250);
    
    transmitFullBuffer();
  }

  // sends a single frame to LED strip
  if (key == 'm') {
    
    displayBuffer[0] = color(250,250,250);
    displayBuffer[1] = color(250,250,250);
    displayBuffer[2] = color(250,250,250);
    
    transmitFullBuffer();
  }    
    
}
