make-utils
==========

This repository provides simple utilities to build c++ projects using makefiles
in a simpler way.

Your header files need to be in *include* folder and source files are expected to be separated in another folders. You can have several source folders and you can create different executables.

Ideally, you should put the make-utils directory directly in your project root tree, but this is not necessary.

Basic Example
#############

Here is a base example of using it for a simple program::

    default: release

    .PHONY: default release debug all clean

    include make-utils/flags.mk
    include make-utils/cpp-utils.mk

    # Change the use flags
    CXX_FLAGS += -Werror -pedantic

    # Compile the folder source
    $(eval $(call auto_folder_compile,src))

    # Create an executable with all the sources from auto_folder_compile calls
    $(eval $(call auto_add_executable,example))

    # Create a second executable from a single file
    $(eval $(call folder_compile,sub))
    $(eval $(call add_executable,sub,sub/simple.cpp))

    release: release/bin/example
    release_debug: release_debug/bin/example
    debug: debug/bin/example

    all: release release_debug debug

    clean: base_clean

    include make-utils/cpp-utils-finalize.mk

You can choose in which mode you want to compile your project (debug, release, release_debug), each being compiled in a different folder. Therefore, you compile all three of them and test them.

More Examples
#############

This project is used in other projects, here are the makefiles:

* cpm project (simple): https://github.com/wichtounet/cpm/blob/master/Makefile
* eddic project (complex): https://github.com/wichtounet/eddic/blob/develop/Makefile
* etl project (complex): https://github.com/wichtounet/etl/blob/master/Makefile
* dll project (complex): https://github.com/wichtounet/dll/blob/master/Makefile
