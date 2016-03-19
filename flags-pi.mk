# This file contains flags that are more limited in order to make
# a program compile on a Raspberry Pi

# Define warnings flags
ifneq (,$(findstring clang,$(CXX)))
	WARNING_FLAGS=-Wextra -Wall -Qunused-arguments -Wuninitialized -Wsometimes-uninitialized -Wno-long-long -Winit-self -Wdocumentation
else
ifneq (,$(findstring c++-analyzer,$(CXX)))
	WARNING_FLAGS=-Wextra -Wall -Qunused-arguments -Wuninitialized -Wsometimes-uninitialized -Wno-long-long -Winit-self -Wdocumentation
else
	WARNING_FLAGS=-Wextra -Wall -Wuninitialized -Wno-long-long -Winit-self
endif
endif

CXX_FLAGS=-Iinclude -std=c++0x $(WARNING_FLAGS)

# Indicate that this is a Pi
ifeq (,$(MAKE_NO_RPI))
	CXX_FLAGS += -D__RPI__
endif

LD_FLAGS=$(CXX_FLAGS)

DEBUG_FLAGS=-g
RELEASE_DEBUG_FLAGS=-g -O2
RELEASE_FLAGS=-g -DNDEBUG -O3 -fomit-frame-pointer
