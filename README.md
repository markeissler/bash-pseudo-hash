# bash-pseudo-hash

[![License](http://img.shields.io/badge/license-MIT-yellowgreen.svg)](#license)

Implements "fake" associative arrays suitable for use with bash versions that
precede 4.0 (with native hash table support) and zsh (as of v1.1.0).

## Build Status

| Service    | bash 4.3 | zsh 5.0.7 | zsh 5.3+ |
|:-----------|:--------:|:---------:|:--------:|
| Jenkins CI | [![Build Status](http://ci.mixtur.com/buildStatus/icon?job=bash-pseudo-hash+%28bash+4%29)]() | [![Build Status](http://ci.mixtur.com/buildStatus/icon?job=bash-pseudo-hash+%28zsh+5%29)]() | [![Build Status](http://ci.mixtur.com/buildStatus/icon?job=bash-pseudo-hash+%28zsh+5.3%2B%29)]() |

## Usage

Copy the script to a reasonable place in your project directory. Then include
the script in your own bash script by sourcing the file:

```sh
script_path="${BASH_SOURCE[0]}"; srcd="${srcd:-${(%):-%x}}"
base_path="$(builtin cd "$(dirname "${script_path}")" && builtin pwd)"
source "${base_path}/lib/bash_pseudo_hash.sh" || return 1
```

The above example places the `bash_pseudo_hash.sh` script in the `lib` directory
of your project.

### `RETVAL` return value convention

Values can be retrieved from __bash-pseudo-hash__ functions in two ways:

- variable assignment from the result of a sub-shell function call
- variable assignment from the `RETVAL` global variable following a function call
  (__recommended__)

All of the __bash-pseudo-hash__ functions will reset a global `RETVAL` variable
upon entry and update that variable before returning. This is similar to the
shell setting the `$?` return status global variable prior to returning from a
function call.

The advantage of leveraging the `RETVAL` global variable is that it avoids the
unnecessary forking of a subshell just so you can assign a return value to a
local variable. In other words: it's way more efficient.

Checking the value of the `RETVAL` global variable must occur immediately after
the associated function call returns as the value cannot be guaranteed to be
correct following another function call -- this behavior is exactly the same as
that for the `$?` return status global variable.

#### Create a hash

The following example creates a hash with two key/val pairs and uses sub-shell
function calls for variable assignment:

```sh
   local hash=()
   local key1="Phrase1"
   local val1="1000 pounds of spaghetti"
   local key2="Phrase2"
   local val2="And a bottle of beer."
   hash=( $(setValueForKeyFakeAssocArray "${key1}" "${val1}" "${hash[*]}") )
   hash=( $(setValueForKeyFakeAssocArray "${key2}" "${val2}" "${hash[*]}") )
```

The same example using `RETVAL` for variable assignment:

```sh
   local hash=()
   local key1="Phrase1"
   local val1="1000 pounds of spaghetti"
   local key2="Phrase2"
   local val2="And a bottle of beer."
   setValueForKeyFakeAssocArray "${key1}" "${val1}" "${hash[*]}" > /dev/null; hash=( ${RETVAL} )
   setValueForKeyFakeAssocArray "${key2}" "${val2}" "${hash[*]}" > /dev/null; hash=( ${RETVAL} )
```

#### Retrieve a value

Building on the previous example, here we retrieve our two values:

```sh
   local val1="$(valueForKeyFakeAssocArray "${key1}" "${hash[*]}")"
   local val2="$(valueForKeyFakeAssocArray "${key2}" "${hash[*]}")"
```

The same example using `RETVAL` for variable assignment:

```sh
   local val1="" val2=""
   valueForKeyFakeAssocArray "${key1}" "${hash[*]}" > /dev/null; val1="${RETVAL}"
   valueForKeyFakeAssocArray "${key1}" "${hash[*]}" > /dev/null; val2="${RETVAL}"
```

## Testing

Tests have been implemented for use with the [bash_unit](https://github.com/pgrange/bash_unit)
framework. To run the tests:

```sh
    prompt> bash_unit tests/*.sh
```

To run a specific test:

```sh
    prompt> bash_unit tests/test_set_keyval.sh
```

## Testing - zsh

Tests for zsh have been implemented for use with the [ZUnit](https://github.com/zunit-zsh/zunit)
framework. To run the tests:

```sh
    prompt> zunit tests/zunit/*.zunit
```

>NOTE: At this time, tests will fail on zsh 5.0 due to variable quoting bugs in
the ZUnit framework itself. Automated tests are currently using the following
forked branch: [markeissler/zunit](https://github.com/markeissler/zunit/tree/moe-fix-unquoted-vars).
A more detailed code review of the ZUnit source needs to be performed.

## Bugs and such

Submit bugs by opening an issue on this project's github page.

## Authors

__bash-pseudo-hash__ is the work of __Mark Eissler__.

## License

__bash-pseudo-hash__ is licensed under the MIT open source license.

---
Without open source, there would be no Internet as we know it today.
