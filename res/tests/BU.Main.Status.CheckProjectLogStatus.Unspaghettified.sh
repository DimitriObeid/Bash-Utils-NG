#!/usr/bin/env bash

function BU.Main.Status.CheckProjectLogStatus()
{
    #**** Parameters ****
    local p_string=${1:-$'\0'};     # ARG TYPE : Any        - REQUIRED | DEFAULT VAL : NULL     - DESC : Text to display.
    local p_option=${2:-$'\0'};     # ARG TYPE : String     - OPTIONAL | DEFAULT VAL : NULL     - DESC : "$(echo)" command's options.
    shift 2;

    local pa_extraArgs=("${@}");    # ARG TYPE : Array      - OPTIONAL | DEFAULT VAL : NULL     - DESC :  More processing arguments (like the processing of a whole line-long string).

    #**** Code ****
    echo "STR : ${p_string}";
    echo "OPT : ${p_option}";
    echo;

    echo "ARR VALS : ${#pa_extraArgs[@]}";
    echo;
    echo;

    for opt in "${pa_extraArgs[@]}"; do
        if [ "${opt,,}" == 'nodate' ]; then
            p_string="$(echo "${p_string}" | sed -E 's/^\[ [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} \] *//')";
        else
            echo "${FUNCNAME[0]}() --> ${FUNCNAME[1]}() : ${opt} is not a supported option" >&2;
        fi
    done

    if [[ "${p_option}" == ?(-)n ]]; then
        echo -ne "${p_string}";
    else
        echo -e "${p_string}";
    fi

    return 0;
}

BU.Main.Status.CheckProjectLogStatus "[ $(date +"%Y-%m-%d %H:%M:%S") ] Hello world !" '-n' 'nodate';
