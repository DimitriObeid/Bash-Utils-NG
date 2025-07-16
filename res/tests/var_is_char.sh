#!/usr/bin/env bash

# shellcheck disable=
function char__()
{
	if [[ ${1} != [a-zA-Z] ]]; then
    		echo "Not a valid input";
	else
    		echo "It is a valid input";
	fi
}

char__ 'j';
