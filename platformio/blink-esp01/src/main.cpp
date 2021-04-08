#include <ESP8266WiFi.h>
#include "config.h"
/*
  Hardware
  ========
  ESP01 programmer (modified)
  to program ensure the connection
  unplug after programming
*/

const short int ledBuiltin = 2; //GPIO2, the LED_BUILTIN is incorrectly set to 1
void connectToWifi();

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup");
  pinMode(ledBuiltin, OUTPUT);

  connectToWifi();
  WiFi.mode(WIFI_STA); //We don't want the ESP to act as an AP
  Serial.println("setup complete");
}

void loop() {
  Serial.println("Hello from ESP01");
  digitalWrite(ledBuiltin, HIGH);
  delay(1000);
  digitalWrite(ledBuiltin, LOW);
  delay(1000);
}

void connectToWifi() {
  WiFi.begin(ssid, password);
  Serial.println("Connecting to WiFi.");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
}
