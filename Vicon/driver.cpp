
#include "DataStreamClient.h"
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
#include <time.h>

#ifdef WIN32
  #include <conio.h>   // For _kbhit()
  #include <cstdio>   // For getchar()
  #include <windows.h> // For Sleep()
#else
  #include <unistd.h> // For sleep()
#endif // WIN32

using namespace ViconDataStreamSDK::CPP;
#define output_stream if(!LogFile.empty()) ; else std::cout

int initializeUDP(int *handle);
int getUDPData(int handle, char *packet_data);
int getDataStream(ViconDataStreamSDK::CPP::Client *MyClient, double translation[3], double rotation[3]);
int initializeDataStream(ViconDataStreamSDK::CPP::Client *MyClient, std::string HostName);

   int rc;
   int handle = 0; 
   char packet_data[256];	
   double tx;
   double ty;
   double rz;
   double translation[3];
   double rotation[3];

int main(int argc, char **argv) {

//   std::string HostName = "192.168.1.17:801";
   if( argc > 1 )
   {
//     HostName = argv[1];
   }
   // Make a new client
//   ViconDataStreamSDK::CPP::Client MyClient;

//   rc = initializeDataStream(&MyClient, HostName);

   rc = initializeUDP(&handle);

   while(1) {
   rc = -1;
   while(rc == -1) {
      rc = getUDPData(handle, packet_data);
      printf("Waiting for UDP data\n");
   }
   printf("get return: %d\n",rc);
   printf("name %c%c%c%c%c%c%c%c\n",packet_data[8],packet_data[9],packet_data[10],packet_data[11],packet_data[12],packet_data[13],packet_data[14],packet_data[15]);
   memcpy(&tx,&packet_data[32],8*sizeof(char));
   memcpy(&ty,&packet_data[40],8*sizeof(char));
   memcpy(&rz,&packet_data[72],8*sizeof(char));
   printf("tx %10.3f\nty %10.3f\n",tx,ty);
   printf("rz %10.3f\n",rz*57.2957);

//   rc = getDataStream(&MyClient,translation,rotation);
//   printf("Global Translation: %7.3f, %7.3f, %7.3f\n",translation[0],translation[1],translation[2]);
//   printf("Global Rotation: %7.3f, %7.3f, %7.3f\n",rotation[0]*57.2958,rotation[1]*57.2958,rotation[2]*57.2958);
   }

   return 0;
}


