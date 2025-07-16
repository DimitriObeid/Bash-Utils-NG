#!/bin/bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : bin-generation.sh
# Author(s)     : Dimitri OBEID
# Version       : 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# This script generates a library file with the framework's executable script's design.

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

## ARGUMENTS DEFINITION

# ARG TYPE : filepath
# REQUIRED
# DEFAULT VAL : NULL

# DESC : Path to the script file to create (mandatory).
declare -gr __BU__BIN__BIN_GENERATION__ARGS__PATH=${1:-$'\0'};

# ARG TYPE : filepath
# OPTIONAL
# DEFAULT VAL : NULL

 # DESC : Path to the resources file (optional).
declare -gr __BU__BIN__BIN_GENERATION__ARGS__SRC=${2:-$'\0'};

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### ARRAY OF ARGUMENTS

## EXECUTABLE FILES GENERATOR ARRAY OF ARGUMENTS

# Feel free to define an array of arguments here if needed.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################## PROJECT'S GLOBAL VARIABLES DEFINITIONS #######################################

#### ARRAYS DEFINITIONS

##

# Feel free to define arrays here if needed.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### VARIABLES DEFINITIONS

## MESSAGES

__BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING="Terminating the ${0} script execution";

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### FUNCTIONS DEFINITION

##

# ·············································
# Feel free to define functions here if needed.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

if [ -z "${__BU__BIN__BIN_GENERATION__ARGS__PATH}" ]; then
    echo "WARNING !! NO FILE PATH WAS GIVEN FOR THE ${0} SCRIPT" >&2;
    echo "Please provide a valid file path to create" >&2;
    echo >&2;

    echo "${__BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING}" >&2;
    echo >&2;

    exit 1;

elif [ -f "${__BU__BIN__BIN_GENERATION__ARGS__PATH}" ]; then
    echo "WARNING !! THE ${__BU__BIN__BIN_GENERATION__ARGS__PATH} FILE ALREADY EXISTS !!!" >&2; echo >&2;
    echo "The file will not be overwritten" >&2;
    echo >&2;

    echo "${__BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING}" >&2;
    echo >&2;

    exit 1;
fi

if [ ! -f "../dev-res/bin-generation.sh.txt" ] || [ ! -f "${__BU__BIN__BIN_GENERATION__ARGS__SRC}" ]; then
    if [ -f "${HOME}/.Bash-utils/Bash-utils-root-val.path" ]; then
        __new_file_path_tmp="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path")";

        __new_file_path="${__new_file_path_tmp}/res/dev-tools/dev-res/bin-generation/bin-generation.sh.txt";
    else
        echo "WARNING !! UNABLE TO FIND THE PATH TO THE '${HOME}/.Bash-utils/Bash-utils-root-val.path' RESOURCES FILE" >&2;
        echo "Please provide the path to the resource file" >&2;
        echo >&2;

        echo "${__BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING}" >&2;
        echo >&2;

        exit 1;
    fi
else
    __new_file_path='../dev-res/bin-generation/bin-generation.sh.txt';
fi

touch "${__BU__BIN__BIN_GENERATION__ARGS__PATH}" || {
    echo "WARNING !! THE ${0} SCRIPT WAS UNABLE TO CREATE THE ${__BU__BIN__BIN_GENERATION__ARGS__PATH} FILE" >&2;
    echo "Please check the permissions of the target directory" >&2;
    echo >&2;

    echo "${__BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING}" >&2;
    echo >&2;

    exit 1;
}

cat "${__new_file_path}" > "${__BU__BIN__BIN_GENERATION__ARGS__PATH}" || {
    echo "WARNING !! THE ${0} SCRIPT WAS UNABLE TO WRITE INTO THE ${__BU__BIN__BIN_GENERATION__ARGS__PATH} FILE" >&2;
    echo "Please check the permissions of the target file or directory" >&2;
    echo >&2;

    echo "${__BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING}" >&2;
    echo >&2;

    exit 1;
};

echo "The ${__BU__BIN__BIN_GENERATION__ARGS__PATH} FILE WAS SUCCESSFULLY CREATED";
echo;

exit 0;
