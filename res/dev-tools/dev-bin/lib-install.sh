#!/bin/bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : lib-install.sh
# Author(s)     : Dimitri OBEID
# Version       : 2.1


# ----------------------
# SCRIPT'S DESCRIPTION :

# A very simple script, which copies the "Bash-utils-init.sh" file and the ".Bash-utils" folder in the user's home directory.

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

## ACTIONS

# ARG TYPE : STRING
# REQUIRED
# DEFAULT VAL : NULL

# DESC : Stores the user's authorization to copy the read-only compiled files in the "${HOME/.Bash-utils".
__BU__BIN__LIB_INSTALL__ARGS__ACTION=${1:-$'\0'};

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### ARRAY OF ARGUMENTS

## SUB-CATEGORY NAME

# Feel free to define an array of arguments here if needed.

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

# Path to the "install/.Bash-utils" directory.
declare -g -r __BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__DOT_BU_DIR_PATH="install/.Bash-utils/";

# Path to the "Bash-utils-init.sh" folder into the "install/" directory.
declare -g -r __BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BUINIT_PATH="install/Bash-utils-init.sh";

# Path to the ".Bash-utils" folder into the home directory.
declare -g -r __BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BU_D_IN_HOME_DIR="${HOME}/.Bash-utils";

# Path to the ".Bash-utils-init-val.path" file into the ".Bash-utils" directory.
declare -g -r __BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BU_INIT_VAL_PATH="${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BU_D_IN_HOME_DIR}/Bash-utils-init-val.path";

# Path to the directory containing the compiled stable files in the project's folder.
declare -g -r __BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__STABLE_FILES_PROJECT_DIR='install/.Bash-utils/compiled/stable';

# Path to the directory containing the compiled stable files in the user's home directory.
declare -g -r __BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__STABLE_FILES_HOME_DIR="${HOME}/.Bash-utils/compiled/stable";

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

####

##

# ·············································
# Feel free to define functions here if needed.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

if [ ! -d "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__DOT_BU_DIR_PATH}" ]; then
    echo "The \"${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__DOT_BU_DIR_PATH}\" directory does not exists";
    echo "Aborting the script's execution";

    exit 1;
fi

cp -r "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__DOT_BU_DIR_PATH}" ~ || { echo "Unable to copy the \"${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__DOT_BU_DIR_PATH}\" folder into the ${HOME} directory"; exit 1; }

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## COMMENTING THE FOLLOWING LINES UNTIL THIS SCRIPT WILL SUPPORT THE OPTIONS TO PROCESS THE READ-ONLY FILES ACCORDING TO THE USER'S DESIRES
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if [ ! -f "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BUINIT_PATH}" ]; then
    echo "Unable to find the ${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BUINIT_PATH} file";
    echo "Aborting the script's execution";

    exit 1;
fi

cp "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BUINIT_PATH}" ~   || {
    echo "Unable to copy the initializer script in the ${HOME} directory";
    echo "Aborting the script's execution";

    exit 1;
};

echo "Successfully copied the initializer script in the ${HOME} directory";
echo;

# If one or more stable files are found in the "install/.Bash-utils/compiled/stable" directory.
if [ -d "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__STABLE_FILES_PROJECT_DIR}" ] \
    && [ -n "$(ls "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__STABLE_FILES_PROJECT_DIR}")" ] \
    && [[ "${__BU__BIN__LIB_INSTALL__ARGS__ACTION,,}" == -?(-)i?(nclude-ro-files) ]];
then
    # As it is impossible to copy the read-only files in another directory, those files' read-only mode is unset.
    for file in "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__STABLE_FILES_PROJECT_DIR}/"*.sh; do
        printf "Changing the %s%s%s file right from read-only to rwx... " "$(tput setaf 6)" "${file}" "$(tput sgr0)";

        chmod +wr "${file}" > /dev/null 2>&1 || {
            printf "Failed %s❌%s\n\n" "$(tput setaf 9)" "$(tput sgr0)";

            printf "Unable to unset the read-only mode from the %s%s%s file\n" "$(tput setaf 6)" "${file}" "$(tput sgr0)";

            exit 1;
        };

        printf "done %s✓%s\n" "$(tput setaf 2)" "$(tput sgr0)";
    done

    echo;
fi

cp -r "install/.Bash-utils" ~       || {
    echo "Unable to copy the Bash Utils modules directory in the ${HOME} directory";
    echo "Aborting the script's execution";

    exit 1;
};

echo "Successfully copied the Bash Utils modules directory in the ${HOME} directory";
echo;

# If the "Bash-utils-init-val.path" file does not exists into the "${HOME}/.Bash-utils" directory.
if [ ! -f "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BU_INIT_VAL_PATH}" ]; then
    printf "Creating the %s%s%s file... " "$(tput setaf 6)" "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BU_INIT_VAL_PATH}" "$(tput sgr0)";

    touch "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BU_INIT_VAL_PATH}" || {
        printf "Failed %s❌%s\n\n" "$(tput setaf 9)" "$(tput sgr0)";

        printf "Unable to create the %s%s%s file\n" "$(tput setaf 6)" "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BU_INIT_VAL_PATH}" "$(tput sgr0)";

        exit 1;
    };

    printf "done %s✓%s\n" "$(tput setaf 2)" "$(tput sgr0)";
    printf "\n";

    # printf "Do you want to use the %s%s%s project's directory outside of its default location?\n" "$(tput setaf 6)" "Bash-Utils-NG" "$(tput sgr0)";
    # printf "Default location is %s%s%s\n" "$(tput setaf 6)" "/usr/local/lib" "$(tput sgr0)";
    # printf "\n";

    # read -rp "Enter your answer (y/n) : " rep;

    # case "${rep}" in
    #     )
    #         ;;
    #     )
    #         ;;
    #     *)
    #         ;;
    # esac

fi

# If one or more stable files are found in the "${HOME}/.Bash-utils/compiled/stable" directory.
if [ -n "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__STABLE_FILES_HOME_DIR}" ] \
    && [ -n "$(ls "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__STABLE_FILES_HOME_DIR}")" ] \
    && [[ "${__BU__BIN__LIB_INSTALL__ARGS__ACTION,,}" == -?(-)i?(nclude-ro-files) ]];
then
    # Resetting the files in their original read-only mode.
    for file in "${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__STABLE_FILES_HOME_DIR}"*.sh; do
        printf "Resetting the read-only mode for this file : %s%s%s..." "$(tput setaf 6)" "${file}" "$(tput sgr0)";

        chmod -wx+r "${file}" > /dev/null 2>&1 || {
            printf "Failed %s❌%s\n\n" "$(tput setaf 9)" "$(tput sgr0)";

            printf "Unable to reset the read-only mode for this file : %s%s%s\n" "$(tput setaf 6)" "${file}" "$(tput sgr0)";

            exit 1;
        };

        printf "done %s✓%s\n" "$(tput setaf 2)" "$(tput sgr0)";
    done

    echo;
fi

exit 0;
