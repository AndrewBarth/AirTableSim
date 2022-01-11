
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

using namespace ViconDataStreamSDK::CPP;
#define output_stream  std::cout

int getDataStream(ViconDataStreamSDK::CPP::Client *MyClient, double translation[3], double rotation[3]) {

   bool status=MyClient->IsConnected().Connected;

   // Get a frame
//   output_stream << "Waiting for new frame...";
   while( MyClient->GetFrame().Result != Result::Success ) {
      // Sleep a little so that we don't lumber the CPU with a busy poll
      #ifdef WIN32
        Sleep( 200 );
      #else
        sleep(1);
      #endif
//      output_stream << ".";

   }
//   output_stream << std::endl;
      // Count the number of subjects
      unsigned int SubjectCount = MyClient->GetSubjectCount().SubjectCount;
      //output_stream << "Subjects (" << SubjectCount << "):" << std::endl;
      for( unsigned int SubjectIndex = 0 ; SubjectIndex < SubjectCount ; ++SubjectIndex )
      {
        //output_stream << "  Subject #" << SubjectIndex << std::endl;

        // Get the subject name
        std::string SubjectName = MyClient->GetSubjectName( SubjectIndex ).SubjectName;
        //output_stream << "    Name: " << SubjectName << std::endl;

        // Get the root segment
        std::string RootSegment = MyClient->GetSubjectRootSegmentName( SubjectName ).SegmentName;
        //output_stream << "    Root Segment: " << RootSegment << std::endl;

        // Count the number of segments
        unsigned int SegmentCount = MyClient->GetSegmentCount( SubjectName ).SegmentCount;
        //output_stream << "    Segments (" << SegmentCount << "):" << std::endl;

        for( unsigned int SegmentIndex = 0 ; SegmentIndex < SegmentCount ; ++SegmentIndex )
        {
          //output_stream << "      Segment #" << SegmentIndex << std::endl;

          // Get the segment name
          std::string SegmentName = MyClient->GetSegmentName( SubjectName, SegmentIndex ).SegmentName;
          //output_stream << "        Name: " << SegmentName << std::endl;

         // Get the global segment translation
          Output_GetSegmentGlobalTranslation _Output_GetSegmentGlobalTranslation =
            MyClient->GetSegmentGlobalTranslation( SubjectName, SegmentName );
          translation[0] =  _Output_GetSegmentGlobalTranslation.Translation[ 0 ];
          translation[1] =  _Output_GetSegmentGlobalTranslation.Translation[ 1 ];
          translation[2] =  _Output_GetSegmentGlobalTranslation.Translation[ 2 ];

         // Get the global segment rotation in EulerXYZ co-ordinates
          Output_GetSegmentGlobalRotationEulerXYZ _Output_GetSegmentGlobalRotationEulerXYZ =
            MyClient->GetSegmentGlobalRotationEulerXYZ( SubjectName, SegmentName );
          rotation[0] = _Output_GetSegmentGlobalRotationEulerXYZ.Rotation[ 0 ];
          rotation[1] = _Output_GetSegmentGlobalRotationEulerXYZ.Rotation[ 1 ];
          rotation[2] = _Output_GetSegmentGlobalRotationEulerXYZ.Rotation[ 2 ];
        }
     }
     //printf("Global Translation: %7.3f, %7.3f, %7.3f\n",translation[0],translation[1],translation[2]);
     //printf("Global Rotation: %7.3f, %7.3f, %7.3f\n",rotation[0],rotation[1],rotation[2]);


   return 0;
}

