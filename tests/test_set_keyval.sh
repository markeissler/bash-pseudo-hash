#!/usr/bin/env bash
g_path_script="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && /bin/pwd)"
. "${g_path_script}/../bash_pseudo_hash.sh" || return 1

test_should_set_keyval() {
  local hash=()
  local key1="Phrase1"
  local val1="1000 pounds of spaghettiü"
  hash=( $(setValueForKeyFakeAssocArray "${key1}" "${val1}" "${hash[*]}" ) )
  assert_equals "Phrase1:1000%20pounds%20of%20spaghetti%c3%bc" "${hash[0]}"
}

test_should_set_keyval_RETVAL() {
  local hash=()
  local key1="Phrase1"
  local val1="1000 pounds of spaghettiü"
  setValueForKeyFakeAssocArray "${key1}" "${val1}" "${hash[*]}" > /dev/null
  hash=( ${RETVAL} )
  assert_equals "Phrase1:1000%20pounds%20of%20spaghetti%c3%bc" "${hash[0]}"
}

test_should_get_keyval() {
  local hash=( "Phrase2:And%20a%20bottle%20of%20beer." )
  local key="Phrase2"
  local val="$(valueForKeyFakeAssocArray "${key}" "${hash[*]}")"
  assert_equals "And a bottle of beer." "${val}"
}

test_should_get_keyval_RETVAL() {
  local hash=( "Phrase2:And%20a%20bottle%20of%20beer." )
  local key="Phrase2"
  local val=""; valueForKeyFakeAssocArray "${key}" "${hash[*]}" > /dev/null; val="${RETVAL}"
  assert_equals "And a bottle of beer." "${val}"
}

test_should_get_keyval_error() {
  local hash=( "Phrase2:And%20a%20bottle%20of%20beer." )
  local key="Phrase2x"
  assert_fail "valueForKeyFakeAssocArray ${key} ${hash[*]}"
}
