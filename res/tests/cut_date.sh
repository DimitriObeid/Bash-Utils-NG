#!/usr/bin/env bash

A_TEST=("[ 23-07-2021 - 12h42-16 ] test1" "[ 23-07-2021 - 12h42-16 ] test2" "[ 23-07-2021 - 12h42-16 ] test3" "[ 23-07-2021 - 12h42-16 ] test4");

for val in "${A_TEST[@]}"; do
	v_cutstr="${val##*] }";
	echo -e "${v_cutstr}";
done
