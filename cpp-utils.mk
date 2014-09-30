# Create rules to compile each cpp file of a folder

AUTO_SRC_FILES=

define folder_compile =

debug/$(1)/%.cpp.o: $(1)/%.cpp
	@ mkdir -p debug/$(1)/
	$(CXX) $(CXX_FLAGS) $(DEBUG_FLAGS) -o $$@ -c $$<

release/$(1)/%.cpp.o: $(1)/%.cpp
	@ mkdir -p release/$(1)/
	$(CXX) $(CXX_FLAGS) $(RELEASE_FLAGS) -o $$@ -c $$<

debug/$(1)/%.cpp.d: $(CPP_FILES)
	@ mkdir -p debug/$(1)/
	@ $(CXX) $(CXX_FLAGS) $(DEBUG_FLAGS) -MM -MT debug/$(1)/$$*.cpp.o $(1)/$$*.cpp | sed -e 's@^\(.*\)\.o:@\1.d \1.o:@' > $$@

release/$(1)/%.cpp.d: $(CPP_FILES)
	@ mkdir -p release/$(1)/
	@ $(CXX) $(CXX_FLAGS) $(RELEASE_FLAGS) -MM -MT release/$(1)/$$*.cpp.o $(1)/$$*.cpp | sed -e 's@^\(.*\)\.o:@\1.d \1.o:@' > $$@

endef

define src_folder_compile =

$(eval $(call folder_compile,src$(1)))

endef

define test_folder_compile =

$(eval $(call folder_compile,test$(1)))

endef

define auto_folder_compile =

$(eval $(call folder_compile,$(1)))

AUTO_SRC_FILES += $(wildcard $(1)/*.cpp)

endef

# Create rules to link an executable with a set of files

define add_executable =

debug/bin/$(1): $(addsuffix .o,$(addprefix debug/,$(2)))
	@ mkdir -p debug/bin/
	$(LD) $(LD_FLAGS) $(3) $(DEBUG_FLAGS) -o $$@ $$+

release/bin/$(1): $(addsuffix .o,$(addprefix release/,$(2)))
	@ mkdir -p release/bin/
	$(LD) $(LD_FLAGS) $(3) $(RELEASE_FLAGS) -o $$@ $$+

endef

define add_src_executable =

$(eval $(call add_executable,$(1),$(addprefix src/,$(2))))

endef

define add_test_executable =

$(eval $(call add_executable,$(1),$(addprefix test/,$(2))))

endef

define add_auto_src_executable =

$(eval $(call add_executable,$(1),$(wildcard src/*.cpp)))

endef

define auto_add_executable =

$(eval $(call add_executable,$(1),$(AUTO_SRC_FILES)))
$(eval $(call add_executable_set,$(1),$(1)))

endef

# Create executable sets targets

define add_executable_set =

release_$(1): $(addprefix release/bin/,$(2))
debug_$(1): $(addprefix debug/bin/,$(2))
$(1): release_$(1)

endef

# Include D files

define auto_finalize = 

AUTO_DEBUG_D_FILES=$(AUTO_SRC_FILES:%.cpp=debug/%.cpp.d)
AUTO_RELEASE_D_FILES=$(AUTO_SRC_FILES:%.cpp=release/%.cpp.d)

-include $(AUTO_DEBUG_D_FILES)
-include $(AUTO_RELEASE_D_FILES)

endef

# Clean targets

.PHONY: base_clean

base_clean:
	rm -rf release/
	rm -rf debug/