#!/usr/bin/env bash

echo "Fichier : ${0}"; echo;

# shellcheck disable=
function x() { echo "Fichier fnct : ${0}"; }; x; echo;

# shellcheck disable=
function y() { local str="Hello"; echo "${str: -2}"; }; y; echo;

# shellcheck disable=
function z() { local v_name="${0}"; local v_str="${v_name: -3}"; echo "VARIABLE : ${v_str}"; echo; if [[ "${v_str^^}" == .SH ]]; then echo TRUE; else echo FALSE; fi; }; z;
