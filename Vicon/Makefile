
INCLUDES = -I/home/pi/Vicon/ -I/home/pi/Vicon/Linux32/ -I/Linux32/ViconDataStreamSDKSourceLinux32-source/ -I/Linux32/ViconDataStreamSDKSourceLinux32-source/Vicon/CrossMarket/DataStream/ViconDataStreamSDK_CPP/

SRC =  initializeUDP.cpp getUDPData.cpp driver.cpp

OBJS =  initializeUDP.o getUDPData.o driver.o

LIBS =

CC = gcc
CFLAGS = -c $(INCLUDES) -g

CPP = g++
CPPFLAGS = -c $(INCLUDES) -std=c++11 -g

testVicon: $(OBJS) $(LIBS)
	$(CPP) -g -lrt -lpthread -ldl -o testVicon $(OBJS) $(LIBS) 


%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<

%.o : %.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<

