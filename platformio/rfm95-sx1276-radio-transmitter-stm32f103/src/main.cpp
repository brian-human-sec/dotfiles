// Arduino9x_RX
// -*- mode: C++ -*-
// Example sketch showing how to create a simple messaging client (receiver)
// with the RH_RF95 class. RH_RF95 class does not provide for addressing or
// reliability, so you should only use RH_RF95 if you do not need the higher
// level messaging abilities.
// It is designed to work with the other example Arduino9x_TX

#include <SPI.h>
#include <RH_RF95.h>

/*

 RF95    | Arduino Uno | stm32f103
 ---------------------------------
 GND     | ??          | ??
 3.3V    | VCC         | 3.3
 DIO0    | 2           | B0 digital (PB0)
 NSS     | 10 (SS)     | A4 NSS1 (PA4) 3.3v
 SCK     | 13 (SCK)    | A5 SCK1   (PA5) 3.3v
 MISI    | 11 (MOSI)   | A7 MISI1  (PA7) 3.3v
 MISO    | 12 (MOS0)   | A6 MOSO1  (PA6) 3.3v
 RST     |             | B1

 */

#define RFM95_CS PA4
#define RFM95_RST PB1
#define RFM95_INT PB0

// Change to 434.0 or other frequency, must match RX's freq!
#define RF95_FREQ 915.0

// Singleton instance of the radio driver
RH_RF95 rf95(RFM95_CS, RFM95_INT);

// Blinky on receipt
#define LED PC13

int consecutiveLoopCount = 0;
int16_t packetnum = 0;  // packet counter, we increment per xmission

void setup() {
  pinMode(LED, OUTPUT);
  pinMode(RFM95_RST, OUTPUT);
  digitalWrite(RFM95_RST, HIGH);

  while (!Serial);
  Serial.begin(9600);
  delay(100);

  Serial.println("LoRa TX");

  // manual reset
  digitalWrite(RFM95_RST, LOW);
  delay(10);
  digitalWrite(RFM95_RST, HIGH);
  delay(10);

  while (!rf95.init()) {
    Serial.println("LoRa radio init failed");
    while (1);
  }
  Serial.println("LoRa radio init OK!");

  // Defaults after init are 434.0MHz, modulation GFSK_Rb250Fd250, +13dbM
  if (!rf95.setFrequency(RF95_FREQ)) {
    Serial.println("setFrequency failed");
    while (1);
  }
  Serial.print("Set Freq to: ");
  Serial.println(RF95_FREQ);

  // Defaults after init are 434.0MHz, 13dBm, Bw = 125 kHz, Cr = 4/5, Sf = 128chips/symbol, CRC on

  // The default transmitter power is 13dBm, using PA_BOOST.
  // If you are using RFM95/96/97/98 modules which uses the PA_BOOST transmitter pin, then
  // you can set transmitter powers from 5 to 23 dBm:
  rf95.setTxPower(23, false);
  Serial.println("setup complete");
}

void loop() {
  Serial.println("Sending message to receiver");
  // Send a message to rf95_server

  char radiopacket[20] = "Hello World #      ";
  itoa(packetnum++, radiopacket+13, 10);
  Serial.print("Sending: ");
  Serial.println(radiopacket);
  radiopacket[19] = 0;
  if( rf95.isChannelActive() ) {
    Serial.println("channel is alive");
  } else {
    Serial.println("channel is NOT alive");
  }
  delay(10);
  rf95.send((uint8_t *)radiopacket, 20);
  Serial.println("Waiting for packet to complete...");
  delay(10);
  /* rf95.waitPacketSent(100); */
  /* rf95.waitPacketSent(); */
  /* rf95.waitAvailableTimeout(100); */
  Serial.println("message sent");
  /* // Now wait for a reply */
  /* uint8_t buf[RH_RF95_MAX_MESSAGE_LEN]; */
  /* uint8_t len = sizeof(buf); */

  /* Serial.println("Waiting for reply..."); */
  /* delay(10); */
  /* if (rf95.waitAvailableTimeout(1000)) { */
  /*   // Should be a reply message for us now */
  /*   if (rf95.recv(buf, &len)) { */
  /*     Serial.print("Got reply: "); */
  /*     Serial.println((char*)buf); */
  /*     Serial.print("RSSI: "); */
  /*     Serial.println(rf95.lastRssi(), DEC); */
  /*   } else { */
  /*     Serial.println("Receive failed"); */
  /*   } */
  /* } else { */
  /*   Serial.println("No reply, is there a listener around?"); */
  /* } */
  delay(5000);
}
