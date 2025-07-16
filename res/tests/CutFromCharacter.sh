#!/usr/bin/env bash

#**** Parameters ****
p_target=${1:-$'\0'};         # string to process
#   ${2}  --> delimiter
p_iterations=${3:-$'\0'};     # iterations

#**** Code ****
if [ "${p_iterations}" -eq 0 ]; then
    p_iterations='1';
fi

for ((i=0; i<p_iterations; i++)); do
    # shellcheck disable=SC200
    p_target="$(sed "s/^[^${2}]*${2}//" <<< "${p_target}")";

    echo "${p_target}";
done
