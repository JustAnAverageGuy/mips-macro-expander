#!/usr/bin/env python3

import argparse
import re

__doc__ = """
takes an mips assembly file and finds and expands all macros and writes to stdout
NOTE: does not follow the .include construct and removes comments
NOTE: since a macro can contain other macros, it is only expanded 5 times to avoid infinte loops
"""

# TODO: do something to manage comments better, instead of stripping it outright, just ignore it
# while processing (or like add comments back wherever relevant)

# TODO: create chain of dependencies in macros and expand appropriately


def strip_comments(code: str) -> str:
    # note: need to be carefull while stripping comments
    # can't carelessly delete newlines
    return re.sub(r"#.*", "", code)


def replace_in_body(argname: str, body: str, formal_args: str) -> str:
    if formal_args == "":
        return body
    return body.replace(formal_args, argname) # TODO: assert that argname is not empty whenever formal_args is not empty


def main():
    asmcode = args.infile.read()
    args.infile.close()
    asmcode = strip_comments(asmcode)

    MACRO_PATTERN = re.compile(
        r"\.macro\s+(?P<name>\w+)\((?P<argument>.*?)\)(?P<body>.*?)\.end_macro",
        re.DOTALL,
    )

    macros = [
        *re.finditer(
            MACRO_PATTERN,
            asmcode,
        )
    ]

    asmcode = re.sub(MACRO_PATTERN, "", asmcode)

    # TODO: probably add a simple commandline argument which tells number of times to expand
    for _ in range(5):
        for macro in macros:
            name = macro["name"]
            arg  = macro["argument"]
            repl = macro["body"]
            asmcode = re.sub(
                rf"{name}\((?P<actualargs>.*?)\)",
                lambda matc: replace_in_body(matc["actualargs"], repl, arg),
                asmcode,
            )
    print(asmcode)


if __name__ == "__main__":  # {{{
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter,
        description=__doc__,
    )
    parser.add_argument(
        "infile",
        nargs="?",
        type=argparse.FileType("r"),
        default="-",
        help="the filename of the mips file, `%(default)s` means stdin (default)",
    )
    args = parser.parse_args()
    main()  # }}}

# vim: fdm=marker
