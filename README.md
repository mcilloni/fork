# libctrans


*libctrans* is a library that implements a transpiler for compiling Fork code to C99.

This is largely a WIP project, and it's pretty far away from release, so expect lots of bugs.

Contributions are always accepted.

## Example

```
import tty

entry
  tty:outln("Hello, world!")
/entry
```

## Usage

```
$ env FORDPATHS=$MY_FORDS transmod -n helloworld hello_world_dir
$ cc -w -o helloworld helloworld.c $PATH_TO_LIBFORK/rt.o $PATH_TO_LIBFORK/libfork.a
$ ./helloworld
Hello, world!
```

## License

Mozilla Public License (MPL), version 2.
