#!/bin/bash

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### SOURCING PROJECT'S DEPENDENCIES ###########################################

## DECLARING PRE-INITIALIZATION VARIABLES

# Changing the locale of the system in the scope of the project.
LANG='fr_FR.UTF-8';

# LANG=""

# Declaring the framework installation variable (not in module argument, as some needed instructions are processed before the arguments processor).
# __BU_MODULE_PRE_INIT__IS_FRAMEWORK_INSTALLED='true';

# shellcheck disable=SC1090,SC1091
if ! source "${HOME}/Bash-utils-init.sh"; then
    __lineno="$(( LINENO - 3 ))";

    echo >&2;

    if [[ "${LANG}" == fr_* ]]; then
        echo -e "Dans le script $(basename "${0}"), à la ligne ${__lineno} --> Erreur : impossible d'inclure le code du script d'initialisation de modules." >&2;
    else
        echo -e "In $(basename "${0}"), line ${__lineno} --> Error : unable to source the modules initializer file." >&2;
    fi

    echo >&2;

    BU.ModuleInit.Exit 1;
fi

# Calling the "BashUtils_InitModules()" function.
# if ! BashUtils_InitModules \
#    "module --log-display --mode-log-full --stat-debug=false --stat-debug-bashx=file" \
#    "main --stat-debug=true stat-error=fatal --stat-log=true --stat-log-r=tee --stat-time-header=0 --stat-time-newline=0 --stat-time-txt=0 --stat-txt-fmt=true" \

# then
#    echo >&2; echo "In $(basename "${0}"), line $(( LINENO - 1 )) --> Error : something went wrong while calling the « BashUtils_InitModules() » function" >&2; echo >&2; exit 1;
# fi

# # "module --log-display --mode-log-full --stat-debug=false --stat-debug-bashx=file --include-aliases=main,hardware" \

# echo "INIT HARDWARE MODULE : LIBTEST";

# BU.Main.Modules.InitNewModule "Hardware";

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### GLOBAL VARIABLES (RE)DEFINITION ###########################################

#### ARGUMENTS DEFINITION

## ARGUMENTS DEFINITION

# Please define any needed arguments here.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### VARIABLES DEFINITION

## VARIABLES CATEGORY

# Please define any needed global variables here.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### FUNCTIONS DEFINITION

## FUNCTIONS CATEGORY

# Please define any needed functions here.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

# /////////////////////////////////////////////// TESTING BASH-UTILS FUNCTIONS //////////////////////////////////////////////// #

# Testing functions
# BU.Main.Echo.Newstep "Architecture du processeur : $(BU.Hardware.Linux.CPU.GetArch || BU.Main.Echo.Error "False")";

# BU.Main.Echo.Msg "Découpage de la chaîne de caractères \"BU.Main.Echo.Msg\" en \"Msg\" via la fonction \"BU.Main.Text.DeleteLettersInString()\" :";
# BU.Main.Echo.Msg "Résultat : $(BU.Main.Text.DeleteLettersInString "BU.Main.Echo.Msg" "BU.Main.Echo.")";

# BU.Main.Echo.Error "Test de l'appel de la fonction \"BU.Main.Echo.WriteMessage()\" via la fonction \"BU.Main.Echo.Error()\"";

# BU.Main.Echo.Msg "Test de l'appel de la fonction \"BU.Main.Echo.Msg()\" sans l'option \"nodate\"" '';
# BU.Main.Echo.Msg "Test de l'appel de la fonction \"BU.Main.Echo.Msg()\" avec l'option \"nodate\"" '' 'nodate';

# This command pauses the script, in order to see how much memory it uses.
# sleep 1;

# Testing a BU.Main.Decho.Decho.FMT function
# BU.Main.Decho.Decho.FMT_BlinkBoldDISU "Hello world" "${__BU_MAIN_COLOR_TXT_ORANGE}";
