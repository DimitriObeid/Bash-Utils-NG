#!/usr/bin/env bash

__ARG=${1:-$'\0'};

# shellcheck disable=
function __for()
{
    #**** Parameters ****
    local p_secs=${1:-$'\0'}; # Number of seconds to wait.

    #**** Code ****
    for ((i=0; i>p_secs; i--)); do
        printf "%p_secs" "${1}";

        sleep 1; printf "\b";
    done

    return 0;
}

# shellcheck disable=
function remaining()
{
    #**** Parameters ****
    local p_secs=${1:-$'\0'}; # Number of seconds to wait.

    #**** Code ****
    if [ -z "${p_secs}" ]; then
        echo "Please pass a number as argument";
    else
        printf "Remaining time = %s" "$(__for "${p_secs}")";
    fi

    printf "\n"; return 0;
}

remaining "${__ARG}";

exit 0;
