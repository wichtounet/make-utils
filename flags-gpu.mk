# Define defaults warnings flags for each compiler

ifneq (,$(findstring clang,$(CXX)))
	WARNING_FLAGS += -Xcompiler -Wextra -Xcompiler -Wall -Xcompiler -Qunused-arguments -Xcompiler -Wuninitialized -Xcompiler -Wsometimes-uninitialized -Xcompiler -Wno-long-long -Xcompiler -Winit-self -Xcompiler -Wdocumentation
else
ifneq (,$(findstring c++-analyzer,$(CXX)))
	WARNING_FLAGS += -Xcompiler -Xcompiler -Wextra -Xcompiler -Wall -Xcompiler -Qunused-arguments -Xcompiler -Wuninitialized -Xcompiler -Wsometimes-uninitialized -Xcompiler -Wno-long-long -Xcompiler -Winit-self -Xcompiler -Wdocumentation
else
	WARNING_FLAGS += -Xcompiler -Wextra -Xcompiler -Wall -Xcompiler -Wuninitialized -Xcompiler -Wno-long-long -Xcompiler -Winit-self
endif
endif

CXX_FLAGS += -Iinclude -std=c++11 $(WARNING_FLAGS)
LD_FLAGS += $(CXX_FLAGS)

DEBUG_FLAGS += -g
RELEASE_DEBUG_FLAGS += -g -O2

# Optimize flags based on compiler

ifneq (,$(findstring clang,$(CXX)))
	RELEASE_FLAGS=-g -DNDEBUG -O3 -Xcompiler -O3 -Xcompiler -fvectorize -Xcompiler -fslp-vectorize-aggressive -Xcompiler -fomit-frame-pointer
else
ifneq (,$(findstring c++-analyzer,$(CXX)))
	RELEASE_FLAGS=-g -DNDEBUG -O3 -Xcompiler -O3 -Xcompiler -fvectorize -Xcompiler -fslp-vectorize-aggressive -Xcompiler -fomit-frame-pointer
else
	RELEASE_FLAGS=-g -DNDEBUG -O3 -Xcompiler -O3 -Xcompiler -fomit-frame-pointer
endif
endif

#Without distcc, just use march=native
RELEASE_FLAGS += -Xcompiler -march=native
RELEASE_DEBUG_FLAGS += -Xcompiler -march=native
