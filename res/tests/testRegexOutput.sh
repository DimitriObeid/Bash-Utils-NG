#!/usr/bin/env bash

declare -i index=0;

while read -r line; do
    array[index++]=$(echo "${line}" | grep -o  's?(ub)?(-)?(c?(at?(eg?(orie))))s');
done
