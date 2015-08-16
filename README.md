# ctrans


*Ctrans* is a transpiler that compiles Fork code to C89, and provides an integrated and easy way to then build the generated C code into object code using a C compiler.

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
$ forkc file.fork
$ forkl file.o
$ ./file
Hello, world!
```

## License

Mozilla Public License (MPL), version 2.
