#!/usr/bin/env bash
g_path_script="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && /bin/pwd)"
. "${g_path_script}/../bash_pseudo_hash.sh" || return 1

test_should_prettydump() {
  local hash=()
  local testKeys="Phrase1 Phrase2 Phrase3"
  local testKeys_ary=()
  local defaultIFS="$IFS"
  local IFS="$defaultIFS"

  IFS=$' ' testKeys_ary=( ${testKeys} ) IFS="$defaultIFS"

  for key in "${testKeys_ary[@]}"
  do
    local __val="100${key:(-1)} pounds of spaghettiü"
    hash=( $(setValueForKeyFakeAssocArray "${key}" "${__val}" "${hash[*]}") )
  done

  local _key _val
  local _i=1
  while read -r _key _val
  do
    local __expected="[Phrase${_i}]: 100${_i} pounds of spaghettiü"
    assert_equals "${__expected}" "${_key} ${_val}"
    (( _i++ ))
  done <<< "$(prettyDumpFakeAssocArray "${hash[*]}")"
}