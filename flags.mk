# The default compiler is gcc
compiler=gcc

ifeq (gcc, $(compiler)) 
	version=15
else
ifeq (clang, $(compiler)) 
	version=20
else
$(error Unsupported compiler)
endif
endif

ifeq (gcc, $(compiler)) 
	cc=gcc-$(version)
	cxx=g++-$(version)
endif

ifeq (clang, $(compiler)) 
	cc=clang-$(version)
	cxx=clang++-$(version)
endif

cc_out=$(compiler)-${version}

# Define defaults warnings flags for each compiler

ifeq (clang, $(compiler))
	WARNING_FLAGS += -Wextra -Wall -Qunused-arguments -Wuninitialized -Wsometimes-uninitialized -Wno-long-long -Winit-self -Wdocumentation
else
	WARNING_FLAGS += -Wextra -Wall -Wuninitialized -Wno-long-long -Winit-self
endif

CXX_FLAGS += -Iinclude $(WARNING_FLAGS)
LD_FLAGS += $(CXX_FLAGS)

# Custom optimization flags
DEBUG_FLAGS += -g
RELEASE_DEBUG_FLAGS += -g -O2
RELEASE_FLAGS += -g -DNDEBUG -O3 -fomit-frame-pointer

# just use march=native
RELEASE_FLAGS += -march=native
RELEASE_DEBUG_FLAGS += -march=native

# Use C++11

define use_cpp11
CXX_FLAGS += -std=c++11
endef

# Use C++14

define use_cpp14
CXX_FLAGS += -std=c++14
endef

# Use C++17

define use_cpp17
CXX_FLAGS += -std=c++17
endef

# Use C++20

define use_cpp20
CXX_FLAGS += -std=c++20
endef

# Use C++23

define use_cpp23
CXX_FLAGS += -std=c++23
endef

# Use C++26

define use_cpp26
CXX_FLAGS += -std=c++26
endef

# Use libc++ if the compiler is clang

define use_libcxx

ifeq (clang, $(compiler))
CXX_FLAGS += -stdlib=libc++
endif

endef

# Enable ASAN flags on debug mode only

define enable_asan_debug
DEBUG_FLAGS += -fsanitize=address
endef

# Enable coverage flags on debug mode only

define enable_coverage

ifeq (clang, $(compiler))
DEBUG_FLAGS += -fprofile-arcs -ftest-coverage
endif

ifeq (gcc, $(compiler))
DEBUG_FLAGS += --coverage -fprofile-abs-path
endif

endef

# Enable coverage flags on release mode only

define enable_coverage_release

ifeq (clang, $(compiler))
RELEASE_FLAGS += -fprofile-arcs -ftest-coverage
endif

ifeq (gcc, $(compiler))
RELEASE_FLAGS += --coverage -fprofile-abs-path
endif

endef

# Enable coverage flags on release_debug mode only

define enable_coverage_release_debug

ifeq (clang, $(compiler))
RELEASE_DEBUG_FLAGS += -fprofile-arcs -ftest-coverage
endif

ifeq (gcc, $(compiler))
RELEASE_DEBUG_FLAGS += --coverage -fprofile-abs-path
endif

endef
