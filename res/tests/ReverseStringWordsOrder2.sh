#!/bin/bash

# shellcheck disable=
function BU.Main.Text.ReverseStringWordsOrder()
{
    #**** Parameters ****
    local p_string=${1:-$'\0'}; # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : String to process.
    local p_delim=${2:-$'\0'};  # ARG TYPE : Char       - REQUIRED | DEFAULT VAL : NULL     - DESC : Targeted character.
    local p_keepd=${3:-$'\0'};  # ARG TYPE : String     - OPTIONAL | DEFAULT VAL : NULL     - DESC : Keep or remove first or last delimiters, or both together, if they are the first and / or the last character of the string.

	#**** Variables ****
	# Leave this variable empty, it will store the reversed string.
	local reversed="";

    #**** Code ****
    #
	IFS="${p_delim}" read -ra line <<< "${p_string}";

	# shellcheck disable=SC2219
	let x="${#line[@]}-1";

	while [ "${x}" -ge 0 ]; do
		if [ "${x}" -gt 1 ]; then reversed="${reversed}${line[x]}${p_delim}"; else reversed="${reversed}${line[x]}"; fi

		(( x-- ));
	done

	if     [[ "${p_keepd,,}" == k?(eep)?([[:space:]])?(-?(-))f?(irst) ]];              then reversed="${p_delim}${reversed}";
	elif   [[ "${p_keepd,,}" == k?(eep)?([[:space:]])?(-?(-))l?(ast) ]];               then reversed="${reversed}${p_delim}";
	elif   [[ "${p_keepd,,}" == k?(eep)?([[:space:]])?(-?(-))f?(irst)?(-)l?(ast) ]];   then reversed="${p_delim}${reversed}${p_delim}"; fi

	echo -e "${reversed}";
}

BU.Main.Text.ReverseStringWordsOrder ".arg1.arg2.arg3.arg4." '.' 'keep --l';
