# mips-macro-expander

Given a MIPS assembly file, which uses macros, this script will expand macros (upto a certain "*depth*").

> [!NOTE]
> Currently, the script also strips any and all comments in the source, this may or maynot be the intended behavior

For example,

```sh
$ chmod +x ./macro-expander.py
$ ./macro-expander.py -h
usage: macro-expander.py [-h] [infile]

takes an mips assembly file and finds and expands all macros and writes to stdout
NOTE: does not follow the .include construct and removes comments
NOTE: since a macro can contain other macros, it is only expanded 5 times to avoid infinte loops

positional arguments:
  infile      the filename of the mips file, `-` means stdin (default)

options:
  -h, --help  show this help message and exit
$ ./macro-expander.py ./example/mips-fib-recursive.asm | cat -s > ./example/macro-expanded-fib.asm
```



