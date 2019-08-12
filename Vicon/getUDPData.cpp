
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <iostream>

int getUDPData(int handle, char *packet_data) {

   struct sockaddr_in cliaddr;
   socklen_t len= sizeof(cliaddr); 

   //int received_bytes = recvfrom( handle, packet_data, sizeof(&packet_data),0, (struct sockaddr*)&cliaddr, &len );
   int received_bytes = recvfrom( handle, packet_data, 1024,0, (struct sockaddr*)&cliaddr, &len );
   if ( received_bytes > 0 ) {
   //   printf("name %c%c%c%c%c%c%c%c\n",packet_data[8],packet_data[9],packet_data[10],packet_data[11],packet_data[12],packet_data[13],packet_data[14],packet_data[15]);
   }
   return 0;
}

