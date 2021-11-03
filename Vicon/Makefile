
INCLUDES = -I/home/pi/Vicon/ -I/home/pi/Vicon/DataStreamSDK/Vicon/CrossMarket/DataStream/ViconDataStreamSDK_CPP/ -I/home/pi/Vicon/DataStreamSDK/bin/Debug/

SRC =  initializeUDP.cpp getUDPData.cpp initializeDataStream.cpp getDataStream.cpp driver.cpp

OBJS =  initializeUDP.o getUDPData.o initializeDataStream.o getDataStream.o driver.o

#LIBS = -lViconDataStreamSDK_CPP.so
LIBS = -lViconDataStreamSDKCore -lViconCGStreamClientSDK -lViconCGStreamClient -lViconCGStream -lStreamCommon -lViconDataStreamSDK_CPP

CC = gcc
CFLAGS = -c $(INCLUDES) -g

CPP = g++
CPPFLAGS = -c $(INCLUDES) -std=c++11 -g

testVicon: $(OBJS) $(LIBS)
	$(CPP) -g -lrt -lpthread -ldl -L/home/pi/Vicon/DataStreamSDK/bin/Debug -o testVicon $(OBJS) $(LIBS) 


%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<

%.o : %.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<

