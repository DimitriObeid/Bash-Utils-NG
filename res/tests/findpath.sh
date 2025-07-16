#!/usr/bin/env bash

# shellcheck disable=
function BashProfile_FindPath
{
    l="$(find "${1}" -maxdepth 1 -iname "${2}")";
	echo -e "${l}";
}

BashProfile_FindPath "/home/dimob/Projets/Bash-utils" "bin";

ls "${l}";
