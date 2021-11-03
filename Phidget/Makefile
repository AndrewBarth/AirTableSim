
INCLUDES = -I$(PHIDGET_DIR)
PHIDGET_SRC = $(PHIDGET_DIR)/PhidgetHelperFunctions.c $(PHIDGET_DIR)/AccelerometerInit.c $(PHIDGET_DIR)/MagnetometerInit.c $(PHIDGET_DIR)/DistanceInit.c

SRC = $(PHIDGET_SRC) driver.c

OBJS =  driver.o AccelerometerInit.o DistanceInit.o MagnetometerInit.o PhidgetHelperFunctions.o

LIBS = -lphidget22

CC = gcc
CFLAGS = -c $(INCLUDES)

runPhidget: $(OBJS) $(LIBS)
	$(CC) -lrt -lpthread -ldl -o runPhidget $(OBJS) $(LIBS) 

%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<

PhidgetHelperFunctions.c.o : $(PHIDGET_DIR)/PhidgetHelperFunctions.c
	$(CC) $(CFLAGS) -o $@ $<

AccelerometerInit.c.o : $(PHIDGET_DIR)/AccelerometerInit.c
	$(CC) $(CFLAGS) -o $@ $<

MagnetometerInit.c.o : $(PHIDGET_DIR)/MagnetometerInit.c
	$(CC) $(CFLAGS) -o $@ $<

DistanceInit.c.o : $(PHIDGET_DIR)/DistanceInit.c
	$(CC) $(CFLAGS) -o $@ $<

