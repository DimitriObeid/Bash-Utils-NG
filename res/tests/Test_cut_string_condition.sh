#!/usr/bin/env bash

source "${HOME}/Projets/Bash-utils/lib/functions/main/Text.lib" || { echo "Fail source"; exit 1; }

# shellcheck disable=
function test_condition()
{
	if [ "${1}" == "$(BU.Main.Text.CutDashFromOption "${1}")" ]; then
		echo "${1}";
	else
		echo "Fail : ${1}";
	fi
}

test_condition "-n";
