###########################################################################
## Makefile generated for component 'AirTableModel'. 
## 
## Makefile     : AirTableModel.mk
## Generated on : Fri Oct 29 13:15:45 2021
## Final product: $(RELATIVE_PATH_TO_ANCHOR)/AirTableModel.elf
## Product type : executable
## 
###########################################################################

###########################################################################
## MACROS
###########################################################################

# Macro Descriptions:
# PRODUCT_NAME            Name of the system to build
# MAKEFILE                Name of this makefile

PRODUCT_NAME              = AirTableModel
MAKEFILE                  = AirTableModel.mk
MATLAB_ROOT               = $(MATLAB_WORKSPACE)/C/Program_Files/MATLAB/R2021a
MATLAB_BIN                = $(MATLAB_WORKSPACE)/C/Program_Files/MATLAB/R2021a/bin
MATLAB_ARCH_BIN           = $(MATLAB_BIN)/win64
START_DIR                 = $(MATLAB_WORKSPACE)/C/Users/Andy/Documents/MATLAB/AirTableSim
SHARED_SRC_DIR            = $(START_DIR)/slprj/ert/_sharedutils
SHARED_BIN_DIR            = $(START_DIR)/slprj/ert/_sharedutils
SHARED_LIB                = $(SHARED_BIN_DIR)/rtwshared.lib
SOLVER                    = 
SOLVER_OBJ                = 
CLASSIC_INTERFACE         = 0
TGT_FCN_LIB               = ISO_C++
MODEL_HAS_DYNAMICALLY_LOADED_SFCNS = 0
RELATIVE_PATH_TO_ANCHOR   = ..
C_STANDARD_OPTS           = 
CPP_STANDARD_OPTS         = 

###########################################################################
## TOOLCHAIN SPECIFICATIONS
###########################################################################

# Toolchain Name:          GNU GCC Embedded Linux
# Supported Version(s):    
# ToolchainInfo Version:   2021a
# Specification Revision:  1.0
# 

#-----------
# MACROS
#-----------

CCOUTPUTFLAG = --output_file=
LDOUTPUTFLAG = --output_file=

TOOLCHAIN_SRCS = 
TOOLCHAIN_INCS = 
TOOLCHAIN_LIBS = -lm -lm -lstdc++

#------------------------
# BUILD TOOL COMMANDS
#------------------------

# Assembler: GNU GCC Embedded Linux Assembler
AS = as

# C Compiler: GNU GCC Embedded Linux C Compiler
CC = gcc

# Linker: GNU GCC Embedded Linux Linker
LD = gcc

# C++ Compiler: GNU GCC Embedded Linux C++ Compiler
CPP = g++

# C++ Linker: GNU GCC Embedded Linux C++ Linker
CPP_LD = g++

# Archiver: GNU GCC Embedded Linux Archiver
AR = ar

# MEX Tool: MEX Tool
MEX_PATH = $(MATLAB_ARCH_BIN)
MEX = "$(MEX_PATH)/mex"

# Download: Download
DOWNLOAD =

# Execute: Execute
EXECUTE = $(PRODUCT)

# Builder: Make Tool
MAKE = make


#-------------------------
# Directives/Utilities
#-------------------------

ASDEBUG             = -g
AS_OUTPUT_FLAG      = -o
CDEBUG              = -g
C_OUTPUT_FLAG       = -o
LDDEBUG             = -g
OUTPUT_FLAG         = -o
CPPDEBUG            = -g
CPP_OUTPUT_FLAG     = -o
CPPLDDEBUG          = -g
OUTPUT_FLAG         = -o
ARDEBUG             =
STATICLIB_OUTPUT_FLAG =
MEX_DEBUG           = -g
RM                  =
ECHO                = echo
MV                  =
RUN                 =

#--------------------------------------
# "Faster Runs" Build Configuration
#--------------------------------------

ARFLAGS              = -r
ASFLAGS              = -c \
                       $(ASFLAGS_ADDITIONAL) \
                       $(INCLUDES)
CFLAGS               = -c \
                       -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -O2
