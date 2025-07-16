#!/usr/bin/env bash

# shellcheck disable=
function funcname1
{
	echo -e "${1}";
}

# shellcheck disable=
function funcname0
{
	echo -e "${FUNCNAME[0]}";
	funcname1 "${FUNCNAME[1]}";
}

funcname0;
