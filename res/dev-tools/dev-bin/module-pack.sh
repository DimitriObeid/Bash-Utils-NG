#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : module-pack.sh
# Author(s)     : Dimitri OBEID
# Version       : 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# Packing the targeted module's files into a folder (and then optionnaly into a compressed file), which can be downloaded and installed by another user.

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

## ARRAY OF MODULES TO PACK

# List of modules to pack.
declare -agr __BU__BIN__MODULE_PACK__ARGS__ARG_LIST=( "${@}" );

# Checking if the module's name was passed as argument when this script was executed.
if (( ${#__BU__BIN__MODULE_PACK__ARGS__ARG_LIST[@]} == 0 )); then
	echo "This script takes at least one mandatory argument : the name of the existing module(s) to pack separately"; exit 1;
fi

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

# Bash Utils library root path from this script's path.
declare -g      __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR
                __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path")";
    readonly    __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR;

# Path to the
declare -g __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_CONF_PATH;

# Path to the
declare -g __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_INIT_PATH;

# Path to the
declare -g __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_MANIFS_PATH;

# Path to the
declare -g __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_FUNCTS_PATH;

# Default output directory for each module's root folder (default value : "${HOME}/.Bash-utils/module_pack_sh_output").
__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__DEFAULT_OUTPUT_DIR="${HOME}/.Bash-utils/module_pack_sh_output";

## ==============================================

## ARCHIVE FORMAT

# Default archive format for storing each module's root folder (default value : zip | supported : 7z, rar (WSL ONLY !!!)).
__BU__BIN__MODULE_PACK__GLOBVARS__STRING__DEFAULT_COMPRESSION_FORMAT='zip';

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

if [ ! -d "${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__DEFAULT_OUTPUT_DIR}" ]; then
	mkdir -pv "${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__DEFAULT_OUTPUT_DIR}" || exit 1;
fi

for module_name in "${__BU__BIN__MODULE_PACK__ARGS__ARG_LIST[@]}"; do

    __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_CONF_PATH="${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/install/.Bash-utils/config/modules/${module_name}";

    __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_INIT_PATH="${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/install/.Bash-utils/modules/${module_name}";

    __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_MANIFS_PATH="${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/install/.Bash-utils/manifests/";

    __BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_FUNCTS_PATH="${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/lib/functions/${module_name}";

    if [ ! -d "${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/install" ] || [ ! -d "${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/lib" ]; then
        echo "You must run this script from its directory" >&2;
        echo >&2;

        echo "Terminating module creation" >&2;

        exit 1;
    fi

    # Checking if the whole module exists.
    if [ ! -d "${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_CONF_PATH}" ] || [ ! -d "${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_INIT_PATH}" ] || [ ! -d "${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_FUNCTS_PATH}" ]; then
	    echo "ERROR : At least one of the following ${module_name} module's directories are missing :" >&2;
	    echo "    -${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_CONF_PATH}" >&2;
	    echo "    -${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_INIT_PATH}" >&2;
	    echo "    -${__BU__BIN__MODULE_PACK__GLOBVARS__PATHS__PACK_MODULE_FUNCTS_PATH}" >&2;
	    echo >&2;

	    echo "Please check the existence of these directories" >&2;
	    echo >&2;

        exit 1;
    fi
done

# Printing that the targeted modules were successfully packed from the Bash Utils framework's data folders.
if [ "${#__BU__BIN__MODULE_PACK__ARGS__ARG_LIST[@]}" -lt 2 ]; then
    echo "The ${__BU__BIN__MODULE_PACK__ARGS__ARG_LIST[0]} module was successfully packed";
else
    echo "The following modules were successfully packed :";

    for module in "${__BU__BIN__MODULE_PACK__ARGS__ARG_LIST[@]}"; do
        echo "    - ${module}";
    done
fi

echo;

exit 0;
