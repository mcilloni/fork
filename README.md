fork
====


**fork** is a compiled, procedural, imperative language that I've developed in my spare time a few years ago (2014~2016) mostly as a toy, and as a way to tinker and learn how parsers and compilers work.  

This repository contains a rudimental, but functional, self hosting compiler and its runtime/library, which includes several modules implementing basic I/O, containers (such as hashmaps, vectors and treemaps). Almost everything contained in this repository is written in Fork itself, including the runtime and the compiler; there are however a few C files still lingering around, mostly as glue code between fork and `libc`.  
Sadly, only POSIX-compliant, 64-bit OS work at the moment, due to some unfortunate assumptions present in the code and lack of a Windows implementation for some functions.

This is obviously super experimental, and was never meant to ever be nothing but a playground for tinkering around, so it might crash horribly, eat your babies and destroy whatever's left of your hopes and dreams.

## The language

Fork is a rather low level language imperative, procedural language that provides an experience rather close to C (with which shares the memory model, same ABI and concepts). Given its nature as a hobby and an experiment, its syntax has been designed to feel purposely "different" than other commonly used programming languages:

- Blocks are delimited by `<keyword>` `/<keyword>` identifiers, i.e.,
    ```fork
    func deinit(kv ptr KVList)
        kv.freeContents()

        hash:deinit(ptr kv'hash)
        list:deinitAll(ptr kv'list, ptr pair:free)
    /func
    ```
    The supported control flow blocks are limited to just `if`/`/if` and `while`/`/while`; no fancy stuff. There is although support for a ternary operator with the syntax `condition => expression || expression`.
- Statements and expressions are terminated by _newlines_; it's possibile to write multiple-line statements by escaping a newline with `\` (such as in shell scripting or Python).
- The operator `'` is used to access structure fields, and works pretty much like the operator `.` in Go or Rust, dereferencing a pointer when needed.
- Modules are defined as a collection of files contained in the same directory and marked with a `module <name>` statement. The `:` operator is used to access functions, variables and types belonging to other modules, after importing them with `import`. 
- It is possible to either define stand-alone functions (using `func`) or methods, which can be attached to any arbitrary in-scope named type (including foreign types):

    ```fork
    func strnew(cap uintptr) ptr KVList
        return new(cap, ptr txt:strhash)
    /func

    method KVList.clone() ptr KVList
        mut ret = new(me'hash'buckets'cap, me'hash'hf)

        mut len = me.len()
        mut i uintptr = 0

        while i < len
            mut elem = me.getAt(i)
            ret.put(elem'key, elem'value)

            i++
        /while

        return ret
    /method
    ```

    A method is equivalent to defining a `func` receiving a pointer to an instance of the associated type as its first argument (available in the method body using the `me` keyword), and can be invoked on value or pointer types using the `.` operator (which will automatically reference the type if necessary).

- The entry point of an application is always by an `entry` block contained an anonymous module. Command line arguments are captured by `rt.fork`, and are exposed via `libfork` `proc:args()` function.

- (Almost) all of the usual arithmetic and bitwise operations are supported (including exponentiation, using `**`), respecting the same precedence and behaviour of C. Logical operations are implemented by the `and`,`or` and `not` keywords, while pointer ref/deref are implemented using `ptr` and `val`; casts can be defined using the `<Type>(expr)` syntax.
- The `?` is a unary operator which returns false if the expression at its left is null. The similar binary operator `??` checks its left side expression, returning its right-hand one if null.
- New types can be created using the `alias` keyword, which aliases an existing type (such as an anonymous structure type) to an identifier. Aliased types can then be imported from other modules, or may have methods defined on them.
- Fork supports anonymous structures using `{}`, which can be returned by functions (implementing multiple return values) and assigned to variables; an anonymous struct (`{}` or `struct()`) can be assigned to a named type if structurally compatible. Returned structures are always subjected to _return value optimization (RVO)_
- Only mutable variables are supported, using the keyword `mut`. Types are optional, because they are in general automatically infered by their initialising expressions:

    ```
    mut i uintptr = 0
    mut ret = false
    ```
- Memory is managed manually; no fancy refcounting, GC or borrow-checking is provided.
- Builtin types consist in signed and unsigned integers (no floating point support has ever been implemented), a boolean type, plus pointers (`ptr T`).  
`data` is a type that corresponds to C's `void*`, which is handled as a special case by the compiler; every pointer type can be downcasted to `data` implicitely; upcasting is never automatic, and always requires type casting.

