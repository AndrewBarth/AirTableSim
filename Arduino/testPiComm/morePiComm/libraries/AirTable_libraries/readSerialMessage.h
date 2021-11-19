/*
    Purpose:
        Prototype for reading message over a serial connection

    Dependencies:
        Arduino library (to get the String class)
	serial library

    Assumptions/Limitations:
        None

    Modification History:
        11/2015 - Initial version

*/

#include <Arduino.h>
#include <string.h>

#ifndef READSERIALMESSAGE_H
#define READSERIALMESSAGE_H

int read_serial_message(HardwareSerial&, String *, int);

#endif
