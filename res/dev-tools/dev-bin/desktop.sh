c#!/bin/bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : desktop.sh
# Author(s)     : Dimitri OBEID
# Contributors  :
#   -

# Version       : 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# This script serves to create quickly a shortcut file into the wished location.
# You will just have to fill the empty fields.

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### SOURCING PROJECT'S DEPENDENCIES ###########################################

#### BASH DEPENDENCIES

## BASH UTILS

# shellcheck disable=SC1090,SC1091
if ! source "/usr/local/lib/Bash-utils/lib/Initializer.sh"; then
    echo; echo -e "In $(basename "${0}"), line $(( LINENO - 1 )) --> Error : unable to source the initialization file."; echo; exit 1;
fi

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

############################################# GLOBAL RESOURCES DEFINITION #############################################

########################################### PROJECT'S ARGUMENTS DEFINITIONS ###########################################

#### POSITIONAL ARGUMENTS

## PATHS

# ARG TYPE : Filepath
# REQUIRED
# DEFAULT VAL : NULL

# DESC : Path of the file to create, including its name.
__P_DESKTOP_PATH=${1:-$'\0'};

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### ARRAY OF ARGUMENTS

##

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

##

# Feel free to define variables here if needed.

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

if test "${#}" -ne 1; then
	BU.Main.Echo.Error "Usage : $(BU.Main.Decho.echoE "./Desktop.sh /path/to/the/file.desktop")";
	BU.Main.Echo.Error "or";
	BU.Main.Echo.Error "$(BU.Main.Decho.echoE "sudo ./Desktop.sg /path/to/the/file.desktop")";
	BU.Main.Echo.Newline;
	exit 1
fi

BU.Main.Echo.Newstep "Creating the $(BU.Main.Decho.echoN "${__P_DESKTOP_PATH}") file";
BU.Main.Echo.Newline;

cat <<-EOF > "${__P_DESKTOP_PATH}";
#!/usr/bin/env xdg-open

[Desktop Entry]
Name=
Comment=
Exec=
Icon=
Terminal=true
Type=Application
Categories=;
EOF

if test "${?}" -eq 0; then
	BU.Main.Echo.Success "The $(BU.Main.Decho.echoS "${__P_DESKTOP_PATH}") file was successfully created.";
	BU.Main.Echo.Newline; exit 0;
else
	BU.Main.Echo.Error "An error occured during the $(BU.Main.Decho.echoE "${__P_DESKTOP_PATH}") file creation.";
	BU.Main.Echo.Newline; exit 1;
fi

exit 0;
