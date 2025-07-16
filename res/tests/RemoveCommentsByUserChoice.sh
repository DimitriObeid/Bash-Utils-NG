#!/bin/bash

# Please copy and execute this file in the root directory of the Bash Utils framework.

cp Bash-utils.sh Bash-utils.sh.txt;

# Demander à l'utilisateur quels critères de commentaires garder
read -p "Garder les commentaires avec 'shellcheck disable=' après le premier '#' ? (y/n) " keep_shellcheck;
read -p "Garder les blocs de commentaires contenant une ligne de '·' jusqu'à la première 'function' ? (y/n) " keep_block;
read -p "Garder les commentaires contenant '**** Parameters', '**** Variables' ou '**** Code' ? (y/n) " keep_special;

if [ "${keep_shellcheck,,}" == 'y' ]; then _____shellcheck="/^#[[:space:]]*shellcheck disable=/d"; fi

if [ "${keep_block,,}" == 'y' ]; then _____block="/^#[[:space:]]*-\{1,\}[[:space:]]*#.*function/!d"; fi

if [ "${keep_special,,}" == 'y' ]; then _____special="/^#[[:space:]]*$(printf '%s\n' "Parameters" "Variables" "Code" | paste -sd '|')/d"; fi

sed -e "${_____shellcheck}" \
    -e "${_____block}" \
    -e "${_____special}" \
    -e '/^#[[:space:]]*-\{0,\}$/d' \
    "Bash-utils.sh" > "Bash-utils-modified.sh";