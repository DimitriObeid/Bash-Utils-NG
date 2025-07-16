#!/usr/bin/env bash

# Optimizing the code with a function
function SetMainLang
{
    #**** Parameters ****
    local parent_dir=${1:-$'\0'};
    local file=${2:-$'\0'};
    local error_msg=${3:-$'\0'};
    local success_msg=${4:-$'\0'};
    local lineno=${5:-$'\0'};

    #**** Code ****
    # Don't double quote what follows the path variable, or else, the loop will only run once.
    BU.EchoInit "In ${BASH_SOURCE[0]}, line ${lineno}"; for f in ${parent_dir}/${file}; do
        if source "${f}"; then
            BU.EchoInit "${success_msg} : ${f}";
        else
            echo -e "${f} : ${error_msg}" 2>&1 | tee -a "${INITIALIZER_LOG_PATH}"; echo;

            exit 1;
        fi
    done; BU.EchoInit
}

# Detecting user's language with the "${LANG}" environment variable.
case "${LANG}" in
    en_*)
        # English
        SetMainLang "${LINUX_REINSTALL_LANG}/en" "*.en" "Unable to source this translation file" "Included translation file" "${LINENO}";
        ;;
    fr_*)
        # French
        SetMainLang "${LINUX_REINSTALL_LANG}/fr" "*.fr" "Impossible de sourcer ce fichier de traduction" "Fichier de traduction sourcé" "${LINENO}";
        ;;
    *)
        # Else, if the detected language is not yet supported, the default language will be English.
        # As it's an important information, the "echo" command's output has to be redirected to the terminal too, no matter if
        echo -e "YOUR CURRENT LANGUAGE IS NOT YET SUPPORTED !!" 2>&1 | tee -a "${INITIALIZER_LOG_PATH}";
        echo -e "The $(basename "${0}" | cut -f 1 -d '.') library language will be set in English" 2>&1 | tee -a "";

        SetLibLang "${BASH_UTILS_LANG}/en" "*.en" "Unable to source this translation file" "Sourced translation file" "${LINENO}";
        ;;
esac
