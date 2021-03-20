//Interfacing ESP8266 Wi-Fi with STM32F103C8
/*
FTDI | stm32f103
RX   | TX1 (PC9)
TX   | RX1 (PC10)
GND  | GND
3.3V | 3.3V

stm32f103 | ESP01
GND       | GND
3.3V      | 3.3V
3.3V      | CH-PD
PC3 (RX2) | TX
PC2 (TX2) | RX

1000uF capacitor between power and ground (to prevent power issues)

*/

char incomingByte = 0;
char message[100] = {0};
int idx = 0;

void setup()
{
   Serial.begin(9600);
   while (!Serial);
   Serial2.begin(9600);   //begins serial communication with esp8266 with baud rate 9600 (Change according to your esp8266 module)
   while (!Serial2);
   Serial.println("serial port setup completed...");
}

void loop() {
  if (Serial2.available() > 0) {
    incomingByte = (char) Serial2.read();
    if( incomingByte == '\n' ) {
      idx = 0;
      if( strlen(message) > 0 ) {
        Serial.print("message: ");
        Serial.println(message);
      }
      /* if( strncmp(message, "start", 5) == 1 ) { */
        Serial2.println("test");
      /* } */
      memset(message, '\0', sizeof(message));
    } else {
      message[idx] = incomingByte;
      idx++;
    }
  } else {
  }
}
