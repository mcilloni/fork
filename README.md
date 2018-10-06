fork
====


*fork* is the main repository for the Fork language.
This repository provides tools to use and build fork programs.

Until a real, `fork` build is ready, this repository allows Fork to be built using
a simple tool called `transmod` (see tools/transmod).
`transmod` parses (via `libforkparse`) a Fork module, and then translates it to
a C file using `libctrans`, creating a `.ford` binary module.


# How to build
Use _GNU make_ to bootstrap fork.
You need an already existing binary release of fork with `transmod` to build this, and it should
be in your path (you can otherwise use the TRNS env var to specify which `transmod` the Makefile should use).

`$ make`

# Usage

> .ford files:
The `FORDPATHS` environment variable sets the search paths for _.ford_ files.
_.ford_ files are the binary representation of precedently build modules, and are necessary to import them through an `import` statement.

You can build a fork module (that should be contained into a single directory)
with transmod:

```sh
$ env FORDPATHS=$MY_FORD_PATH transmod -fo $OUT_DIR_FOR_FORDS -co $OUT_DIR_FOR_C_FILES -n $FILE_NAME moduledir
```

If not specified, the module name is either the one specified by the files of the module itself, or _main_ if this is a main module.

Compile then all the files with a C99 compiler (GCC, ICC and Clang are currently supported):

```sh
$ cc -c -w -g -std=c99 file.c
$ # in case this is a program and not a library
$ cc -o prog file.o $PATH_TO_LIBFORK/libfork.a $PATH_TO_RT_O/rt.o
```

Remember to link rt.o: it contains the entry point of a Fork application.
libforkparse.a and libctrans.a are part of the compiler and are generally not very useful to a normal user of the language.
