CXX=clang++
LD=clang++

ifeq ($(CXX),clang++)
	WARNING_FLAGS=-Wextra -Wall -Qunused-arguments -Wuninitialized -Wsometimes-uninitialized -Wno-long-long -Winit-self -Wdocumentation
else
	WARNING_FLAGS=-Wextra -Wall -Wuninitialized -Wno-long-long -Winit-self
endif

CXX_FLAGS=-Iinclude -std=c++1y $(WARNING_FLAGS)
LD_FLAGS=$(CXX_FLAGS) 

DEBUG_FLAGS=-g

ifeq ($(CXX),clang++)
	RELEASE_FLAGS=-g -DNDEBUG -O3 -march=native -fvectorize -fslp-vectorize-aggressive -fomit-frame-pointer
else
	RELEASE_FLAGS=-g -DNDEBUG -O3 -march=native -fomit-frame-pointer
endif