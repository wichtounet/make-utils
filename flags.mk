# Define defaults warnings flags
ifneq (,$(findstring clang,$(CXX)))
	WARNING_FLAGS += -Wextra -Wall -Qunused-arguments -Wuninitialized -Wsometimes-uninitialized -Wno-long-long -Winit-self -Wdocumentation
else
ifneq (,$(findstring c++-analyzer,$(CXX)))
	WARNING_FLAGS += -Wextra -Wall -Qunused-arguments -Wuninitialized -Wsometimes-uninitialized -Wno-long-long -Winit-self -Wdocumentation
else
	WARNING_FLAGS += -Wextra -Wall -Wuninitialized -Wno-long-long -Winit-self
endif
endif

CXX_FLAGS += -Iinclude -std=c++1y $(WARNING_FLAGS)
LD_FLAGS += $(CXX_FLAGS)

DEBUG_FLAGS += -g
RELEASE_DEBUG_FLAGS += -g -O2

ifneq (,$(findstring clang,$(CXX)))
	RELEASE_FLAGS=-g -DNDEBUG -O3 -fvectorize -fslp-vectorize-aggressive -fomit-frame-pointer
else
ifneq (,$(findstring c++-analyzer,$(CXX)))
	RELEASE_FLAGS=-g -DNDEBUG -O3 -fvectorize -fslp-vectorize-aggressive -fomit-frame-pointer
else
	RELEASE_FLAGS=-g -DNDEBUG -O3 -fomit-frame-pointer
endif
endif

# Find the correct arch (when using distcc)

ifneq (,$(findstring distcc,$(CXX)))
	arch=$(shell g++ -march=native -Q --help=target | grep march | xargs | tr ' ' '\n' | tail -1)

# The equivalent of haswell for clang is core-avx2
ifeq (haswell,$(arch))
ifneq (,$(findstring clang,$(CXX)))
	arch=core-avx2
endif
ifneq (,$(findstring c++-analyzer,$(CXX)))
	arch=core-avx2
endif
endif

	#Find the equivalent march
	RELEASE_FLAGS += -march=$(arch)
	RELEASE_DEBUG_FLAGS += -march=$(arch)

	#TODO This is enough for clang++, but GCC needs much more arguments to simulate march=native
else
	#Without distcc, just use march=native
	RELEASE_FLAGS += -march=native
	RELEASE_DEBUG_FLAGS += -march=native
endif

# Use libc++ if the compiler is clang

define use_libcxx

ifneq (,$(findstring clang,$(CXX)))
CXX_FLAGS += -stdlib=libc++
endif

ifneq (,$(findstring c++-analyzer,$(CXX)))
CXX_FLAGS += -stdlib=libc++
endif

endef

# Enable coverage flags on debug mode only

define enable_coverage

ifneq (,$(findstring clang,$(CXX)))
DEBUG_FLAGS += -fprofile-arcs -ftest-coverage
else
ifneq (,$(findstring g++,$(CXX)))
DEBUG_FLAGS += --coverage
endif
endif

endef
