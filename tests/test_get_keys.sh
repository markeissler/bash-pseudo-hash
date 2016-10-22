#!/usr/bin/env bash
g_path_script="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && /bin/pwd)"
. "${g_path_script}/../bash_pseudo_hash.sh" || return 1

test_should_gets_keys() {
  local hash=()
  local testKeys="Phrase1 Phrase2 Phrase3"
  local testKeys_ary=()
  local expectedKeys="${testKeys}"
  local defaultIFS="$IFS"
  local IFS="$defaultIFS"

  IFS=$' ' testKeys_ary=( ${testKeys} ) IFS="$defaultIFS"

  for key in "${testKeys_ary[@]}"
  do
    local __val="100${key:(-1)} pounds of spaghettiü"
    hash=( $(setValueForKeyFakeAssocArray "${key}" "${__val}" "${hash[*]}") )
  done

  local returnedKeys="$(keysForFakeAssocArray "${hash[*]}")"
  assert_equals "${expectedKeys}" "${returnedKeys}"
}
