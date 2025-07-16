#!/usr/bin/env bash

# shellcheck disable=
function char__()
{
	if [ "${#1}" -lt 2 ]; then
	    	echo "Not a string";
	else
		if [[ "${1}" == [^a-zA-Z\ ] ]]; then
			echo "Not a valid input";
		else
    		echo "It is a valid input";
		fi
	fi
}

char__ "${1}";
