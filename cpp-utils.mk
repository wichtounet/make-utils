AUTO_CXX_SRC_FILES=
AUTO_SIMPLE_C_SRC_FILES=

# Configure the colors (optional)
ifneq (1,$(MU_NOCOLOR))
NO_COLOR=\x1b[0m
MODE_COLOR=\x1b[31;01m
FILE_COLOR=\x1b[35;01m
else
NO_COLOR=
MODE_COLOR=
FILE_COLOR=
endif

Q ?= @

# Create rules to compile each .cpp file of a folder

define folder_compile

# Object files

debug/$(1)/%.cpp.o: $(1)/%.cpp
	@mkdir -p debug/$(1)/
	@echo -e "$(MODE_COLOR)[debug]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.cpp$(NO_COLOR)"
	$(Q)$(CXX) $(DEBUG_FLAGS) $(CXX_FLAGS) $(2) -MD -MF debug/$(1)/$$*.cpp.d -o debug/$(1)/$$*.cpp.o -c $(1)/$$*.cpp
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' debug/$(1)/$$*.cpp.d

release/$(1)/%.cpp.o: $(1)/%.cpp
	@mkdir -p release/$(1)/
	@echo -e "$(MODE_COLOR)[release]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.cpp$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_FLAGS) $(CXX_FLAGS) $(2) -MD -MF release/$(1)/$$*.cpp.d -o release/$(1)/$$*.cpp.o -c $(1)/$$*.cpp
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' release/$(1)/$$*.cpp.d

release_debug/$(1)/%.cpp.o: $(1)/%.cpp
	@mkdir -p release_debug/$(1)/
	@echo -e "$(MODE_COLOR)[release_debug]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.cpp$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_DEBUG_FLAGS) $(CXX_FLAGS) $(2) -MD -MF release_debug/$(1)/$$*.cpp.d -o release_debug/$(1)/$$*.cpp.o -c $(1)/$$*.cpp
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' release_debug/$(1)/$$*.cpp.d

# Assembly files

debug/$(1)/%.cpp.s: $(1)/%.cpp
	@mkdir -p debug/$(1)/
	@echo -e "$(MODE_COLOR)[debug]$(NO_COLOR) Compile (assembly) $(FILE_COLOR)$(1)/$$*.cpp$(NO_COLOR)"
	$(Q)$(CXX) -S $(DEBUG_FLAGS) $(CXX_FLAGS) $(2) -o debug/$(1)/$$*.cpp.s -c $(1)/$$*.cpp

release/$(1)/%.cpp.s: $(1)/%.cpp
	@mkdir -p release/$(1)/
	@echo -e "$(MODE_COLOR)[release]$(NO_COLOR) Compile (assembly) $(FILE_COLOR)$(1)/$$*.cpp$(NO_COLOR)"
	$(Q)$(CXX) -S $(RELEASE_FLAGS) $(CXX_FLAGS) $(2) -o release/$(1)/$$*.cpp.s -c $(1)/$$*.cpp

release_debug/$(1)/%.cpp.s: $(1)/%.cpp
	@mkdir -p release_debug/$(1)/
	@echo -e "$(MODE_COLOR)[release_debug]$(NO_COLOR) Compile (assembly) $(FILE_COLOR)$(1)/$$*.cpp$(NO_COLOR)"
	$(Q)$(CXX) -S $(RELEASE_DEBUG_FLAGS) $(CXX_FLAGS) $(2) -o release_debug/$(1)/$$*.cpp.s -c $(1)/$$*.cpp

endef

# Create rules to compile each .cpp and cu file of a folder

define folder_compile_gpu

# Object files

debug/$(1)/%.cpp.o: $(1)/%.cpp
	@mkdir -p debug/$(1)/
	@echo -e "$(MODE_COLOR)[debug]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.cpp$(NO_COLOR)"
	$(Q)$(CXX) $(DEBUG_FLAGS) $(CXX_FLAGS) $(2) -Xcompiler -MD -Xcompiler -MF -Xcompiler debug/$(1)/$$*.cpp.d -o debug/$(1)/$$*.cpp.o -c $(1)/$$*.cpp
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' debug/$(1)/$$*.cpp.d

release/$(1)/%.cpp.o: $(1)/%.cpp
	@mkdir -p release/$(1)/
	@echo -e "$(MODE_COLOR)[release]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.cpp$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_FLAGS) $(CXX_FLAGS) $(2) -Xcompiler -MD -Xcompiler -MF -Xcompiler release/$(1)/$$*.cpp.d -o release/$(1)/$$*.cpp.o -c $(1)/$$*.cpp
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' release/$(1)/$$*.cpp.d

release_debug/$(1)/%.cpp.o: $(1)/%.cpp
	@mkdir -p release_debug/$(1)/
	@echo -e "$(MODE_COLOR)[release_debug]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.cpp$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_DEBUG_FLAGS) $(CXX_FLAGS) $(2) -Xcompiler -MD -Xcompiler -MF -Xcompiler release_debug/$(1)/$$*.cpp.d -o release_debug/$(1)/$$*.cpp.o -c $(1)/$$*.cpp
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' release_debug/$(1)/$$*.cpp.d

debug/$(1)/%.cu.o: $(1)/%.cu
	@mkdir -p debug/$(1)/
	@echo -e "$(MODE_COLOR)[debug]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.cu$(NO_COLOR)"
	$(Q)$(CXX) $(DEBUG_FLAGS) $(CXX_FLAGS) $(2) -Xcompiler -MD -Xcompiler -MF -Xcompiler debug/$(1)/$$*.cu.d -o debug/$(1)/$$*.cu.o -c $(1)/$$*.cu
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' debug/$(1)/$$*.cu.d

release/$(1)/%.cu.o: $(1)/%.cu
	@mkdir -p release/$(1)/
	@echo -e "$(MODE_COLOR)[release]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.cu$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_FLAGS) $(CXX_FLAGS) $(2) -Xcompiler -MD -Xcompiler -MF -Xcompiler release/$(1)/$$*.cu.d -o release/$(1)/$$*.cu.o -c $(1)/$$*.cu
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' release/$(1)/$$*.cu.d

release_debug/$(1)/%.cu.o: $(1)/%.cu
	@mkdir -p release_debug/$(1)/
	@echo -e "$(MODE_COLOR)[release_debug]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.cu$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_DEBUG_FLAGS) $(CXX_FLAGS) $(2) -Xcompiler -MD -Xcompiler -MF -Xcompiler release_debug/$(1)/$$*.cu.d -o release_debug/$(1)/$$*.cu.o -c $(1)/$$*.cu
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' release_debug/$(1)/$$*.cu.d

endef

# Create rules to compile each .c file of a folder (C files are compiled in C++ mode)

define simple_c_folder_compile

debug/$(1)/%.c.o: $(1)/%.c
	@ mkdir -p debug/$(1)/
	@echo -e "$(MODE_COLOR)[debug]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.c$(NO_COLOR)"
	$(Q)$(CXX) $(CXX_FLAGS) $(DEBUG_FLAGS) $(2) -MD -MF debug/$(1)/$$*.c.d -o debug/$(1)/$$*.c.o -c $(1)/$$*.c
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' debug/$(1)/$$*.c.d

release/$(1)/%.c.o: $(1)/%.c
	@ mkdir -p release/$(1)/
	@echo -e "$(MODE_COLOR)[release]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.c$(NO_COLOR)"
	$(Q)$(CXX) $(CXX_FLAGS) $(RELEASE_FLAGS) $(2) -MD -MF release/$(1)/$$*.c.d -o release/$(1)/$$*.c.o -c $(1)/$$*.c
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' release/$(1)/$$*.c.d

release_debug/$(1)/%.c.o: $(1)/%.c
	@ mkdir -p release_debug/$(1)/
	@echo -e "$(MODE_COLOR)[release_debug]$(NO_COLOR) Compile $(FILE_COLOR)$(1)/$$*.c$(NO_COLOR)"
	$(Q)$(CXX) $(CXX_FLAGS) $(RELEASE_DEBUG_FLAGS) $(2) -MD -MF release_debug/$(1)/$$*.c.d -o release_debug/$(1)/$$*.c.o -c $(1)/$$*.c
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' release_debug/$(1)/$$*.c.d

endef

define precompile_init

DEBUG_FLAGS = -Idebug/$(1) $(DEBUG_FLAGS)
RELEASE_FLAGS = -Irelease/$(1) $(RELEASE_FLAGS)
RELEASE_DEBUG_FLAGS = -Irelease_debug/$(1) $(RELEASE_DEBUG_FLAGS)

endef

define precompile_header

debug/$(1)/$(2).gch: $(1)/$(2)
	@mkdir -p debug/$(1)/
	@echo -e "$(MODE_COLOR)[debug]$(NO_COLOR) Precompile header $(FILE_COLOR)$(1)/$(2)$(NO_COLOR)"
	$(Q)$(CXX) $(DEBUG_FLAGS) $(CXX_FLAGS) -MD -MF debug/$(1)/$(2).d -o debug/$(1)/$(2).gch -c $(1)/$(2)
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' debug/$(1)/$(2).d
	@ echo "#error PCH Header was not used (probably invalid)" > debug/$(1)/$(2)

release/$(1)/$(2).gch: $(1)/$(2)
	@mkdir -p release/$(1)/
	@echo -e "$(MODE_COLOR)[release]$(NO_COLOR) Precompile header $(FILE_COLOR)$(1)/$(2)$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_FLAGS) $(CXX_FLAGS) -MD -MF release/$(1)/$(2).d -o release/$(1)/$(2).gch -c $(1)/$(2)
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' release/$(1)/$(2).d
	@ echo "#error PCH Header was not used (probably invalid)" > release/$(1)/$(2)

release_debug/$(1)/$(2).gch: $(1)/$(2)
	@mkdir -p release_debug/$(1)/
	@echo -e "$(MODE_COLOR)[release_debug]$(NO_COLOR) Precompile header $(FILE_COLOR)$(1)/$(2)$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_DEBUG_FLAGS) $(CXX_FLAGS) -MD -MF release_debug/$(1)/$(2).d -o release_debug/$(1)/$(2).gch -c $(1)/$(2)
	@ sed -i -e 's@^\(.*\)\.o:@\1.d \1.o:@' release_debug/$(1)/$(2).d
	@ echo "#error PCH Header was not used (probably invalid)" > release_debug/$(1)/$(2)

DEBUG_PCH_FILES += debug/$(1)/$(2).gch
RELEASE_PCH_FILES += release/$(1)/$(2).gch
RELEASE_DEBUG_PCH_FILES += release_debug/$(1)/$(2).gch

AUTO_DEBUG_D_FILES += debug/$(1)/$(2).d
AUTO_RELEASE_D_FILES += release/$(1)/$(2).d
AUTO_RELEASE_DEBUG_D_FILES += release_debug/$(1)/$(2).d

endef

define precompile_finalize

.PHONY: debug_pch release_pch release_debug_pch

debug_pch: $(DEBUG_PCH_FILES)
release_pch: $(RELEASE_PCH_FILES)
release_debug_pch: $(RELEASE_DEBUG_PCH_FILES)

clean_pch:
	rm -rf $(DEBUG_PCH_FILES)
	rm -rf $(RELEASE_PCH_FILES)
	rm -rf $(RELEASE_DEBUG_PCH_FILES)

endef


# Create rules to compile the src folder

define src_folder_compile

$(eval $(call folder_compile,src$(1),$(2)))

endef

# Create rules to compile the test folder

define test_folder_compile

$(eval $(call folder_compile,test$(1),$(2)))

endef

# Create rules to compile cpp files in the given folder and gather source files from it

define auto_folder_compile

$(eval $(call folder_compile,$(1),$(2)))

AUTO_SRC_FILES += $(wildcard $(1)/*.cpp)
AUTO_CXX_SRC_FILES += $(wildcard $(1)/*.cpp)

endef

# Create rules to compile cpp files in the given folder and gather source files from it

define auto_folder_compile_gpu

$(eval $(call folder_compile_gpu,$(1),$(2)))

AUTO_SRC_FILES += $(wildcard $(1)/*.cpp) $(wildcard $(1)/*.cu)
AUTO_CXX_SRC_FILES += $(wildcard $(1)/*.cpp)
AUTO_GPU_SRC_FILES += $(wildcard $(1)/*.cu)

endef

# Create rules to compile C files in the given folder and gather source files from it

define auto_simple_c_folder_compile

$(eval $(call simple_c_folder_compile,$(1),$(2)))

AUTO_SRC_FILES += $(wildcard $(1)/*.c)
AUTO_SIMPLE_C_SRC_FILES += $(wildcard $(1)/*.c)

endef

# Create rules to link an executable with a set of files

define add_executable

debug/bin/$(1): $(addsuffix .o,$(addprefix debug/,$(2)))
	@mkdir -p debug/bin/
	@echo -e "$(MODE_COLOR)[debug]$(NO_COLOR) Link $(FILE_COLOR)$$@$(NO_COLOR)"
	$(Q)$(CXX) $(DEBUG_FLAGS) -o $$@ $$+ $(LD_FLAGS) $(3)

release/bin/$(1): $(addsuffix .o,$(addprefix release/,$(2)))
	@mkdir -p release/bin/
	@echo -e "$(MODE_COLOR)[release]$(NO_COLOR) Link $(FILE_COLOR)$$@$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_FLAGS) -o $$@ $$+ $(LD_FLAGS) $(3)

release_debug/bin/$(1): $(addsuffix .o,$(addprefix release_debug/,$(2)))
	@mkdir -p release_debug/bin/
	@echo -e "$(MODE_COLOR)[release_debug]$(NO_COLOR) Link $(FILE_COLOR)$$@$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_DEBUG_FLAGS) -o $$@ $$+ $(LD_FLAGS) $(3)

endef

# Create rules to link a shared library with a set of files

define add_shared_library

debug/lib/$(1).so: $(addsuffix .o,$(addprefix debug/,$(2)))
	@mkdir -p debug/lib/
	@echo -e "$(MODE_COLOR)[debug]$(NO_COLOR) Link $(FILE_COLOR)$$@$(NO_COLOR)"
	$(Q)$(CXX) $(DEBUG_FLAGS) --shared -o $$@ $$+ $(LD_FLAGS) $(3)

release/lib/$(1).so: $(addsuffix .o,$(addprefix release/,$(2)))
	@mkdir -p release/lib/
	@echo -e "$(MODE_COLOR)[release]$(NO_COLOR) Link $(FILE_COLOR)$$@$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_FLAGS) --shared -o $$@ $$+ $(LD_FLAGS) $(3)

release_debug/lib/$(1).so: $(addsuffix .o,$(addprefix release_debug/,$(2)))
	@mkdir -p release_debug/lib/
	@echo -e "$(MODE_COLOR)[release_debug]$(NO_COLOR) Link $(FILE_COLOR)$$@$(NO_COLOR)"
	$(Q)$(CXX) $(RELEASE_DEBUG_FLAGS) --shared -o $$@ $$+ $(LD_FLAGS) $(3)

endef

# Creates rules to create an executable with all the given files in the src folder

define add_src_executable

$(eval $(call add_executable,$(1),$(addprefix src/,$(2)),$(3)))

endef

# Creates rules to create an executable with all the given files in the test folder

define add_test_executable

$(eval $(call add_executable,$(1),$(addprefix test/,$(2)),$(3)))

endef

# Creates rules to create an executable with all the files of the src folder

define add_auto_src_executable

$(eval $(call add_executable,$(1),$(wildcard src/*.cpp)))

endef

# Creates rules to create an executable with all the files of the test folder

define add_auto_test_executable

$(eval $(call add_executable,$(1),$(wildcard test/*.cpp)))

endef

# Create an executable with all the files gather with auto_folder_compile

define auto_add_executable

$(eval $(call add_executable,$(1),$(AUTO_SRC_FILES)))
$(eval $(call add_executable_set,$(1),$(1)))

endef

# Create executable sets targets

define add_executable_set

release_$(1): $(addprefix release/bin/,$(2))
release_debug_$(1): $(addprefix release_debug/bin/,$(2))
debug_$(1): $(addprefix debug/bin/,$(2))
$(1): release_$(1)

endef

# Include D files

define auto_finalize

AUTO_DEBUG_D_FILES += $(AUTO_CXX_SRC_FILES:%.cpp=debug/%.cpp.d) $(AUTO_GPU_SRC_FILES:%.cu=debug/%.cu.d) $(AUTO_SIMPLE_C_SRC_FILES:%.c=debug/%.c.d)
AUTO_RELEASE_D_FILES += $(AUTO_CXX_SRC_FILES:%.cpp=release/%.cpp.d) $(AUTO_CXX_SRC_FILES:%.cpp=release/%.cpp.d) $(AUTO_SIMPLE_C_SRC_FILES:%.c=release/%.c.d)
AUTO_RELEASE_DEBUG_D_FILES += $(AUTO_CXX_SRC_FILES:%.cpp=release_debug/%.cpp.d) $(AUTO_CXX_SRC_FILES:%.cpp=release/%.cpp.d) $(AUTO_SIMPLE_C_SRC_FILES:%.c=release_debug/%.c.d)

endef

# Target to generate the compilation database for clang

.PHONY: compile_db

compile_commands.json:
	${MAKE} clean
	bear make debug

compile_db: compile_commands.json ;

# Clean target

.PHONY: base_clean

base_clean:
	rm -rf release/
	rm -rf release_debug/
	rm -rf debug/