CPPFLAGS             = -c \
                       -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -fpermissive  \
                       -O2
CPP_LDFLAGS          = -lrt -lpthread -ldl
CPP_SHAREDLIB_LDFLAGS  = -shared  \
                         -lrt -lpthread -ldl
DOWNLOAD_FLAGS       =
EXECUTE_FLAGS        =
LDFLAGS              = -lrt -lpthread -ldl
MEX_CPPFLAGS         =
MEX_CPPLDFLAGS       =
MEX_CFLAGS           =
MEX_LDFLAGS          =
MAKE_FLAGS           = -f $(MAKEFILE)
SHAREDLIB_LDFLAGS    = -shared  \
                       -lrt -lpthread -ldl



###########################################################################
## OUTPUT INFO
###########################################################################

PRODUCT = $(RELATIVE_PATH_TO_ANCHOR)/AirTableModel.elf
PRODUCT_TYPE = "executable"
BUILD_TYPE = "Top-Level Standalone Executable"

###########################################################################
## INCLUDE PATHS
###########################################################################

INCLUDES_BUILDINFO = -I$(START_DIR)/slprj/ert/UseHWSensorData -I$(START_DIR)/slprj/ert/TranslationalDynamics -I$(START_DIR)/slprj/ert/ThrusterModel0 -I$(START_DIR)/slprj/ert/SlidingModeControl -I$(START_DIR)/slprj/ert/ReactionWheel0 -I$(START_DIR)/slprj/ert/PIDControl -I$(START_DIR)/slprj/ert/FormStateBus -I$(START_DIR)/slprj/ert/AttitudeDynamics -I$(START_DIR)/slprj/ert/ApproachControl -I$(START_DIR) -I$(START_DIR)/AirTableModel_ert_rtw -I$(MATLAB_ROOT)/extern/include -I$(MATLAB_ROOT)/simulink/include -I$(MATLAB_ROOT)/rtw/c/src -I$(MATLAB_ROOT)/rtw/c/src/ext_mode/common -I$(MATLAB_ROOT)/rtw/c/ert -I$(START_DIR)/slprj/ert/_sharedutils -I$(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2021a/toolbox/realtime/targets/raspi/include -I$(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils -I$(MATLAB_ROOT)/toolbox/target/codertarget/rtos/inc -I$(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2021a/toolbox/target/shared/file_logging/include

INCLUDES_OPENCV = -I/usr/local/include/opencv4
INCLUDES_SERIAL = -I$(SERIAL_DIR)
INCLUDES_PHIDGET = -I$(PHIDGET_DIR)
INCLUDES_IMAGE = -I$(IMAGE_DIR)
INCLUDES_VICON = -I$(VICON_DIR) -I${VICON_DIR}/DataStreamSDK/Vicon/CrossMarket/DataStream/ViconDataStreamSDK_CPP/
INCLUDES = $(INCLUDES_OPENCV) $(INCLUDES_SERIAL) $(INCLUDES_PHIDGET) $(INCLUDES_IMAGE) $(INCLUDES_VICON) $(INCLUDES_BUILDINFO)

###########################################################################
## DEFINES
###########################################################################

DEFINES_ = -D__MW_TARGET_USE_HARDWARE_RESOURCES_H__ -DMAT_FILE_LOC=/home/pi -DMAX_MATFILE_NAME_LEN=64
DEFINES_BUILD_ARGS = -DCLASSIC_INTERFACE=0 -DALLOCATIONFCN=0 -DTERMFCN=1 -DONESTEPFCN=1 -DMAT_FILE=1 -DMULTI_INSTANCE_CODE=1 -DINTEGER_CODE=0 -DMT=1
DEFINES_CUSTOM = 
DEFINES_OPTS = -DTID01EQ=0
DEFINES_SKIPFORSIL = -D__linux__ -DARM_PROJECT -D_USE_TARGET_UDP_ -D_RUNONTARGETHARDWARE_BUILD_ -DSTACK_SIZE=1024 -DRT
DEFINES_STANDARD = -DMODEL=AirTableModel -DNUMST=2 -DNCSTATES=0 -DHAVESTDIO -DMODEL_HAS_DYNAMICALLY_LOADED_SFCNS=0

DEFINES = $(DEFINES_) $(DEFINES_BUILD_ARGS) $(DEFINES_CUSTOM) $(DEFINES_OPTS) $(DEFINES_SKIPFORSIL) $(DEFINES_STANDARD)

###########################################################################
## SOURCE FILES
###########################################################################

SRCS = $(START_DIR)/AirTableModel_ert_rtw/AirTableModel.cpp $(START_DIR)/AirTableModel_ert_rtw/AirTableModel_data.cpp $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2021a/toolbox/realtime/targets/raspi/src/MW_raspi_init.c $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2021a/toolbox/realtime/targets/raspi/src/periphs/MW_Pyserver_control.c $(MATLAB_ROOT)/toolbox/target/codertarget/rtos/src/linuxinitialize.cpp $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2021a/toolbox/target/shared/file_logging/src/ert_targets_logging.c $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2021a/toolbox/target/supportpackages/raspberrypi/src/raspi_file_logging.c

SHARED_SRC= $(SHARED_SRC_DIR)/*.cpp
#SERIAL_SRC  = $(SERIAL_DIR)/serial_init.c $(SERIAL_DIR)/arduino-serial-lib.c $(SERIAL_DIR)/arduino-serial.c
SERIAL_SRC  = $(SERIAL_DIR)/serial_init.c $(SERIAL_DIR)/arduino-serial-lib.c
PHIDGET_SRC = $(PHIDGET_DIR)/PhidgetHelperFunctions.c $(PHIDGET_DIR)/AccelerometerInit.c $(PHIDGET_DIR)/MagnetometerInit.c $(PHIDGET_DIR)/DistanceInit.c
IMAGE_SRC = $(IMAGE_DIR)/captureImage.cpp $(IMAGE_DIR/initCamera.cpp 
#IMAGE_SRC = $(IMAGE_DIR)/captureImage.cpp $(IMAGE_DIR/initCamera.cpp $(IMAGE_DIR)/imageProc.cpp $(IMAGE_DIR)/ImageProcessing.cpp
#VICON_SRC = $(VICON_DIR)/initializeDataStream.cpp $(VICON_DIR)/getDataStream.cpp
VICON_SRC = $(VICON_DIR)/initializeUDP.cpp $(VICON_DIR)/getUDPData.cpp
MAIN_SRC = $(START_DIR)/AirTableModel_ert_rtw/ert_main.cpp

ALL_SRCS = $(SRCS) $(SERIAL_SRC) $(PHIDGET_SRC) $(IMAGE_SRC) $(MAIN_SRC) ${SHARED_SRC)

###########################################################################
## OBJECTS
###########################################################################

OBJS = captureImage.cpp.o initCamera.cpp.o initializeUDP.cpp.o getUDPData.cpp.o serial_init.c.o arduino-serial-lib.c.o PhidgetHelperFunctions.c.o AccelerometerInit.c.o MagnetometerInit.c.o DistanceInit.c.o AirTableModel.cpp.o AirTableModel_data.cpp.o MW_raspi_init.c.o MW_Pyserver_control.c.o linuxinitialize.cpp.o ert_targets_logging.c.o raspi_file_logging.c.o
#OBJS = captureImage.cpp.o initCamera.cpp.o imageProc.cpp.o ImageProcessing.cpp.o serial_init.c.o arduino-serial-lib.c.o arduino-serial.c.o PhidgetHelperFunctions.c.o AccelerometerInit.c.o MagnetometerInit.c.o DistanceInit.c.o AirTableModel.cpp.o AirTableModel_data.cpp.o MW_raspi_init.c.o MW_Pyserver_control.c.o linuxinitialize.cpp.o ert_targets_logging.c.o raspi_file_logging.c.o

SHARED_OBJS = $(addprefix $(join $(SHARED_BIN_DIR),/), $(addsuffix .cpp.o, $(basename $(notdir $(wildcard $(SHARED_SRC_DIR)/*.cpp)))))
MAIN_OBJ = ert_main.cpp.o

ALL_OBJS = $(OBJS) $(MAIN_OBJ) $(SHARIED_OBJS)

###########################################################################
## PREBUILT OBJECT FILES
###########################################################################

PREBUILT_OBJS = 

###########################################################################
## LIBRARIES
###########################################################################

MODELREF_LIBS = ../slprj/ert/ApproachControl/ApproachControl_rtwlib.lib ../slprj/ert/AttitudeDynamics/AttitudeDynamics_rtwlib.lib ../slprj/ert/FormStateBus/FormStateBus_rtwlib.lib ../slprj/ert/PIDControl/PIDControl_rtwlib.lib ../slprj/ert/ReactionWheel0/ReactionWheel0_rtwlib.lib ../slprj/ert/SlidingModeControl/SlidingModeControl_rtwlib.lib ../slprj/ert/ThrusterModel0/ThrusterModel0_rtwlib.lib ../slprj/ert/TranslationalDynamics/TranslationalDynamics_rtwlib.lib ../slprj/ert/UseHWSensorData/UseHWSensorData_rtwlib.lib

LIBS = $(START_DIR)/slprj/ert/_sharedutils/rtwshared.lib

###########################################################################
## SYSTEM LIBRARIES
###########################################################################

SYSTEM_LIBS = -lopencv_core -lopencv_imgproc -lopencv_videoio -lphidget22

###########################################################################
## ADDITIONAL TOOLCHAIN FLAGS
###########################################################################

#---------------
# C Compiler
#---------------

CFLAGS_SKIPFORSIL =   -fpermissive
CFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CFLAGS += $(CFLAGS_SKIPFORSIL) $(CFLAGS_BASIC)

#-----------------
# C++ Compiler
#-----------------

CPPFLAGS_SKIPFORSIL =   -fpermissive
CPPFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CPPFLAGS += $(CPPFLAGS_SKIPFORSIL) $(CPPFLAGS_BASIC)

#---------------
# C++ Linker
#---------------

CPP_LDFLAGS_SKIPFORSIL =  

CPP_LDFLAGS += $(CPP_LDFLAGS_SKIPFORSIL)

#------------------------------
# C++ Shared Library Linker
#------------------------------

CPP_SHAREDLIB_LDFLAGS_SKIPFORSIL =  

CPP_SHAREDLIB_LDFLAGS += $(CPP_SHAREDLIB_LDFLAGS_SKIPFORSIL)

#-----------
# Linker
#-----------

LDFLAGS_SKIPFORSIL =  

LDFLAGS += $(LDFLAGS_SKIPFORSIL)

#--------------------------
# Shared Library Linker
#--------------------------

SHAREDLIB_LDFLAGS_SKIPFORSIL =  

SHAREDLIB_LDFLAGS += $(SHAREDLIB_LDFLAGS_SKIPFORSIL)

###########################################################################
## INLINED COMMANDS
###########################################################################


DERIVED_SRCS = $(subst .o,.dep,$(OBJS))

build:

%.dep:



-include codertarget_assembly_flags.mk
-include *.dep


###########################################################################
## PHONY TARGETS
###########################################################################

.PHONY : all build buildobj clean info prebuild download execute


all : build
	echo "### Successfully generated all binary outputs."


build : prebuild $(PRODUCT)


buildobj : prebuild $(OBJS) $(PREBUILT_OBJS) $(LIBS)
	echo "### Successfully generated all binary outputs."


prebuild : 


download : $(PRODUCT)


execute : download
	echo "### Invoking postbuild tool "Execute" ..."
	$(EXECUTE) $(EXECUTE_FLAGS)
	echo "### Done invoking postbuild tool."


###########################################################################
## FINAL TARGET
###########################################################################

#-------------------------------------------
# Create a standalone executable            
#-------------------------------------------

$(PRODUCT) : $(OBJS) $(PREBUILT_OBJS) $(MODELREF_LIBS) $(LIBS) $(MAIN_OBJ)
	echo "### Creating standalone executable "$(PRODUCT)" ..."
	$(CPP_LD) $(CPP_LDFLAGS) -o $(PRODUCT) $(OBJS) $(MAIN_OBJ) ../slprj/ert/ApproachControl/ApproachControl_rtwlib.lib ../slprj/ert/AttitudeDynamics/AttitudeDynamics_rtwlib.lib ../slprj/ert/FormStateBus/FormStateBus_rtwlib.lib ../slprj/ert/PIDControl/PIDControl_rtwlib.lib ../slprj/ert/ReactionWheel0/ReactionWheel0_rtwlib.lib ../slprj/ert/SlidingModeControl/SlidingModeControl_rtwlib.lib ../slprj/ert/ThrusterModel0/ThrusterModel0_rtwlib.lib ../slprj/ert/TranslationalDynamics/TranslationalDynamics_rtwlib.lib ../slprj/ert/UseHWSensorData/UseHWSensorData_rtwlib.lib $(LIBS) $(SYSTEM_LIBS) $(TOOLCHAIN_LIBS)
	echo "### Created: $(PRODUCT)"


###########################################################################
## INTERMEDIATE TARGETS
###########################################################################

#---------------------
# SOURCE-TO-OBJECT
#---------------------

%.c.o : %.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : %.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : %.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.c.o : $(RELATIVE_PATH_TO_ANCHOR)/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : $(RELATIVE_PATH_TO_ANCHOR)/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.c.o : $(START_DIR)/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : $(START_DIR)/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : $(START_DIR)/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.c.o : $(START_DIR)/AirTableModel_ert_rtw/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : $(START_DIR)/AirTableModel_ert_rtw/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : $(START_DIR)/AirTableModel_ert_rtw/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.c.o : $(MATLAB_ROOT)/rtw/c/src/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : $(MATLAB_ROOT)/rtw/c/src/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : $(MATLAB_ROOT)/rtw/c/src/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.c.o : $(MATLAB_ROOT)/simulink/src/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : $(MATLAB_ROOT)/simulink/src/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : $(MATLAB_ROOT)/simulink/src/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


ert_main.cpp.o : $(START_DIR)/AirTableModel_ert_rtw/ert_main.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


AirTableModel.cpp.o : $(START_DIR)/AirTableModel_ert_rtw/AirTableModel.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


AirTableModel_data.cpp.o : $(START_DIR)/AirTableModel_ert_rtw/AirTableModel_data.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


MW_raspi_init.c.o : $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2021a/toolbox/realtime/targets/raspi/src/MW_raspi_init.c
	$(CC) $(CFLAGS) -o "$@" "$<"


MW_Pyserver_control.c.o : $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2021a/toolbox/realtime/targets/raspi/src/periphs/MW_Pyserver_control.c
	$(CC) $(CFLAGS) -o "$@" "$<"


linuxinitialize.cpp.o : $(MATLAB_ROOT)/toolbox/target/codertarget/rtos/src/linuxinitialize.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


ert_targets_logging.c.o : $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2021a/toolbox/target/shared/file_logging/src/ert_targets_logging.c
	$(CC) $(CFLAGS) -o "$@" "$<"


raspi_file_logging.c.o : $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2021a/toolbox/target/supportpackages/raspberrypi/src/raspi_file_logging.c
	$(CC) $(CFLAGS) -o "$@" "$<"

captureImage.cpp.o : $(IMAGE_DIR)/captureImage.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<

initCamera.cpp.o : $(IMAGE_DIR)/initCamera.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<

#imageProc.cpp.o : $(IMAGE_DIR)/imageProc.cpp
#	$(CPP) $(CPPFLAGS) -o $@ $<

#ImageProcessing.cpp.o : $(IMAGE_DIR)/ImageProcessing.cpp
#	$(CPP) $(CPPFLAGS) -o $@ $<

initializeUDP.cpp.o : $(VICON_DIR)/initializeUDP.cpp
	$(CC) $(CFLAGS) -o $@ $<

getUDPData.cpp.o : $(VICON_DIR)/getUDPData.cpp
	$(CC) $(CFLAGS) -o $@ $<

serial_init.c.o : $(SERIAL_DIR)/serial_init.c
	$(CC) $(CFLAGS) -o $@ $<

arduino-serial-lib.c.o : $(SERIAL_DIR)/arduino-serial-lib.c
	$(CC) $(CFLAGS) -o $@ $<

#arduino-serial.c.o : $(SERIAL_DIR)/arduino-serial.c
#	$(CC) $(CFLAGS) -o $@ $<

PhidgetHelperFunctions.c.o : $(PHIDGET_DIR)/PhidgetHelperFunctions.c
	$(CC) $(CFLAGS) -o $@ $<

AccelerometerInit.c.o : $(PHIDGET_DIR)/AccelerometerInit.c
	$(CC) $(CFLAGS) -o $@ $<

MagnetometerInit.c.o : $(PHIDGET_DIR)/MagnetometerInit.c
	$(CC) $(CFLAGS) -o $@ $<

DistanceInit.c.o : $(PHIDGET_DIR)/DistanceInit.c
	$(CC) $(CFLAGS) -o $@ $<

$(SHARED_BIN_DIR)/%.cpp.o : $(SHARED_SRC_DIR)/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<

#---------------------------
# SHARED UTILITY LIBRARY^M
#---------------------------

$(SHARED_LIB) : $(SHARED_OBJS)
	echo "### Creating shared utilities library "$(SHARED_LIB)" ..."
	$(AR) $(ARFLAGS)  $(SHARED_LIB) $(SHARED_OBJS)
	echo "### Created: $(SHARED_LIB)"


###########################################################################
## DEPENDENCIES
###########################################################################

$(ALL_OBJS) : rtw_proj.tmw $(MAKEFILE)


###########################################################################
## MISCELLANEOUS TARGETS
###########################################################################

info : 
	echo "### PRODUCT = $(PRODUCT)"
	echo "### PRODUCT_TYPE = $(PRODUCT_TYPE)"
	echo "### BUILD_TYPE = $(BUILD_TYPE)"
	echo "### INCLUDES = $(INCLUDES)"
	echo "### DEFINES = $(DEFINES)"
	echo "### ALL_SRCS = $(ALL_SRCS)"
	echo "### ALL_OBJS = $(ALL_OBJS)"
	echo "### LIBS = $(LIBS)"
	echo "### MODELREF_LIBS = $(MODELREF_LIBS)"
	echo "### SYSTEM_LIBS = $(SYSTEM_LIBS)"
	echo "### TOOLCHAIN_LIBS = $(TOOLCHAIN_LIBS)"
	echo "### ASFLAGS = $(ASFLAGS)"
	echo "### CFLAGS = $(CFLAGS)"
	echo "### LDFLAGS = $(LDFLAGS)"
	echo "### SHAREDLIB_LDFLAGS = $(SHAREDLIB_LDFLAGS)"
	echo "### CPPFLAGS = $(CPPFLAGS)"
	echo "### CPP_LDFLAGS = $(CPP_LDFLAGS)"
	echo "### CPP_SHAREDLIB_LDFLAGS = $(CPP_SHAREDLIB_LDFLAGS)"
	echo "### ARFLAGS = $(ARFLAGS)"
	echo "### MEX_CFLAGS = $(MEX_CFLAGS)"
	echo "### MEX_CPPFLAGS = $(MEX_CPPFLAGS)"
	echo "### MEX_LDFLAGS = $(MEX_LDFLAGS)"
	echo "### MEX_CPPLDFLAGS = $(MEX_CPPLDFLAGS)"
	echo "### DOWNLOAD_FLAGS = $(DOWNLOAD_FLAGS)"
	echo "### EXECUTE_FLAGS = $(EXECUTE_FLAGS)"
	echo "### MAKE_FLAGS = $(MAKE_FLAGS)"


clean : 
	$(ECHO) "### Deleting all derived files..."
	$(RM) $(PRODUCT)
	$(RM) $(ALL_OBJS)
	$(RM) *.c.dep
	$(RM) *.cpp.dep
	$(ECHO) "### Deleted all derived files."


