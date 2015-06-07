ifneq (,$(findstring clang,$(CXX)))
	WARNING_FLAGS=-Wextra -Wall -Qunused-arguments -Wuninitialized -Wsometimes-uninitialized -Wno-long-long -Winit-self -Wdocumentation
else
ifneq (,$(findstring c++-analyzer,$(CXX)))
	WARNING_FLAGS=-Wextra -Wall -Qunused-arguments -Wuninitialized -Wsometimes-uninitialized -Wno-long-long -Winit-self -Wdocumentation
else
	WARNING_FLAGS=-Wextra -Wall -Wuninitialized -Wno-long-long -Winit-self
endif
endif

CXX_FLAGS=-Iinclude -std=c++11 $(WARNING_FLAGS)
LD_FLAGS=$(CXX_FLAGS)

DEBUG_FLAGS=-g
RELEASE_DEBUG_FLAGS=-g -O2
RELEASE_FLAGS=-g -DNDEBUG -O3 -fomit-frame-pointer
