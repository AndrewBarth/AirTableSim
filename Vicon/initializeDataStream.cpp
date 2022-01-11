
#include "DataStreamClient.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <iostream>

using namespace std;
using namespace ViconDataStreamSDK::CPP;
#define output_stream  std::cout

int initializeDataStream(ViconDataStreamSDK::CPP::Client *MyClient, std::string HostName)
{
   // Connect to a server
   std::cout << "Connecting to " << HostName << " ..." << std::flush;

   while( !MyClient->IsConnected().Connected )
   {
      // Direct connection

      bool ok = false;
      ok =( MyClient->Connect( HostName ).Result == Result::Success );
      if(!ok)
      {
        std::cout << "Warning - connect failed..." << std::endl;
      }

      #ifdef WIN32
         Sleep( 1000 );
      #else
         sleep(1);
      #endif
   }

   MyClient->EnableSegmentData();

   return 0;
}

