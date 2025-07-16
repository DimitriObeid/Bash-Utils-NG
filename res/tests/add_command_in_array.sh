#!/usr/bin/env bash

ARRAY___=()
ARRAY___+=("$(echo -ne "test -ne")")
ARRAY___+=("$(echo -e "test -e")")
for val in ${ARRAY___[@]}; do echo val; fi
