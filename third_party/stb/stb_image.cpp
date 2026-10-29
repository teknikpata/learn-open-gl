// Compiles the stb_image implementation exactly once. Everything else just
// includes "stb_image.h" without defining STB_IMAGE_IMPLEMENTATION.
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
