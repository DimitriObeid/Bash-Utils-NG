#!/usr/bin/env bash

# shellcheck disable=
function BU.Main.Text.CutLastCharacter()
{
    #**** Parameters ****
    local p_string=${1:-$'\0'};     # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : String to process.

    #**** Variables ****
    declare -i v_length;        # VAR TYPE : Int        - DESC : Storing the length of the character.

    #**** Code ****
    # Getting the number of characters from this string.
    v_length="${#p_string}";

    # Printing the wanted character.
    shopt -s extglob;

    echo "${p_string%%+("${p_string:$(( v_length - 1 ))}")}";

    shopt -u extglob;

    return 0;
}

BU.Main.Text.CutLastCharacter "${1:-String}";
