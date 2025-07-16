#!/usr/bin/env bash

__ARG_STR=${1:-c};

__ARG_NB=${2:-5};

# shellcheck disable=
function PrintCharXTimes()
{
	#**** Parameters ****
	local p_str=${1:-$'\0'};
	local p_nb=${2:-$'\0'};

	#**** Variables ****
	local i;

	#**** Code ****
	for((i=0; i<p_nb; i++)); do
		printf "%s" "${p_str}";
	done

	echo;

	return 0;
}

PrintCharXTimes "${__ARG_STR}" "${__ARG_NB}";