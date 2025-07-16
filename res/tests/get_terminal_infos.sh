#!/usr/bin/env bash

which_term()
{
	term="$(ps -p "$(ps -p ${$} -o ppid=)" -o args=)";

	found=0

	for v in '-version' '--version' '-V' '-v'; do
		${term} "${v}" &>/dev/null && eval "${term}" "${v}" && found=1 && break;
	done
}

which_term;
