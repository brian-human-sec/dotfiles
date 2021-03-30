#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

//ws2812b

#define PIN 6

#define pixelCount 16

// When we setup the NeoPixel library, we tell it how many pixels, and which pin to use to send signals.
// Note that for older NeoPixel strips you might need to change the third parameter--see the strandtest
// example for more information on possible values.
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(pixelCount, PIN, NEO_GRB + NEO_KHZ800);


void setup() {
  Serial.begin(9600);
  while( !Serial);
  Serial.println("setup");
  pixels.begin();
  Serial.println("setup completed...");
}

void loop() {
  pixels.show();
  for( unsigned int idx = 0; idx < pixelCount; idx++ ) {
    pixels.setPixelColor(idx, pixels.Color(200,0,0)); // red
    pixels.show();
    delay(1000);
  }

  pixels.clear();

  pixels.show();
  for( unsigned int idx = 0; idx < pixelCount; idx++ ) {
    pixels.setPixelColor(idx, pixels.Color(255,255,102)); // yellow
    pixels.show();
    delay(1000);
  }

  pixels.clear();

  pixels.show();
  for( unsigned int idx = 0; idx < pixelCount; idx++ ) {
    pixels.setPixelColor(idx, pixels.Color(0,150,0)); // green
    pixels.show();
    delay(1000);
  }

  pixels.clear();

  Serial.println("end of loop");
}
