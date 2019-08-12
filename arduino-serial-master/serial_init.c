
#include <unistd.h>
#include "arduino-serial-lib.h"

int serial_init();

int serial_init( )
{

   int fd = 0;
   char serialport[256];

   //int baudrate = 9600;
   int baudrate = 57600;

   char buf[20], dat[20], use[1];

   int rc, n;

   fd = serialport_init("/dev/ttyACM0",baudrate);
   if (fd == -1) return -1;

   usleep(3000000);

   return fd;

}
