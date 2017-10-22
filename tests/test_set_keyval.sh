#!/usr/bin/env bash
g_path_script="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && /bin/pwd)"
. "${g_path_script}/../bash_pseudo_hash.sh" || return 1

test_should_set_keyval() {
    local hash=()
    local key1="Phrase1"
    local val1="1000 pounds of spaghettiü"
    hash=( $(setValueForKeyFakeAssocArray "${key1}" "${val1}" "${hash[*]}" ) )
    assert_equals "Phrase1:1000%20pounds%20of%20spaghetti%C3%BC" "${hash[0]}"
}

test_should_set_keyval_empty() {
    local hash=()
    local key1="Empty"
    local val1=""
    hash=( $(setValueForKeyFakeAssocArray "${key1}" "${val1}" "${hash[*]}" ) )
    assert_equals "Empty:%40%40" "${hash[0]}"
}

test_should_set_keyval_RETVAL() {
    local hash=()
    local key1="Phrase1"
    local val1="1000 pounds of spaghettiü"
    {
        setValueForKeyFakeAssocArray "${key1}" "${val1}" "${hash[*]}" > /dev/null
        hash=( ${RETVAL} )
    }
    assert_equals "Phrase1:1000%20pounds%20of%20spaghetti%C3%BC" "${hash[0]}"
}

test_should_set_keyval_empty_RETVAL() {
    local hash=()
    local key1="Empty"
    local val1=""
    {
        setValueForKeyFakeAssocArray "${key1}" "${val1}" "${hash[*]}" > /dev/null
        hash=( ${RETVAL} )
    }
    assert_equals "Empty:%40%40" "${hash[0]}"
}

test_should_get_keyval() {
    local hash=( "Phrase2:And%20a%20bottle%20of%20beer." )
    local key="Phrase2"
    local val="$(valueForKeyFakeAssocArray "${key}" "${hash[*]}")"
    assert_equals "And a bottle of beer." "${val}"
}

test_should_get_keyval_status() {
    local hash=( "Phrase2:And%20a%20bottle%20of%20beer." )
    local key="Phrase2"
    assert_status_code 0 "valueForKeyFakeAssocArray ${key} ${hash[*]}"
}

test_should_get_keyval_empty() {
    local hash=( "Empty:%40%40" )
    local key="Empty"
    local val="$(valueForKeyFakeAssocArray "${key}" "${hash[*]}")"
    assert_equals ""
}

test_should_get_keyval_empty_status() {
    local hash=( "Empty:%40%40" )
    local key="Empty"
    assert_status_code 1 "valueForKeyFakeAssocArray ${key} ${hash[*]}"
}

test_should_get_keyval_RETVAL() {
    local hash=( "Phrase2:And%20a%20bottle%20of%20beer." )
    local key="Phrase2"
    local val=""
    {
        valueForKeyFakeAssocArray "${key}" "${hash[*]}" > /dev/null
        val="${RETVAL}"
    }
    assert_equals "And a bottle of beer." "${val}"
}

test_should_get_keyval_empty_RETVAL() {
    local hash=( "Empty:%40%40" )
    local key="Empty"
    local val=""
    {
        valueForKeyFakeAssocArray "${key}" "${hash[*]}" > /dev/null
        val="${RETVAL}"
    }
    assert_equals ""
}

test_should_get_keyval_error() {
    local hash=( "Phrase2:And%20a%20bottle%20of%20beer." )
    local key="Phrase2x"
    assert_fail "valueForKeyFakeAssocArray ${key} ${hash[*]}"
}

test_should_get_keyval_error_status() {
    local hash=( "Phrase2:And%20a%20bottle%20of%20beer." )
    local key="Phrase2x"
    assert_status_code 2 "valueForKeyFakeAssocArray ${key} ${hash[*]}"
}
