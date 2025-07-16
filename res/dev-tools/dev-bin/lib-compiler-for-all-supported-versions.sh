#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : lib-compiler-for-all-supported-versions.sh
# Author(s)     : Dimitri OBEID
# Version       : 1.0

# ----------------------
# SCRIPT'S DESCRIPTION :

# This script calls the "lib-compilerV4.sh" script (which compiles the needed framework ressources and the main module in a single file)
# for every types of needed compiled files : a copy for each supported language, and a copy with every supported languages shipped in.

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

## SUB-CATEGORY NAME

# Feel free to define positional arguments here.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### ARRAY OF ARGUMENTS

## "lib-compilerV3.sh" LIST OF OPTIONAL ARGUMENTS

# ARG TYPE : String
# REQUIRED
# DEFAULT VAL : NULL

# DESC : This array of argument stores the list of the supported optional arguments for the "lib-compilerV4.sh" script, the mandatory ones are already managed by this script.
declare -rg __BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__ARGS__LANG_ARRAY_FOR_THE_COMPILER=( "${@}" );

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

# Absolute path to the "Bash-utils" directory, where the "lib" and the "res" folders are located.
declare -g      __BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR;
                __BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path" || { echo "Unable to get the \"Bash-utils/bin\" folder location" >&2; exit 1; })";
    readonly    __BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR;

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### CATEGORY NAME

## SUB-CATEGORY NAME

# ·············································
# Feel free to define functions here if needed.



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

# Debug
# for args in "${__BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__ARGS__LANG_ARRAY_FOR_THE_COMPILER[@]}"; do echo "${args}"; done

# source "${__BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/bin/lib-compilerV4.sh";

# For a COMPLETELY UNKONWN reason, if the " | tee -a "/dev/null" " redirection is removed, then the script stops after the second compilation, thus the second "$(exec)" command is not called anymore.
exec \
    "${__BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/bin/lib-compilerV4.sh" \
    --lang=supported \
    "${__BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__ARGS__LANG_ARRAY_FOR_THE_COMPILER[@]}" \
    | tee -a "/dev/null" || { exit 1; };

exec \
    "${__BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/bin/lib-compilerV4.sh" \
    --lang-include=supported \
    "${__BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__ARGS__LANG_ARRAY_FOR_THE_COMPILER[@]}" \
    || { exit 1; };

# exec \
#     "${__BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/bin/lib-compilerV4.sh" \
#     --lang-include=supported \
#     --keep-raw-document-layout \
#     "${__BU__BIN__LIB_COMPILER_FOR_ALL_SUPPORTED_VERSIONS__ARGS__LANG_ARRAY_FOR_THE_COMPILER[@]}" \
    || { exit 1; };

exit 0;