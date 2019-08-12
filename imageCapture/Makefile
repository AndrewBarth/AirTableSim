
INCLUDES = -I/usr/local/include/opencv4/

SRC = captureImage.cpp initCamera.cpp driver.cpp

OBJS =  captureImage.o initCamera.o driver.o

#LIBS = -lopencv_core -lopencv_highgui -lopencv_videoio
LIBS = -lopencv_core -lopencv_imgproc -lopencv_videoio

CC = gcc
CFLAGS = -c $(INCLUDES) -g

CPP = g++
CPPFLAGS = -c $(INCLUDES) -std=c++11 -g

captureImage: $(OBJS) $(LIBS)
	$(CPP) -g -lrt -lpthread -ldl -o captureImage $(OBJS) $(LIBS) 


%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<

%.o : %.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<

captureImage.o : captureImage.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


initCamera.o : initCamera.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<

