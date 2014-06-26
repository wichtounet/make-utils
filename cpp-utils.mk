# Create rules to compile each cpp file of a folder

define folder_compile =

debug/src$(1)/%.cpp.o: src$(1)/%.cpp
	@ mkdir -p debug/src$(1)/
	$(CXX) $(CXX_FLAGS) $(DEBUG_FLAGS) -o $$@ -c $$<

release/src$(1)/%.cpp.o: src$(1)/%.cpp
	@ mkdir -p release/src$(1)/
	$(CXX) $(CXX_FLAGS) $(RELEASE_FLAGS) -o $$@ -c $$<

debug/src$(1)/%.cpp.d: $(CPP_FILES)
	@ mkdir -p debug/src$(1)/
	@ $(CXX) $(CXX_FLAGS) $(DEBUG_FLAGS) -MM -MT debug/src$(1)/$$*.cpp.o src$(1)/$$*.cpp | sed -e 's@^\(.*\)\.o:@\1.d \1.o:@' > $$@

release/src$(1)/%.cpp.d: $(CPP_FILES)
	@ mkdir -p release/src$(1)/
	@ $(CXX) $(CXX_FLAGS) $(RELEASE_FLAGS) -MM -MT release/src$(1)/$$*.cpp.o src$(1)/$$*.cpp | sed -e 's@^\(.*\)\.o:@\1.d \1.o:@' > $$@

endef

define test_folder_compile =

debug/test$(1)/%.cpp.o: test$(1)/%.cpp
	@ mkdir -p debug/test$(1)/
	$(CXX) $(CXX_FLAGS) $(DEBUG_FLAGS) -o $$@ -c $$<

release/test$(1)/%.cpp.o: test$(1)/%.cpp
	@ mkdir -p release/test$(1)/
	$(CXX) $(CXX_FLAGS) $(RELEASE_FLAGS) -o $$@ -c $$<

debug/test$(1)/%.cpp.d: $(CPP_FILES)
	@ mkdir -p debug/test$(1)/
	@ $(CXX) $(CXX_FLAGS) $(DEBUG_FLAGS) -MM -MT debug/test$(1)/$$*.cpp.o test$(1)/$$*.cpp | sed -e 's@^\(.*\)\.o:@\1.d \1.o:@' > $$@

release/test$(1)/%.cpp.d: $(CPP_FILES)
	@ mkdir -p release/test$(1)/
	@ $(CXX) $(CXX_FLAGS) $(RELEASE_FLAGS) -MM -MT release/test$(1)/$$*.cpp.o test$(1)/$$*.cpp | sed -e 's@^\(.*\)\.o:@\1.d \1.o:@' > $$@

endef

# Create rules to link an executable with a set of files

define add_executable =

debug/bin/$(1): $(addsuffix .o,$(addprefix debug/src/,$(2)))
	@ mkdir -p debug/bin/
	$(LD) $(LD_FLAGS) $(3) $(DEBUG_FLAGS) -o $$@ $$+

release/bin/$(1): $(addsuffix .o,$(addprefix release/src/,$(2)))
	@ mkdir -p release/bin/
	$(LD) $(LD_FLAGS) $(3) $(RELEASE_FLAGS) -o $$@ $$+

endef

define add_test_executable =

debug/bin/$(1): $(addsuffix .o,$(addprefix debug/test/,$(2)))
	@ mkdir -p debug/bin/
	$(LD) $(LD_FLAGS) $(3) $(DEBUG_FLAGS) -o $$@ $$+

release/bin/$(1): $(addsuffix .o,$(addprefix release/test/,$(2)))
	@ mkdir -p release/bin/
	$(LD) $(LD_FLAGS) $(3) $(RELEASE_FLAGS) -o $$@ $$+

endef

# Create executable sets targets

define add_executable_set =

release_$(1): $(addprefix release/bin/,$(2))
debug_$(1): $(addprefix debug/bin/,$(2))
$(1): release_$(1)

endef