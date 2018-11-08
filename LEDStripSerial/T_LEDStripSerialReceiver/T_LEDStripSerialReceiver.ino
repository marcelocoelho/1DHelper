// ********************************************************************
//
// Don't forget to install the Fastled library for this example to work
//
// ********************************************************************


// Adding the library
#include "FastLED.h"

// How many leds in your strip?
#define NUM_LEDS 10

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

}

unsigned char colorFrame[3];
int colorSelect = 0;

void processByte(unsigned char currentByte) {

  if (currentByte != 0) {

      colorFrame[colorSelect] = currentByte;
      colorSelect++;
      
  } else if  (currentByte == 0) {
    colorSelect = 0;
    
  }
  
}


void loop() {


 int bytesRead=0;
  while (Serial.available() > 0 && bytesRead<30000) {
    processByte(Serial.read()); bytesRead++;
  }

  colorSelect = 0;

  leds[0] = CRGB(colorFrame[0],colorFrame[1],colorFrame[2]);
  FastLED.show();
  





/*
if (Serial.available()) {
    incomingByte = Serial.read();  // will not be -1
    digitalWrite(13, HIGH);
    //Serial.println("y");
    delay(100);
    digitalWrite(13, LOW);
    // actually do something with incomingByte
  }
*/
  
  /*
    for (int i = 0; i < NUM_LEDS; i++) {
      leds[i] = CRGB::White;  // Load array with LED values
      FastLED.show();         // Display what is in array
      delay(20);             // Do nothing for certain amount of time
      
      //leds[i] = CRGB::Black;  // Load array with new LED value
      //FastLED.show();         // Turn off
    }

    for (int i = 0; i < NUM_LEDS; i++) {
      leds[i] = CRGB::Black;  // Load array with LED values
      FastLED.show();         // Display what is in array
      delay(20);             // Do nothing for certain amount of time

    }
    */
    //Serial.println("y");

}
