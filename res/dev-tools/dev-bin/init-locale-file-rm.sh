#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : init-locale-file-rm.sh
# Author(s)     : Dimitri OBEID
# Version       : 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# This script deletes one or more locale file(s) used for the modules initialization process script.

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

## ARRAY OF FILES TO CREATE

# List of ISO 639-1 codes.
__BU__BIN__INIT_LOCALE_FILE_RM__ARGS__ARG_LIST=( "$@" );

# Checking if a value was passed as argument in the ISO 639-1 codes list when this script was executed.
if (( ${#__BU__BIN__INIT_LOCALE_FILE_RM__ARGS__ARG_LIST[@]} == 0 )); then
	echo "This script takes at least one mandatory argument : the name(s) of the old locale file(s) to delete from the hard drive"; exit 1;
fi

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

## PATHS

# Bash Utils library root path from this script's path.
declare -g      __BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR;
                __BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path")";
    readonly    __BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR;

# Path to the directory which stores the initalizer script's locale files.
declare -gr __BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__MAKE_INIT_LOCALE_DIR_PATH="${__BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/install/.Bash-utils/config/initializer/locale";

# Path to the locale file to delete.
declare -g __BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__MAKE_INIT_LOCALE_FILE_PATH;

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### FUNCTIONS DEFINITION

##

# ·············································
# Feel free to define functions here if needed.



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

for locale_file in "${__BU__BIN__INIT_LOCALE_FILE_RM__ARGS__ARG_LIST[@]}"; do
    __BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__MAKE_INIT_LOCALE_FILE_PATH="${__BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__MAKE_INIT_LOCALE_DIR_PATH}/${locale_file}.locale";

    printf "Deleting the %s file... " "${__BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__MAKE_INIT_LOCALE_FILE_PATH}";

    rm "${__BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__MAKE_INIT_LOCALE_FILE_PATH}" || {
        printf "Failed %s❌%s\n\n" "$(tput setaf 9)" "$(tput sgr0)" >&2;

        echo "ERROR : FAILED TO DELETE THE ${__BU__BIN__INIT_LOCALE_FILE_RM__GLOBVARS__PATHS__MAKE_INIT_LOCALE_FILE_PATH} FILE" >&2;
        echo >&2;

        echo "" >&2;
        echo >&2;

        exit 1;
    }

    printf "Success %s✓%s\n" "$(tput setaf 2)" "$(tput sgr0)";
done

exit 0;