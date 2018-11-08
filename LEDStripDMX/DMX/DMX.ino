#include "DmxReceiver.h"
DmxReceiver DMX = DmxReceiver();

void setup() {
        DMX.begin();
        Serial.begin(115200);
        pinMode(13, OUTPUT);
}

void loop() {
  DMX.bufferService();
  delay(2);
  if (DMX.newFrame())
        {
          digitalWrite(13, HIGH);
          Serial.println(DMX.getDimmer(1), DEC);
        }
}
