// ********************************************************************
//
// Don't forget to install the Fastled library for this example to work
//
// ********************************************************************


// Adding the library
#include "FastLED.h"

// How many leds in your strip?
#define NUM_LEDS 30

// Define what pins you are using for data and clock line
#define DATA_PIN A1 //3
#define CLOCK_PIN A2 //2

// Define the array of leds
// Nothing to change here
CRGB leds[NUM_LEDS];

int incomingByte;

void setup() {

  // This is where we configure what LED strip we are using and what pins control it
  FastLED.addLeds<APA102, DATA_PIN, CLOCK_PIN, BGR>(leds, NUM_LEDS);

  Serial.begin(115200);

  pinMode(13, OUTPUT);

  //clean up
  for (int i = 0; i < NUM_LEDS; i++){
    leds[i] = CRGB(0,0,0);
  }
  FastLED.show();
  

}


//#define pixelNumber 3

int colorIndex = 0;
unsigned char colorFrame[3*NUM_LEDS];
int colorSelect = 0;
bool writingFrame = false;


void processByte(unsigned char currentByte) {


  // Toggle based on START = 255 and END = 254 bytes
  if (currentByte == 255) {
    writingFrame = true;  // a messsage has started
    digitalWrite(13,HIGH);
    
  } else if (currentByte == 254) {
    writingFrame = false; // a message has ended
    digitalWrite(13,LOW);

    // now let's show what we got
    colorIndex = 0;

    //int i = 0;
    for (int i = 0; i < NUM_LEDS; i++){
      leds[i] = CRGB(colorFrame[(i*3)],colorFrame[(i*3)+1],colorFrame[(i*3)+2]);
    }
    FastLED.show();

  }


  
  if (writingFrame == true) {     // then read incoming data and assign to array

    if (currentByte != 255) {     // but make sure to ignore start byte
      colorFrame[colorIndex] = currentByte;
      colorIndex++;
    }
  }

}



void loop() {


 int bytesRead=0;
  while (Serial.available() > 0 && bytesRead<30000) {
    processByte(Serial.read()); bytesRead++;
  }


}