## Implementation

Fork is transpiled to C using `transmod` (see `tools/transmod`), which uses `libforkparse` to parse, verify and translate a module to a C file using `libctrans`.
This operation also creates a `.ford` file containing a binary dump of an AST containing the functions, types and variables declared by a module.  
A `.ford` module must be available to transmod while compiling a module which `import`s it; these are automatically discovered and picked up by transmod using the `FORDPATH` variable.

## Libraries

The parser and AST-to-C translator are respectively implemented by `libforkparse` and `libctrans`.  

`libfork` includes the main runtime for the language (`rt.fork`) and its standard library.
Libfork includes several submodules, which implement fundamental structures and routines, such as:

- `args`: command-line argument parser, like `getopt`, supporting optional arguments and both short/long parameters;
- `dyn`: a wrapper for `dlopen`,`dlsym`, ...
- `fs`: provides support for IO from files, including path handling and browsing directories;
- `hash`: a simple hash map;
- `io`: generic interfaces for IO;
- `kv`: implementation of a "keyvalue list", i.e. an insertion-order preserving map.
- `list`: implementation of a doubly-linked list, using raw pointers;
- `map`: a simple red-black treemap;
- `mem`: a wrapper for `malloc`, `free`, ...
- `proc`: provides functions to access the environment of the current process, including `argv` and `getenv`.
- `rt`: the definition of the compiler runtime for fork, which must be linked into every Fork binary.
- `set`: implementation of an hash set.
- `tty`: wraps C `stdio` to provide functions to write to stdout and stderr.
- `txt`: provides string-related functions, such as string concatenation (using heap) and a tokenizer. This module also provides a rudimental string buffer which is widely used thorough the codebase.
- `vect`: implements a dynamic-expansion vector similar to C++'s `std::vector`, Java `ArrayList` and Rust's `Vec`. Like `list`, this structure only supports `data` pointers and integers.

## Generated C code

Generated C files are generally unreadable; the code is generated for the sake of simplicity in an _"SSA-like"_ form, which can result in very huge binaries if compiled with `-O0`. This is generally not an issue, given that any decent optimizing compiler (i.e. `gcc`, `clang`, `icc`, `cl.exe`, ..) will elide most if not all of the useless stack allocations and assignments in a release build (i.e., with `-O1` or better). The only mandatory requirement for any C compiler to be used with transmod is to support to dollar signs in identifiers (which are used extensively to scope package functions and methods), which is the case for every relevant compiler (except `tcc` and `pcc`). 

Every module is compiled down to a single `.c` file, containing the translated code and the `extern` and `typedef` declaration extracted by every imported `.ford`.  

## Debugging with gdb/lldb

Debugging with `gdb` or `lldb` is supported out of the box; every single line of C generated by `libctrans` is marked using preprocessor `#line` directives, allowing to step inside of the original fork files (instead of following the C gibberish generated by the compiler). Just compile every C source with `-O0`/`-Og` and `-g`.

# How to build `fork`
Use _GNU make_ to bootstrap fork.
You need an already existing binary release of fork with `transmod` to build this (this is a self-hosting compiler, after all), and it should
be in your path (you can otherwise use the TRNS env var to specify which `transmod` the Makefile should use). See `releases` or `tags` on Github/Gitlab to find one for your platform.

`$ make # or gmake on FreeBSD`

The makefile will compile `transmod` three times, using the output of the previous stage as the compiler for the next stage; the finished compiler can be found in `build/stage3`.

If either a prebuilt for your platform is not available, or you are scared of random binaries from the internet (which you definitely should), there should be a `cfiles` tarball (which contains the C output of a previous compilation, plus a Makefile) available, which can be used to compile a barebone `transmod`. This can then be used to bootstrap the full source code on your system:

`$ env TRNS=/path/to/transmod make`

# Usage

The `FORDPATHS` environment variable sets the search paths for _.ford_ files.

_.ford_ files contain a binary representation of the structures defined in already built modules, and are created by `transmod` at compile time.

You can build a fork module (contained into a single directory)
with `transmod`:

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
libforkparse.a and libctrans.a are part of the compiler and are generally not very useful if not hacking on the compiler itself.
