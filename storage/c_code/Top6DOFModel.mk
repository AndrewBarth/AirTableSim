###########################################################################
## Makefile generated for Simulink model 'Top6DOFModel'. 
## 
## Makefile     : Top6DOFModel.mk
## Generated on : Thu Jun 06 12:23:56 2019
## MATLAB Coder version: 4.1 (R2018b)
## 
## Build Info:
## 
## Final product: $(RELATIVE_PATH_TO_ANCHOR)/Top6DOFModel.elf
## Product type : executable
## Build type   : Top-Level Standalone Executable
## 
###########################################################################

###########################################################################
## MACROS
###########################################################################

# Macro Descriptions:
# PRODUCT_NAME            Name of the system to build
# MAKEFILE                Name of this makefile
# COMPUTER                Computer type. See the MATLAB "computer" command.
# SHARED_OBJS             Shared Object Names

PRODUCT_NAME              = Top6DOFModel
MAKEFILE                  = Top6DOFModel.mk
COMPUTER                  = GLNX
MATLAB_ROOT               = $(MATLAB_WORKSPACE)/C/Program_Files/MATLAB/R2018b
MATLAB_BIN                = $(MATLAB_WORKSPACE)/C/Program_Files/MATLAB/R2018b/bin
MATLAB_ARCH_BIN           = $(MATLAB_BIN)/win64
MASTER_ANCHOR_DIR         = 
START_DIR                 = $(MATLAB_WORKSPACE)/Z/My_Documents/MATLAB/AirTableSim
ARCH                      = glnx
SOLVER                    = 
SOLVER_OBJ                = 
CLASSIC_INTERFACE         = 0
TGT_FCN_LIB               = None
MODEL_HAS_DYNAMICALLY_LOADED_SFCNS = 0
RELATIVE_PATH_TO_ANCHOR   = ..
C_STANDARD_OPTS           = 
CPP_STANDARD_OPTS         = 
SHARED_SRC_DIR            = ../slprj/ert/_sharedutils
SHARED_SRC                = $(SHARED_SRC_DIR)/*.c
SHARED_BIN_DIR            = ../slprj/ert/_sharedutils
SHARED_LIB                = $(SHARED_BIN_DIR)/rtwshared.lib
SHARED_OBJS               =  \
$(addprefix $(join $(SHARED_BIN_DIR),/), $(addsuffix .c.o, $(basename $(notdir $(wildcard $(SHARED_SRC_DIR)/*.c)))))

###########################################################################
## TOOLCHAIN SPECIFICATIONS
###########################################################################

# Toolchain Name:          GNU GCC Raspberry Pi v1.0 | gmake (64-bit Windows)
# Supported Version(s):    
# ToolchainInfo Version:   R2018b
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

# Assembler: GNU GCC Raspberry Pi Assembler
AS = as

# C Compiler: GNU GCC Raspberry Pi C Compiler
CC = gcc

# Linker: GNU GCC Raspberry Pi Linker
LD = gcc

# C++ Compiler: GNU GCC Raspberry Pi C++ Compiler
CPP = g++

# C++ Linker: GNU GCC Raspberry Pi C++ Linker
CPP_LD = g++

# Archiver: GNU GCC Raspberry Pi Archiver
AR = ar

# MEX Tool: MEX Tool
MEX_PATH = $(MATLAB_ARCH_BIN)
MEX = $(MEX_PATH)/mex

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
                       -std=c++11 \
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

#--------------------
# File extensions
#--------------------

OBJ_EXT             = .s.o
ASM_EXT             = .s
C_DEP               = .c.dep
H_EXT               = .h
COBJ_EXT            = .c.o
C_EXT               = .c
EXE_EXT             = .elf
SHAREDLIB_EXT       = .so
CXX_DEP             = .cpp.dep
HPP_EXT             = .hpp
CPPOBJ_EXT          = .cpp.o
CPP_EXT             = .cpp
EXE_EXT             =
SHAREDLIB_EXT       = .so
STATICLIB_EXT       = .lib
MEX_EXT             = .mexw64
MAKE_EXT            = .mk


###########################################################################
## OUTPUT INFO
###########################################################################

PRODUCT = $(RELATIVE_PATH_TO_ANCHOR)/Top6DOFModel.elf
PRODUCT_TYPE = "executable"
BUILD_TYPE = "Top-Level Standalone Executable"

###########################################################################
## INCLUDE PATHS
###########################################################################

INCLUDES_BUILDINFO = -I$(MATLAB_WORKSPACE)/C/Program_Files/MATLAB/R2018b/toolbox/shared/spc/src_ml/extern/include -I$(MATLAB_WORKSPACE)/C/Program_Files/MATLAB/R2018b/toolbox/imaq/imaqblks/include -I$(MATLAB_WORKSPACE)/Z/My_Documents/MATLAB/AirTableSim/slprj/ert/UseHWSensorData -I$(MATLAB_WORKSPACE)/Z/My_Documents/MATLAB/AirTableSim/slprj/ert/TranslationalDynamics -I$(MATLAB_WORKSPACE)/Z/My_Documents/MATLAB/AirTableSim/slprj/ert/ThrusterModel0 -I$(MATLAB_WORKSPACE)/Z/My_Documents/MATLAB/AirTableSim/slprj/ert/SlidingModeControl -I$(MATLAB_WORKSPACE)/Z/My_Documents/MATLAB/AirTableSim/slprj/ert/ReactionWheel0 -I$(MATLAB_WORKSPACE)/Z/My_Documents/MATLAB/AirTableSim/slprj/ert/PIDControl -I$(MATLAB_WORKSPACE)/Z/My_Documents/MATLAB/AirTableSim/slprj/ert/AttitudeDynamics -I$(MATLAB_WORKSPACE)/Z/My_Documents/MATLAB/AirTableSim/slprj/ert/ApproachControl -I$(START_DIR) -I$(START_DIR)/Top6DOFModel_ert_rtw -I$(MATLAB_ROOT)/extern/include -I$(MATLAB_ROOT)/simulink/include -I$(MATLAB_ROOT)/rtw/c/src -I$(MATLAB_ROOT)/rtw/c/src/ext_mode/common -I$(MATLAB_ROOT)/rtw/c/ert -I$(START_DIR)/slprj/ert/_sharedutils -I$(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2018b/toolbox/realtime/targets/raspi/include -I$(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2018b/toolbox/realtime/targets/raspi/server -I$(MATLAB_ROOT)/toolbox/target/codertarget/rtos/inc -I$(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2018b/toolbox/target/shared/file_logging/include

INCLUDES_OPENCV = -I/usr/local/include/opencv4
INCLUDES_SERIAL = -I$(SERIAL_DIR)
INCLUDES_PHIDGET = -I$(PHIDGET_DIR)

INCLUDES = $(INCLUDES_OPENCV) $(INCLUDES_SERIAL) $(INCLUDES_PHIDGET) $(INCLUDES_BUILDINFO)

###########################################################################
## DEFINES
###########################################################################

DEFINES_ = -DMODEL=Top6DOFModel -DNUMST=2 -DNCSTATES=0 -DHAVESTDIO -DMODEL_HAS_DYNAMICALLY_LOADED_SFCNS=0 -DCLASSIC_INTERFACE=0 -DALLOCATIONFCN=0 -DTID01EQ=0 -DTERMFCN=1 -DONESTEPFCN=1 -DMAT_FILE=1 -DMULTI_INSTANCE_CODE=0 -DINTEGER_CODE=0 -DMT=1 -DARM_PROJECT -D_USE_TARGET_UDP_ -D_RUNONTARGETHARDWARE_BUILD_ -DSTACK_SIZE=64 -D__MW_TARGET_USE_HARDWARE_RESOURCES_H__ -DRT -DMAT_FILE_LOC=/home/pi -DMAX_MATFILE_NAME_LEN=64
DEFINES_BUILD_ARGS = -DCLASSIC_INTERFACE=0 -DALLOCATIONFCN=0 -DTERMFCN=1 -DONESTEPFCN=1 -DMAT_FILE=1 -DMULTI_INSTANCE_CODE=0 -DINTEGER_CODE=0 -DMT=1
DEFINES_IMPLIED = -DTID01EQ=0
DEFINES_SKIPFORSIL = -DARM_PROJECT -D_USE_TARGET_UDP_ -D_RUNONTARGETHARDWARE_BUILD_ -DSTACK_SIZE=64 -DRT
DEFINES_STANDARD = -DMODEL=Top6DOFModel -DNUMST=2 -DNCSTATES=0 -DHAVESTDIO -DMODEL_HAS_DYNAMICALLY_LOADED_SFCNS=0

DEFINES = $(DEFINES_) $(DEFINES_BUILD_ARGS) $(DEFINES_IMPLIED) $(DEFINES_SKIPFORSIL) $(DEFINES_STANDARD)

###########################################################################
## SOURCE FILES
###########################################################################

SRCS = $(START_DIR)/Top6DOFModel_ert_rtw/Top6DOFModel.c $(START_DIR)/Top6DOFModel_ert_rtw/Top6DOFModel_data.c $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2018b/toolbox/realtime/targets/raspi/server/MW_raspi_init.c $(MATLAB_ROOT)/toolbox/target/codertarget/rtos/src/linuxinitialize.c $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2018b/toolbox/target/shared/file_logging/src/ert_targets_logging.c $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2018b/toolbox/target/supportpackages/raspberrypi/src/raspi_file_logging.c

OPENCV_SRC = /home/pi/imageCapture/captureImage.c
SERIAL_SRC  = $(SERIAL_DIR)/serial_init.c $(SERIAL_DIR)/arduino-serial-lib.c $(SERIAL_DIR)/arduino-serial.c
PHIDGET_SRC = $(PHIDGET_DIR)/PhidgetHelperFunctions.c $(PHIDGET_DIR)/AccelerometerInit.c $(PHIDGET_DIR)/MagnetometerInit.c $(PHIDGET_DIR)/DistanceInit.c

MAIN_SRC = $(START_DIR)/Top6DOFModel_ert_rtw/ert_main.c

ALL_SRCS = $(SRCS) $OPENCV_SRC $(SERIAL_SRC) $(PHIDGET_SRC) $(MAIN_SRC)

###########################################################################
## OBJECTS
###########################################################################

OBJS = captureImage.c.o serial_init.c.o arduino-serial-lib.c.o arduino-serial.c.o PhidgetHelperFunctions.c.o AccelerometerInit.c.o MagnetometerInit.c.o DistanceInit.c.o Top6DOFModel.c.o Top6DOFModel_data.c.o MW_raspi_init.c.o linuxinitialize.c.o ert_targets_logging.c.o raspi_file_logging.c.o

MAIN_OBJ = ert_main.c.o

ALL_OBJS = $(OBJS) $(MAIN_OBJ)

###########################################################################
## PREBUILT OBJECT FILES
###########################################################################

PREBUILT_OBJS = 

###########################################################################
## LIBRARIES
###########################################################################

MODELREF_LIBS = ../slprj/ert/ApproachControl/ApproachControl_rtwlib.lib ../slprj/ert/AttitudeDynamics/AttitudeDynamics_rtwlib.lib ../slprj/ert/PIDControl/PIDControl_rtwlib.lib ../slprj/ert/ReactionWheel0/ReactionWheel0_rtwlib.lib ../slprj/ert/SlidingModeControl/SlidingModeControl_rtwlib.lib ../slprj/ert/ThrusterModel0/ThrusterModel0_rtwlib.lib ../slprj/ert/TranslationalDynamics/TranslationalDynamics_rtwlib.lib ../slprj/ert/UseHWSensorData/UseHWSensorData_rtwlib.lib

LIBS = $(SHARED_LIB)

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

CFLAGS_SKIPFORSIL =  
CFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CFLAGS += $(CFLAGS_SKIPFORSIL) $(CFLAGS_BASIC)

#-----------------
# C++ Compiler
#-----------------

CPPFLAGS_SKIPFORSIL =  
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


buildobj : prebuild $(OBJS) $(PREBUILT_OBJS) $(MODELREF_LIBS) $(LIBS)
	echo "### Successfully generated all binary outputs."


prebuild : 


download : build


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
	$(LD) $(LDFLAGS) -o $(PRODUCT) $(OBJS) $(MAIN_OBJ) ../slprj/ert/ApproachControl/ApproachControl_rtwlib.lib ../slprj/ert/AttitudeDynamics/AttitudeDynamics_rtwlib.lib ../slprj/ert/PIDControl/PIDControl_rtwlib.lib ../slprj/ert/ReactionWheel0/ReactionWheel0_rtwlib.lib ../slprj/ert/SlidingModeControl/SlidingModeControl_rtwlib.lib ../slprj/ert/ThrusterModel0/ThrusterModel0_rtwlib.lib ../slprj/ert/TranslationalDynamics/TranslationalDynamics_rtwlib.lib ../slprj/ert/UseHWSensorData/UseHWSensorData_rtwlib.lib $(LIBS) $(SYSTEM_LIBS) $(TOOLCHAIN_LIBS)
	echo "### Created: $(PRODUCT)"


###########################################################################
## INTERMEDIATE TARGETS
###########################################################################

#---------------------
# SOURCE-TO-OBJECT
#---------------------

%.c.o : %.c
	$(CC) $(CFLAGS) -o $@ $<


%.s.o : %.s
	$(AS) $(ASFLAGS) -o $@ $<


%.cpp.o : %.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.c.o : $(RELATIVE_PATH_TO_ANCHOR)/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.s.o : $(RELATIVE_PATH_TO_ANCHOR)/%.s
	$(AS) $(ASFLAGS) -o $@ $<


%.cpp.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.c.o : $(START_DIR)/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.s.o : $(START_DIR)/%.s
	$(AS) $(ASFLAGS) -o $@ $<


%.cpp.o : $(START_DIR)/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.c.o : $(START_DIR)/Top6DOFModel_ert_rtw/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.s.o : $(START_DIR)/Top6DOFModel_ert_rtw/%.s
	$(AS) $(ASFLAGS) -o $@ $<


%.cpp.o : $(START_DIR)/Top6DOFModel_ert_rtw/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.c.o : $(MATLAB_ROOT)/rtw/c/src/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.s.o : $(MATLAB_ROOT)/rtw/c/src/%.s
	$(AS) $(ASFLAGS) -o $@ $<


%.cpp.o : $(MATLAB_ROOT)/rtw/c/src/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.c.o : $(MATLAB_ROOT)/simulink/src/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.s.o : $(MATLAB_ROOT)/simulink/src/%.s
	$(AS) $(ASFLAGS) -o $@ $<


%.cpp.o : $(MATLAB_ROOT)/simulink/src/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


captureImage.c.o : /home/pi/imageCapture/captureImage.c
	$(CPP) $(CPPFLAGS) -o $@ $<

serial_init.c.o : $(SERIAL_DIR)/serial_init.c
	$(CC) $(CFLAGS) -o $@ $<

arduino-serial-lib.c.o : $(SERIAL_DIR)/arduino-serial-lib.c
	$(CC) $(CFLAGS) -o $@ $<

arduino-serial.c.o : $(SERIAL_DIR)/arduino-serial.c
	$(CC) $(CFLAGS) -o $@ $<

PhidgetHelperFunctions.c.o : $(PHIDGET_DIR)/PhidgetHelperFunctions.c
	$(CC) $(CFLAGS) -o $@ $<

AccelerometerInit.c.o : $(PHIDGET_DIR)/AccelerometerInit.c
	$(CC) $(CFLAGS) -o $@ $<

MagnetometerInit.c.o : $(PHIDGET_DIR)/MagnetometerInit.c
	$(CC) $(CFLAGS) -o $@ $<

DistanceInit.c.o : $(PHIDGET_DIR)/DistanceInit.c
	$(CC) $(CFLAGS) -o $@ $<

MW_raspi_init.c.o : $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2018b/toolbox/realtime/targets/raspi/server/MW_raspi_init.c
	$(CC) $(CFLAGS) -o $@ $<


linuxinitialize.c.o : $(MATLAB_ROOT)/toolbox/target/codertarget/rtos/src/linuxinitialize.c
	$(CC) $(CFLAGS) -o $@ $<


ert_targets_logging.c.o : $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2018b/toolbox/target/shared/file_logging/src/ert_targets_logging.c
	$(CC) $(CFLAGS) -o $@ $<


raspi_file_logging.c.o : $(MATLAB_WORKSPACE)/C/ProgramData/MATLAB/SupportPackages/R2018b/toolbox/target/supportpackages/raspberrypi/src/raspi_file_logging.c
	$(CC) $(CFLAGS) -o $@ $<


$(SHARED_BIN_DIR)/%.c.o : $(SHARED_SRC_DIR)/%.c
	echo "### Compiling $< ..."
	$(CC) $(CFLAGS) -o $@ $<


#---------------------------
# SHARED UTILITY LIBRARY
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


