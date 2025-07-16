#!/usr/bin/env bash

# shellcheck disable=
function BU.Main.Inputs.Sanitize()
{
    #**** Parameters ****
    local p_string=${1:-Hello}; # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : String to convert in a word array.

    #**** Variables ****
    local v_dangerousChars=';|&|\||`|>|<|$|(|)|{|}';
    local v_dangerousCmds='rm|mv|cp|mkdir|rmdir|ssh|ftp|wget|curl|dd|shred|eval|sh|bash|dash|ksh|zsh|mkfs|unzip|uz|gunzip|7z|unrar';
    local v_specialChars='[^a-zA-Z0-9_\./-]';

    #**** Code ****
    # Checking if the value does not contain dangerous commands.
    if ! echo "${p_string}" | grep -E -q "${v_dangerousChars}"; then
        echo "THE '' ${p_string} '' INPUT CONTAINS DANGEROUS COMMANDS AND THUS CANNOT BE EVALUATED !!!!!" \

        return 1;
    fi

    # Checking if the value does not contain potentially dangerous keywords.
    if echo "${p_string}" | grep -E -q "${v_dangerousCmds}"; then
        echo "THE '' ${p_string} '' INPUT CONTAINS POTENTIALLY DANGEROUS KEYWORDS AND THUS CANNOT BE EVALUATED !!!!!" \

        return 1;
    fi

    # Checking if the value does not contain special characters.
    if echo "${p_string}" | grep -E -q "${v_specialChars}"; then
        echo "THE '' ${p_string} '' INPUT CONTAINS SPECIAL CHARACTERS AND THUS CANNOT BE EVALUATED !!!!!" \

        return 1;
    fi

    return 0;
}

BU.Main.Inputs.Sanitize "${1:-Hello|}";
