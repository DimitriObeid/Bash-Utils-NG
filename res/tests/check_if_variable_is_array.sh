#!/usr/bin/env bash

# shellcheck disable=
function check_if_variable_is_array()
{
    if declare -p "$1" 2>/dev/null | grep -q 'declare -a'; then
        echo "Array"
    else
        echo "Not an array"
    fi
}

check_if_variable_is_array "$1"
