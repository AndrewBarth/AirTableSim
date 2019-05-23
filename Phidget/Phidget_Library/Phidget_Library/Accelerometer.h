#pragma once
#include "stdafx.h"
#include "phidget22.h"

_declspec(dllexport) int Accelerometermain(double*, double*, double*, double*);
_declspec(dllexport) int AccelerometerLoop(PhidgetAccelerometerHandle, double*, double*, double*, double*);
