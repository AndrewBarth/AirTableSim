
   // Define Pins
   const int relayPin1 = 2;
   const int relayPin2 = 3;
   const int relayPin3 = 4;
   const int relayPin4 = 5;

   const int ledPin = LED_BUILTIN;

void setup() {

   // Set output pins for relays
   pinMode(relayPin1,OUTPUT);
   pinMode(relayPin2,OUTPUT); 
   pinMode(relayPin3,OUTPUT); 
   pinMode(relayPin4,OUTPUT); 

   pinMode(ledPin,OUTPUT);

}

void loop() {
  
   delay(1000);
   // Turn on relay 1
   setRelays(HIGH,LOW,LOW,LOW);
    
   delay(1000); 
   // Turn on relay 2
   setRelays(LOW,HIGH,LOW,LOW);
  
   delay(1000);
   // Turn on relay 3
   setRelays(LOW,LOW,HIGH,LOW);

   delay(1000);
   // Turn on relay 4
   setRelays(LOW,LOW,LOW,HIGH);

   delay(1000);
   // Turn off all relays
   setRelays(LOW,LOW,LOW,LOW);

   // Blink the LED
   delay(1000);
   digitalWrite(ledPin,HIGH);
   delay(1000);
   digitalWrite(ledPin,LOW);
   delay(1000);
   digitalWrite(ledPin,HIGH);
   delay(1000);
   digitalWrite(ledPin,LOW);
   delay(1000);
   digitalWrite(ledPin,HIGH);
   delay(1000);
   digitalWrite(ledPin,LOW);

   //while(1);
   
   
}

void setRelays(unsigned char R1, unsigned char R2, unsigned char R3, unsigned char R4) {
  digitalWrite(relayPin1, R1);
  digitalWrite(relayPin2, R2);
  digitalWrite(relayPin3, R3);
  digitalWrite(relayPin4, R4);

}
