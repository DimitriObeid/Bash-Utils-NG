#!/usr/bin/env bash

# ················································································································
# Rewriting the "ReverseStringWordsOrder.sh" file's content in order to write the new string in the correct order.

# shellcheck disable=
function ReverseStringOrder()
{
	local string=${1:-$'\0'};
	local delim=${2:-$'\0'};

	local reversed="";

	IFS="${delim}" read -ra line <<< "${string}";

	let x=${#line[@]}-1;

	while [ "${x}" -ge 0 ]; do
        	if [ "${x}" -gt 0 ]; then
                	reversed="${reversed}${line[x]}${delim}";
        	else
            		reversed="${reversed}${line[x]}";
        	fi

      		let x--;
	done

	echo "${reversed}";
}

# shellcheck disable=
function CutSubStringBeforeNthDelim()
{
        string=${1:-$'\0'};
        delim=${2:-$'\0'};

        remainder="${string}";
        newstr="";

        for ((i=0; i<3; i++)); do
                first="${remainder##*${delim}}";
                remainder="${remainder%${delim}*}";

                if [ -z "${newstr}" ]; then
                        newstr="${first}"
                else
                        newstr="${newstr}${delim}${first}";
                fi
        done

	newstr="$(ReverseStringOrder "${newstr}" "${delim}")";
}

CutSubStringBeforeNthDelim "one_two_three_four_five" "_";

echo "Rem : ${remainder}";
echo "New : ${newstr}";
