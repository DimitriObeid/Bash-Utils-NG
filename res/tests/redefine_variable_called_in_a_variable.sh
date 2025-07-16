#!/usr/bin/env bash

__TEST="CECI EST UN TEST DE LA FONCTION ${FUNCTION}";

# shellcheck disable=
function __test()
{
	echo "${__TEST}";

	echo "${FUNCNAME[0]}";

	local FUNCTION="${FUNCNAME[0]}";
	echo "${__TEST}";
}

__test;
