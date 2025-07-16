#!/usr/bin/env bash

string="arg1.arg2.arg3.arg4";
delim=".";

reversed="";

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
