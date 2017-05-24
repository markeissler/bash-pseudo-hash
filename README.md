# bash-pseudo-hash

[![Build Status](http://ci.mixtur.com/buildStatus/icon?job=bash-pseudo-hash)]()
[![License](http://img.shields.io/badge/license-MIT-yellowgreen.svg)](#license)

Implements "fake" associative arrays suitable for use with bash versions that
precede 4.0 (with native hash table support) and zsh (as of v1.1.0).

## Usage

Copy the script to a reasonable place in your project directory. Then include
the script in your own bash script by sourcing the file:

```sh
script_path="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && /bin/pwd)"
. "${script_path}/lib/bash_pseudo_hash.sh" || return 1
```

#### Create a hash

The following example creates a hash with two key/val pairs:

```sh
   local hash=()
   local key1="Phrase1"
   local val1="1000 pounds of spaghetti"
   local key2="Phrase2"
   local val2="And a bottle of beer."
   hash=( $(setValueForKeyFakeAssocArray "${key1}" "${val1}" "${hash[*]}") )
   hash=( $(setValueForKeyFakeAssocArray "${key2}" "${val2}" "${hash[*]}") )
```

#### Retrieve a value

Building on the previous example, here we retrieve our two values:

```sh
   local val1="$(valueForKeyFakeAssocArray "${key1}" "${hash[*]}")"
   local val2="$(valueForKeyFakeAssocArray "${key2}" "${hash[*]}")"
```

## Dependencies

__bash-pseudo-hash__ relies on `hexdump(1)` to maintain some of the internal
data structures. Some systems (e.g. MacOS) have this tool pre-installed while
others (e.g. Ubuntu) may not.

### Hexdump on CentOS

This package should already be installed on CentOS, but just in case:

```sh
    >sudo yum install util-linux
```

### Hexdump on Ubuntu

```sh
    >sudo apt-get install bsdmainutils
```

## Testing

Tests have been implemented for use with the [bash_unit](https://github.com/pgrange/bash_unit)
framework. To run the tests:

```sh
    >bash_unit tests/test_set_keyval.sh
```

## Bugs and such

Submit bugs by opening an issue on this project's github page.

## Authors

__bash-pseudo-hash__ is the work of __Mark Eissler__.

## License

__bash-pseudo-hash__ is licensed under the MIT open source license.

---
Without open source, there would be no Internet as we know it today.
