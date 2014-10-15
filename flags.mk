CXX=clang++
LD=clang++

ifneq (,$(findstring clang,$(CXX)))
	WARNING_FLAGS=-Wextra -Wall -Qunused-arguments -Wuninitialized -Wsometimes-uninitialized -Wno-long-long -Winit-self -Wdocumentation
else
	WARNING_FLAGS=-Wextra -Wall -Wuninitialized -Wno-long-long -Winit-self
endif

CXX_FLAGS=-Iinclude -std=c++1y $(WARNING_FLAGS)
LD_FLAGS=$(CXX_FLAGS)

DEBUG_FLAGS=-g

ifneq (,$(findstring clang,$(CXX)))
	RELEASE_FLAGS=-g -DNDEBUG -O3 -fvectorize -fslp-vectorize-aggressive -fomit-frame-pointer
else
	RELEASE_FLAGS=-g -DNDEBUG -O3 -fomit-frame-pointer
endif

# If we do not compile with distcc, enable march=native
ifeq (,$(findstring distcc,$(CXX)))
	RELEASE_FLAGS += -march=native
endif