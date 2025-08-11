#!/bin/bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : dev-merge-all-branches-from-dev.sh
# Author(s)     : Dimitri OBEID
# Contributors  :
#   -

# Version       : 1.0

# ----------------------
# SCRIPT'S DESCRIPTION :

# This script merges the code from the "dev" branch into all the sub-branches for better consitency.

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

## SUB-CATEGORY NAME

# Feel free to define an array of arguments here if needed.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################## PROJECT'S GLOBAL VARIABLES DEFINITIONS #######################################

#### ARRAYS DEFINITIONS

## CORE FEATURES

# List of local branches.
declare -agr __BU_ARRAY__LOCAL_BRANCHES=(   \
    'bin'                                   \
    'initializer-locale'                    \
    'initializer-script'                    \
)

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### VARIABLES DEFINITIONS

## SUB-CATEGORY NAME

# Current branch.
declare -g      __BU__BIN__GIT_MERGE_ALL_BRANCHES_FROM_DEV__CURRENT_BRANCH;
                __BU__BIN__GIT_MERGE_ALL_BRANCHES_FROM_DEV__CURRENT_BRANCH="$(git branch --show-current)" || exit 1;
    readonly    __BU__BIN__GIT_MERGE_ALL_BRANCHES_FROM_DEV__CURRENT_BRANCH;

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### CATEGORY NAME

## SUB-CATEGORY NAME

# ·············································
# Feel free to define functions here if needed.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

for branch in "${__BU_ARRAY__LOCAL_BRANCHES[@]}"; do
    git checkout "${branch}"    || exit 1;
    git merge dev               || exit 1;
done

git checkout "${__BU__BIN__GIT_MERGE_ALL_BRANCHES_FROM_DEV__CURRENT_BRANCH}";

exit 0;