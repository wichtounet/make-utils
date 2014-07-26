CXX=clang++
LD=clang++

WARNING_FLAGS=-Wextra -Wall -Qunused-arguments -Wuninitialized -Wsometimes-uninitialized -Wno-long-long -Winit-self -Wdocumentation
CXX_FLAGS=-Iinclude -std=c++1y $(WARNING_FLAGS)
LD_FLAGS=$(CXX_FLAGS) 

DEBUG_FLAGS=-g
RELEASE_FLAGS=-g -DNDEBUG -Ofast -march=native -fvectorize -fslp-vectorize-aggressive -fomit-frame-pointer