#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : latex-unite.sh
# Author(s)     : Dimitri OBEID
# Version       : Beta 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# This script unites every LaTeX source files (each files ending with the ".tex" extension) in a single file,
# in order to get the total size of the documentation in bytes, number of characters, of words, of columns and lines.

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### SOURCING PROJECT'S DEPENDENCIES ###########################################

#### BASH DEPENDENCIES

## BASH UTILS

# Feel free to source any dependencies here if needed.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

############################################# GLOBAL RESOURCES DEFINITION #############################################

########################################### PROJECT'S ARGUMENTS DEFINITIONS ###########################################

#### POSITIONAL ARGUMENTS

##

# Feel free to define positional arguments here.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### ARRAY OF ARGUMENTS

## ARGUMENTS DEFINITION

# ARG TYPE : Array
# REQUIRED
# DEFAULT VAL : NULL

# DESC : Languages processing with argument
__BU_ARGS=("${@}");

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################## PROJECT'S GLOBAL VARIABLES DEFINITIONS #######################################

#### ARRAYS DEFINITIONS

## SUB-CATEGORY NAME

# Feel free to define arrays here if needed.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### VARIABLES DEFINITIONS

## PATHS

declare -g      __BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR;
                __BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path")";
    readonly    __BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR;

declare -gr __BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__FULL_LATEX_FILE="${__BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/Bash-utils.tex";

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### FUNCTIONS DEFINITION

##

# ···························································
# Printing a line according to the terminal's columns number.

# shellcheck disable=
function PrintLine()
{
    __cols="$(tput cols)";

        for _ in $(eval echo -e "{1..${__cols}}"); do
            printf '-';
    done; printf "\n";
}

# function BU.Main.Echo.Newline { local iterations="${1}"; for ((i=0; i<iterations; i++)); do echo -e "" | tee -a "${__BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__FULL_LATEX_FILE}"; done; }
function CatBU { cat "${1}" | tee -a "${__BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__FULL_LATEX_FILE}" || { echo "UNABLE TO DISPLAY THE ${1} FILE'S CONTENT ! Please check its path and if it exists."; exit 1; }; }
function EchoBU { echo -e "# ${1}" | tee -a "${__BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__FULL_LATEX_FILE}" || { echo "UNABLE TO WRITE THE ${1} FILE'S CONTENT ! Please check its path and if it exists."; exit 1; }; }


if [ ! -f "${__BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__FULL_LATEX_FILE}" ]; then
        touch "${__BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__FULL_LATEX_FILE}";
fi

if [ -s "${__BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__FULL_LATEX_FILE}" ]; then
        true > "${__BU__BIN__LATEX_UNITE__GLOBVARS__PATHS__FULL_LATEX_FILE}";
fi

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

####

##

# ·····································
# Processing the English documentation.

exit 0;