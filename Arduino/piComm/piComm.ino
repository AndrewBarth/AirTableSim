
// Libraries
// Don't need this for now
//#include <readSerialMessage.h>

// Define Pins
const int relayPin1 = 2;
const int relayPin2 = 3;
const int relayPin3 = 4;
const int relayPin4 = 5;
const int relayPin5 = 6;
const int relayPin6 = 7;
const int relayPin7 = 8;
const int relayPin8 = 9;
const int relayPins[] = {2,3,4,5,6,7,8,9};

const int ledPin = LED_BUILTIN;

// Constants
const int nRelays = 8;

// Variables
int relayCmds[nRelays];
char cmds[8];

void setup() {

   // Set output pins for relays
   for (int i=0; i<nRelays; i++) {
    pinMode(relayPins[i],OUTPUT);
   }
   pinMode(ledPin,OUTPUT);

   // Start the Serial communication
   Serial.begin(57600);
}

void loop() {

   if (Serial.available() > 0) {
    // Read in a string of data
    Serial.readBytes(cmds,8);
    //Serial.println(cmds);
    
    // Default the command to 0 unless given a specific command
    for (int i = 0; i<nRelays; i++) {
      relayCmds[i] = 0;
    }
    // Default pin 4 to opposite polarity
    // There is an unknown problem with the 4th relay
    relayCmds[3] = 1;


    // Loop through the received command and set the appropriate command for the relay
    for (int i = 0; i<(sizeof(cmds)); i++) {
      if (cmds[i] == '1') {
        relayCmds[i] = 1;
        // polarity on pin 4 is opposite
        if (i == 3) {
          relayCmds[i] = 0;
        }
      }
    }

//    // Check that commands were processed successfully
//    for (int k=0; k<nRelays; k++) {
//      Serial.print("The Command: ");
//      Serial.println(relayCmds[k]);
//    }

    // Send the commands to the relays
    cmdRelays(relayPins,nRelays,relayCmds);

//    Serial.flush();
   }
   
   // Uncomment this to only run loop once
   //while(1);
   
   
}

// This function writes the command data to the relay output pins
void cmdRelays(const int relayPins[], int nRelays, int relayCmds[]) {
  for (int i=0; i<nRelays; i++) {
    digitalWrite(relayPins[i],relayCmds[i]);
  }
}

// This function can be used to manually set the values of the relay commands
void setRelays(unsigned char R1, unsigned char R2, unsigned char R3, unsigned char R4, 
               unsigned char R5, unsigned char R6, unsigned char R7, unsigned char R8) {
  digitalWrite(relayPin1, R1);
  digitalWrite(relayPin2, R2);
  digitalWrite(relayPin3, R3);
  digitalWrite(relayPin4, R4);
  digitalWrite(relayPin5, R5);
  digitalWrite(relayPin6, R6);
  digitalWrite(relayPin7, R7);
  digitalWrite(relayPin8, R8);
}
