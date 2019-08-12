
//#include "Linux32/DataStreamClient.h"
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

int initializeUDP(int *handle);
int getUDPData(int handle, char *packet_data);

/*
int initializeUDP(int *handle) {


    *handle = socket( AF_INET, SOCK_DGRAM, 0 );
    if(*handle < 0){
       perror("socket");
       return(-1);
    } else {
      printf("test\n");
    }

    struct sockaddr_in servaddr;
    servaddr.sin_family = AF_INET;
    servaddr.sin_port=htons(51001);
    servaddr.sin_addr.s_addr=htonl(INADDR_ANY);

    if ( bind( *handle, (struct sockaddr*)&servaddr, sizeof(servaddr) ) < 0 ){
	perror("bind");
	return(-1);
    }

    return 0;
}
*/

/*
int getUDPData(int handle, char *packet_data) {

                double tx;
                double ty;
                double rz;
   struct sockaddr_in cliaddr;
   socklen_t len= sizeof(cliaddr); 

   //int received_bytes = recvfrom( handle, packet_data, sizeof(&packet_data),0, (struct sockaddr*)&cliaddr, &len );
   int received_bytes = recvfrom( handle, packet_data, 1024,0, (struct sockaddr*)&cliaddr, &len );
   if ( received_bytes > 0 ) {
      printf("name %c%c%c%c%c%c%c%c\n",packet_data[8],packet_data[9],packet_data[10],packet_data[11],packet_data[12],packet_data[13],packet_data[14],packet_data[15]);
           memcpy(&tx,&packet_data[32],8*sizeof(char));
           memcpy(&ty,&packet_data[40],8*sizeof(char));
           memcpy(&rz,&packet_data[72],8*sizeof(char));
             printf("tx %10.3f\nty %10.3f\n",tx,ty);
             printf("rz %10.3f\n",rz*57.2957);
   }
   return 0;
}
*/

/*
int NOTmain() {
    int handle = socket( AF_INET, SOCK_DGRAM, 0 );

    if(handle < 0){
	perror("socket");
	exit(1);
    }
	 
    struct sockaddr_in servaddr;
    servaddr.sin_family = AF_INET;
    servaddr.sin_port=htons(51001);
    servaddr.sin_addr.s_addr=htonl(INADDR_ANY);

    if ( bind( handle, (struct sockaddr*)&servaddr, sizeof(servaddr) ) < 0 ){
	perror("bind");
	exit(1);
    }
    while ( 1 )
    {
		struct sockaddr_in cliaddr;
		char packet_data[1024];	
                double tx;
                double ty;
                double rz;

		socklen_t len= sizeof(cliaddr); 
		int received_bytes = recvfrom( handle, packet_data, sizeof(packet_data),0, (struct sockaddr*)&cliaddr, &len );
		if ( received_bytes > 0 )
                printf("name %c%c%c%c%c%c%c%c\n",packet_data[8],packet_data[9],packet_data[10],packet_data[11],packet_data[12],packet_data[13],packet_data[14],packet_data[15]);
           memcpy(&tx,&packet_data[32],8*sizeof(char));
           memcpy(&ty,&packet_data[40],8*sizeof(char));
           memcpy(&rz,&packet_data[72],8*sizeof(char));
             printf("tx %10.3f\nty %10.3f\n",tx,ty);
             printf("rz %10.3f\n",rz*57.2957);
             printf("nItems: %d\n",packet_data[4]);
    }
     close(handle);
     return 0; 
}

*/

int main() {
   int rc;
   int handle = 0; 
   char packet_data[1024];	
   double tx;
   double ty;
   double rz;

   rc = initializeUDP(&handle);

   rc = getUDPData(handle, packet_data);
   printf("name %c%c%c%c%c%c%c%c\n",packet_data[8],packet_data[9],packet_data[10],packet_data[11],packet_data[12],packet_data[13],packet_data[14],packet_data[15]);
   memcpy(&tx,&packet_data[32],8*sizeof(char));
   memcpy(&ty,&packet_data[40],8*sizeof(char));
   memcpy(&rz,&packet_data[72],8*sizeof(char));
   printf("tx %10.3f\nty %10.3f\n",tx,ty);
   printf("rz %10.3f\n",rz*57.2957);

   return 0;
}


