#!/usr/bin/env bash
g_path_script="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && /bin/pwd)"
. "${g_path_script}/../bash_pseudo_hash.sh" || return 1

test_should_get_version() {
  local val="$(__bph_version)"
  assert "[[ ${val} =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]"
}
