#!/usr/bin/env bash

if [ "$(basename "${BASH_SOURCE[0]}")" == "tst.sh" ]; then echo TRUE; __var="$(basename "${BASH_SOURCE[0]}")"; else echo FALSE; fi; echo "";

_v_nb="$(wc -l "${__var}" | cut -f1 -d" ")"; echo "${_v_nb}";

if [ "${_v_nb}" -eq 6 ]; then echo TRUE; else echo FALSE; fi;

