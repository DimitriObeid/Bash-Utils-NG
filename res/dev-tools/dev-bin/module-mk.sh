#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : module-mk.sh
# Author(s)     : Dimitri OBEID
# Version       : Beta 1.0


# -----------------
# FILE DESCRIPTION :

# This script creates the bases of each new module you want to create :
#   - their configuration directory,
#   - their initialization directory,
#   - Their library directory

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

## ARRAY OF MODULES TO CREATE

# List of modules to create.
declare -agr __BU__BIN__MODULE_MK__ARGS__ARG_LIST=( "${@}" );

# Checking if any module's name was passed as argument when this script was executed.
if (( ${#__BU__BIN__MODULE_MK__ARGS__ARG_LIST[@]} == 0 )); then
	echo "This script takes at least one mandatory argument : the name(s) of the new module(s) to create"; exit 1;
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
declare -g      __BU__BIN__MODULE_MK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR
                __BU__BIN__MODULE_MK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path")";
    readonly    __BU__BIN__MODULE_MK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR;

# Path to the
declare -g __BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_CONF_PATH;

# Path to the
declare -g __BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_INIT_PATH;

# Path to the
declare -g __BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_LIB_MODULE_FUNCTS_PATH;

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### FILES PROCESSING

## CHECKING FOR FILES PRESENCE

# ················································································································
# Checking if the required files for the modules initialization exists in their right folder, or else create them.

# shellcheck disable=
function check_mandatory_file_exists()
{
    #**** Parameters ****
    local p_path=${1:-$'\0'};

    #**** Code ****
    if [ ! -f "${p_path}" ]; then
        touch "${p_path}" || {
            echo "Unable to create this required file ''${p_path}''" >&2;
            echo >&2;

            echo "Please create this file manually." >&2;

            return 1;
        }
    fi

    return 0;
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

for module_name in "${__BU__BIN__MODULE_MK__ARGS__ARG_LIST[@]}"; do

    __BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_CONF_PATH="${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/install/.Bash-utils/config/modules/${module_name}";

    __BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_INIT_PATH="${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/install/.Bash-utils/modules/${module_name}";

    __BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_LIB_MODULE_FUNCTS_PATH="${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/lib/functions/${module_name}";

    if [ ! -d "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/install" ] || [ ! -d "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/lib" ]; then
        echo "You must run this script from its directory" >&2;
        echo >&2;

        echo "Terminating module creation" >&2;

        exit 1;
    fi

    # Checking if the whole module exists.
    if [ -d "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_CONF_PATH}" ] && [ -d "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_INIT_PATH}" ] && [ -d "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_LIB_MODULE_FUNCTS_PATH}" ]; then
	    echo "The ${module_name} module's directories already exist";
        
        exit 0;
    fi

    # Checking if the module's configuration path exists, or else creating its directory.
    if [ -d "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_CONF_PATH}" ]; then
	    echo "The ${module_name} module's configurations directory already exists : ${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_CONF_PATH}"

	   	check_mandatory_file_exists "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_CONF_PATH}/module.conf";
    else
	    mkdir -pv "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_CONF_PATH}" || { echo "Unable to create the ${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_CONF_PATH} directory"; exit 1; }

	  	check_mandatory_file_exists "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_CONF_PATH}/module.conf";
    fi

    # Checking if the module's initializer path exists, or else creating its directory.
    if [ -d "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_INIT_PATH}" ]; then
	    echo "The ${module_name} module's initializer directory already exists : ${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_INIT_PATH}";

	    check_mandatory_file_exists "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_INIT_PATH}/Initializer.sh";
    else
	    mkdir -pv "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_INIT_PATH}" || { echo "Unable to create the ${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_INIT_PATH} directory"; exit 1; }

	    check_mandatory_file_exists "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_MODULE_INIT_PATH}/Initializer.sh";
    fi

    # Checking if the module's library path exists, or else creating its directory.
    if [ -d "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_LIB_MODULE_FUNCTS_PATH}" ]; then
	    echo "The ${module_name} module's library directory already exists : ${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_LIB_MODULE_FUNCTS_PATH}";

        check_mandatory_file_exists "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_LIB_MODULE_FUNCTS_PATH}/${module_name}.lib";
    else
	    mkdir -pv "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_LIB_MODULE_FUNCTS_PATH}" || { echo "Unable to create the ${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_LIB_MODULE_FUNCTS_PATH} directory"; exit 1; }

        check_mandatory_file_exists "${__BU__BIN__MODULE_MK__GLOBVARS__PATHS__MAKE_LIB_MODULE_FUNCTS_PATH}/${module_name}.lib";
    fi

    echo;
done

# Printing that the targeted modules were successfully created into the Bash Utils framework's data folders.
if [ "${#__BU__BIN__MODULE_MK__ARGS__ARG_LIST[@]}" -lt 2 ]; then
    echo "The ${__BU__BIN__MODULE_MK__ARGS__ARG_LIST[0]} module was successfully created";
else
    echo "The following modules were successfully created :";

    for module in "${__BU__BIN__MODULE_MK__ARGS__ARG_LIST[@]}"; do
        echo "    - ${module}";
    done
fi

echo;

exit 0;
