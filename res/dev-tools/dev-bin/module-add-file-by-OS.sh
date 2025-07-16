#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : module-add-file-by-OS.sh
# Author(s)     : Dimitri OBEID
# Version       : 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# Generating a library file with specific code for each supported operating system, with every basic stuff needed for each file :
#   - the file's informations,
#   - the script's description,
#   - the Shellcheck global disabler,
#   - the execution prevention safeguards,
#   - and the visual decorations.

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### SOURCING PROJECT'S DEPENDENCIES ###########################################

#### BASH DEPENDENCIES

## BASH UTILS

# shellcheck disable=SC1090,SC1091
if ! source "${HOME}/Bash-utils-init.sh"; then
# if ! source "${HOME}/.Bash-utils/compiled/stable/Bash-utils-fr.sh"; then
# if ! source "${HOME}/.Bash-utils/compiled/unstable/Bash-utils-fr.sh"; then
    echo >&2; echo -e "In $(basename "${0}"), line $(( LINENO - 1 )) --> Error : unable to source the modules initializer file." >&2; echo >&2; exit 1;
fi

# Calling the "BashUtils_InitModules()" function.
if ! BashUtils_InitModules \
    "module --log-display --mode-log-partial --stat-debug=false --stat-debug-bashx=file --include-aliases=main,hardware" \
    "main --stat-debug=true stat-error=fatal --stat-log=true --stat-log-r=tee --stat-time-header=0 --stat-time-newline=0 --stat-time-txt=0 --stat-txt-fmt=true" \

    then
	    echo >&2; echo "In $(basename "${0}"), line $(( LINENO - 1 )) --> Error : something went wrong while calling the « BashUtils_InitModules() » function" >&2; echo >&2; exit 1;
fi

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

############################################# GLOBAL RESOURCES DEFINITION #############################################

########################################### PROJECT'S ARGUMENTS DEFINITIONS ###########################################

#### POSITIONAL ARGUMENTS

## FILE'S INFORMATIONS

# ARG TYPE : String
# REQUIRED
# DEFAULT VAL : NULL

# DESC : Target module's name.

declare -gr __BU__BIN__MAFB_OS__ARGS__MODULE_NAME=${1:-$'\0'};

# ARG TYPE : String
# REQUIRED
# DEFAULT VAL : NULL

# DESC : Name of the library file to create.

declare -gr __BU__BIN__MAFB_OS__ARGS__FILE_NAME=${2:-$'\0'};

# ARG TYPE : String
# REQUIRED
# DEFAULT VAL : NULL

# DESC : Name of the author of the library file to create.

declare -gr __BU__BIN__MAFB_OS__ARGS__AUTHOR_NAME=${3:-$'\0'};

# ARG TYPE : String
# OPTIONAL
# DEFAULT VAL : NULL

# DESC : Version of the library file to create.

declare -gr __BU__BIN__MAFB_OS__ARGS__FILE_VERSION=${4:-$'\0'};

# ARG TYPE : String
# OPTIONAL
# DEFAULT VAL : NULL

# DESC : Setting the OS name at the left or the right of the "${__BU__BIN__MAFB_OS__ARGS__FILE_NAME}" string in the name of the file to create.

declare -gr __BU__BIN__MAFB_OS__ARGS__FILE_OS_POSITION=${5:-$'\0'};

[[ -n "${__BU__BIN__MAFB_OS__ARGS__FILE_VERSION}" ]] && [[ -n "${__BU__BIN__MAFB_OS__ARGS__FILE_OS_POSITION}" ]] && shift 6;

[[ -n "${__BU__BIN__MAFB_OS__ARGS__FILE_VERSION}" ]] && [[ -z "${__BU__BIN__MAFB_OS__ARGS__FILE_OS_POSITION}" ]] || \

[[ -z "${__BU__BIN__MAFB_OS__ARGS__FILE_VERSION}" ]] && [[ -n "${__BU__BIN__MAFB_OS__ARGS__FILE_OS_POSITION}" ]] && shift 5;

[[ -z "${__BU__BIN__MAFB_OS__ARGS__FILE_VERSION}" ]] && [[ -z "${__BU__BIN__MAFB_OS__ARGS__FILE_OS_POSITION}" ]] && shift 4;

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### ARRAY OF ARGUMENTS

## OPERATING SYSTEMS SUPPORT

# ARG TYPE : Array
# REQUIRED
# DEFAULT VAL : NULL
# DESC : Array of operating systems names.
declare -agr __BU__BIN__MAFB_OS__ARGS__OS_ARRAY=("${@}");

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

## SUB-CATEGORY NAME

# Path to the current module's directory.
declare -gr __BU__BIN__MAFB_OS__GLOBVARS__PATHS__MODULE_DIR="lib/functions/${__BU__BIN__MAFB_OS__ARGS__MODULE_NAME}";

# Name of the current OS, respecting the case of the modules' OS folders names.

# Do not set a value now, it will be done in the program's main loop.
declare -g __BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME;

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### CATEGORY NAME

## SUB-CATEGORY NAME

# ·······························································
# Writing the file's informations section into the targeted file.

# shellcheck disable=
function WriteFileInformations()
{
    #**** Parameters ****
    local p_filename=${1:-$'\0'}; # ARG TYPE : String       - REQUIRED | DEFAULT VAL : NULL     - DESC : Name of the file where the file's informations have to be written.
    local p_filepath=${2:-$'\0'}; # ARG TYPE : Filepath     - REQUIRED | DEFAULT VAL : NULL     - DESC : Path to the file where the file's informations have to be written.

    #**** Code ****
    if [ -z "${p_filename}" ]; then echo "${FUNCNAME[0]}() function : file name argument required" >&2; echo >&2; return 1; fi
    if [ -z "${p_filepath}" ]; then echo "${FUNCNAME[0]}() function : file path argument required" >&2; echo >&2; return 1; fi

cat <<-EOF >> "${p_filepath}"
#!/usr/bin/env bash

# ---------------------
# FILE'S INFORMATIONS :

# Name          : ${p_filename}
# Module        : ${__BU__BIN__MAFB_OS__ARGS__MODULE_NAME}
# Author(s)     : ${__BU__BIN__MAFB_OS__ARGS__AUTHOR_NAME}
# Version       : ${__BU__BIN__MAFB_OS__ARGS__FILE_VERSION}


EOF
    return 0;
}

# ································································
# Writing the script's description section into the targeted file.

# shellcheck disable=
function WriteScriptDescription()
{(
    #**** Parameters ****
    local p_filepath=${1:-$'\0'}; # ARG TYPE : Filepath     - REQUIRED | DEFAULT VAL : NULL     - DESC : Path to the file where the file's informations have to be written.

    #**** Code ****
    if [ -z "${p_filepath}" ]; then echo "${FUNCNAME[0]}() function : file path argument required" >&2; echo >&2; return 1; fi

    function WriteScriptDescription.OS()
    {
        [ -z "${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}" ]             && echo -n "# Functions used to process data and parameters about [ INSERT ${p_filepath} INFO ] with the help of the system commands on any supported operating system.";
        [ "${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}" == 'Android' ]   && echo -n "# Functions used to process data and parameters about the device's [ INSERT ${p_filepath} INFO ] with the help of the system commands on an Android-based operating system.";
        [ "${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}" == 'BSD' ]       && echo -n "# Functions used to process data and parameters about the computer's [ INSERT ${p_filepath} INFO ] with the help of the system commands on a BSD-based operating system.";
        [ "${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}" == 'Haiku' ]     && echo -n "# This script manages the [ INSERT ${p_filepath} INFO ]-related hardware functionalities of the Haiku operating system.";
        [ "${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}" == 'Linux' ]     && echo -n "# Functions used to process data and parameters about the computer's [ INSERT ${p_filepath} INFO ] with the help of the system commands on a Linux-based operating system.";
        [ "${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}" == 'OSX' ]       && echo -n "# Functions used to process data and parameters about the Mac's [ INSERT ${p_filepath} INFO ] with the help of the OSX system's commands.";
        [ "${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}" == 'Windows' ]   && echo -n "# Functions used to process data and parameters about the PC's [ INSERT ${p_filepath} INFO ] with the help of the WSL / Windows system's commands.";
    }

cat <<-EOF >> "${p_filepath}"
# ----------------------
# SCRIPT'S DESCRIPTION :

$(WriteScriptDescription.OS;)


EOF
    return 0;
)}

# ··································································································
# Writing the Shellcheck and the pieces of code which prevent the direct execution of its host file.

# shellcheck disable=
function WriteShellcheckGlobalDisablerAndDirectExecutionPreventionCode()
{
    #**** Parameters ****
    local p_filepath=${1:-$'\0'}; # ARG TYPE : Filepath     - REQUIRED | DEFAULT VAL : NULL     - DESC : Path to the file where the file's informations have to be written.

    #**** Code ****
    if [ -z "${p_filepath}" ]; then echo "${FUNCNAME[0]}() function : file path argument required" >&2; echo >&2; return 1; fi

cat <<-EOF >> "${p_filepath}"
# ----------------------------
# SHELLCHECK GLOBAL DISABLER :

# Add a coma after each warning code to disable multiple warnings at one go.

# Do not uncomment the "shellcheck disable" line, or else the "\$(shellcheck)" command will be executed during the script's execution, and will not detect any coding mistake during a debugging process.

# DO NOT ADD A COMA AFTER A SHELLCHECK CODE IF THERE'S NO OTHER SHELLCHECK CODE FOLLOWING IT, OR ELSE THE "\$(shellcheck)" COMMAND WILL RETURN ERRORS DURING THE DEBUGGING PROCESS !!!

# IF YOU WANT TO ADD ANOTHER SHELLCHECK CODE, WRITE THIS CODE DIRECTLY AFTER THE COMMA, WITHOUT ADDING A BLANK SPACE AFTER IT !!!

# shellcheck disable=SC2154


# ----------------------------------------------------------------------------------------------------------------------------------------------
# DO NOT EXECUTE THIS SCRIPT DIRECTLY, instead, just source it by calling the "\${__BU_MAIN_FUNCTIONS_FILES_PATH}" array in the initializer file.

# /////////////////////////////////////////////////////////////////////////////////////////////// #

# Preventing the direct execution of this file, as it is not meant to be directly executed, but sourced.
if [ "${0##*/}" == "${BASH_SOURCE[0]##*/}" ]; then
    if [[ "${LANG}" == de_* ]]; then
        echo -e "ACHTUNG !" >&2; echo >&2;
        echo -e "Dieses Shell-Skript (${BASH_SOURCE[0]}) ist nicht dazu gedacht, direkt ausgeführt zu werden !" >&2; echo >&2;
        echo -e "Verwenden Sie nur dieses Skript, indem Sie es in Ihr Projekt aufnehmen." >&2;

    elif [[ "${LANG}" == es_* ]]; then
        echo -e "ATENCIÓN !" >&2; echo >&2;
        echo -e "Este script de shell (${BASH_SOURCE[0]}) no debe ejecutarse directamente !" >&2; echo >&2;
        echo -e "Utilice sólo este script incluyéndolo en el script de su proyecto." >&2;

    elif [[ "${LANG}" == fr_* ]]; then
        echo -e "ATTENTION !" >&2; echo >&2;
        echo -e "Ce script shell (${BASH_SOURCE[0]}) n'est pas conçu pour être directement exécuté !" >&2; echo >&2;
        echo -e "Utilisez seulement ce script en l'incluant dans votre projet." >&2;

    elif [[ "${LANG}" == hi_* ]]; then
        echo -e "चेतावनी!" >&2; echo >&2;
        echo -e "यह शेल स्क्रिप्ट (${BASH_SOURCE[0]}) सीधे निष्पादित करने के लिए नहीं है!" >&2; echo >&2;
        echo -e "इस स्क्रिप्ट को अपने प्रोजेक्ट स्क्रिप्ट में शामिल करके ही इस्तेमाल करें।" >&2;

    elif [[ "${LANG}" == id_* ]]; then
        echo -e "PERINGATAN !" >&2; echo >&2;
        echo -e "Skrip shell ini (${BASH_SOURCE[0]}) tidak dimaksudkan untuk dieksekusi secara langsung !" >&2; echo >&2;
        echo -e "Gunakan skrip ini hanya dengan memasukkannya ke dalam skrip proyek Anda." >&2;

    elif [[ "${LANG}" == ja_* ]]; then
        echo -e "警告 ！" >&2; echo >&2;
        echo -e "このシェルスクリプト（${BASH_SOURCE[0]}）は、直接実行することはできません！" >&2; echo >&2;
        echo -e "このスクリプトは、プロジェクトスクリプトに含める必要があり、このスクリプトと一緒にしか使用できません。" >&2;

    elif [[ "${LANG}" == ko_* ]]; then
        echo -e "경고 !" >&2; echo >&2;
        echo -e "이 셸 스크립트(${BASH_SOURCE[0]})는 직접 실행하도록 설계되지 않았습니다!" >&2; echo >&2;
        echo -e "프로젝트 스크립트에 포함하여 이 스크립트만 사용하십시오." >&2;

    elif [[ "${LANG}" == pt_* ]]; then
        echo -e "ATENÇÃO !" >&2; echo >&2;
        echo -e "Este script de shell (${BASH_SOURCE[0]}) não é para ser executado directamente !" >&2; echo >&2;
        echo -e "Utilize este guião apenas incluindo-o no seu projecto." >&2;

    elif [[ "${LANG}" == ru_* ]]; then
        echo -e "ВНИМАНИЕ !" >&2; echo >&2;
        echo -e "Этот сценарий оболочки (${BASH_SOURCE[0]}) не предназначен для непосредственного выполнения !" >&2; echo >&2;
        echo -e "Используйте только этот скрипт, включив его в свой проект." >&2;

    elif [[ "${LANG}" == sv_* ]]; then
        echo -e "VARNING!" >&2; echo >&2;
        echo -e "Detta skalskript (${BASH_SOURCE[0]}) är inte avsett att köras direkt!" >&2; echo >&2;
        echo -e "Använd endast detta skript genom att inkludera det i ditt projektskript." >&2;

    elif [[ "${LANG}" == tr_* ]]; then
        echo -e "UYARI!" >&2; echo >&2;
        echo -e "Bu kabuk betiği (${BASH_SOURCE[0]}) doğrudan çalıştırılmak üzere tasarlanmamıştır!" >&2; echo >&2;
        echo -e "Proje kodunuza dahil ederek yalnızca bu kodu kullanın." >&2;

    elif [[ "${LANG}" == uk_* ]]; then
        echo -e "УВАГА !" >&2; echo >&2;
        echo -e "Цей скрипт оболонки (${BASH_SOURCE[0]}) не призначений для безпосереднього виконання !" >&2; echo >&2;
        echo -e "Використовуйте тільки цей скрипт, включивши його в скрипт вашого проекту." >&2;

    elif [[ "${LANG}" == zh_* ]]; then
        echo -e "警告 !" >&2; echo >&2;
        echo -e "这个shell脚本(${BASH_SOURCE[0]})是不能直接执行的!" >&2; echo >&2;
        echo -e "只使用这个脚本并将其纳入你的项目脚本。" >&2;

    else
        echo -e "WARNING !" >&2; echo >&2;
        echo -e "This shell script (${BASH_SOURCE[0]}) is not meant to be executed directly !" >&2; echo >&2;
        echo -e "Use only this script by including it in your project script." >&2;

    fi;
    
    echo >&2; 
    
    exit 1; 
fi

# End of the prevention of the direct execution of this file.

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

#################################### DEFINING LIBRARY FUNCTIONS ###################################

####
#### DEBUG ID :

##
## DEBUG ID :



## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #
EOF
    return 0;
}



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

####

## OPERATING SYSTEM-INDEPENDENT FILE

if [ -z "${__BU__BIN__MAFB_OS__ARGS__MODULE_NAME}" ];   then echo "No specified module" >&2;    echo >&2; exit 1; fi

if [ -z "${__BU__BIN__MAFB_OS__ARGS__FILE_NAME}" ];     then echo "No specified file" >&2;      echo >&2; exit 1; fi

if [ "${#__BU__BIN__MAFB_OS__ARGS__OS_ARRAY[@]}" -eq 0 ]; then __BU__BIN__MAFB_OS__ARGS__OS_ARRAY=("Android" "BSD" "Haiku" "Linux" "OSX" "Windows"); fi

declare -gr __BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_NAME_LIB_NO_OS="${__BU__BIN__MAFB_OS__ARGS__FILE_NAME}.lib";
declare -gr __BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_NO_OS="${__BU__BIN__MAFB_OS__GLOBVARS__PATHS__MODULE_DIR}/${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_NAME_LIB_NO_OS}";

# Creating the library file into the module's root directory.
if [ ! -f "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_NO_OS}" ]; then
    touch "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_NO_OS}";
else
    echo "The ${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_NO_OS} file already exists";
    echo;
fi

#~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~ STEP ONE : Writing the "FILE'S INFORMATIONS :" section into each new files with a here document
#~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

WriteFileInformations \
    "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_NAME_LIB_NO_OS}" \
    "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_NO_OS}" \
    || exit 1;

#~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~ STEP TWO : Writing the "SCRIPT'S DESCRIPTION :" section into each new files with a here document
#~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

WriteScriptDescription \
    "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_NO_OS}" \
    || exit 1;

#~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~ STEP THREE : Writing the "SHELLCHECK GLOBAL DISABLER :" section and the code which prevent the direct execution of its host file
#~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

WriteShellcheckGlobalDisablerAndDirectExecutionPreventionCode \
    "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_NO_OS}" \
    || exit 1;

## ==============================================

# Main loop.
for operating_system in "${__BU__BIN__MAFB_OS__ARGS__OS_ARRAY[@]}"; do
    # Setting a variable for the current operating system, as the input specified by the user may not respect the case of the OS folders names.
    if      [ "${operating_system,,}" == 'android' ];   then __BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME='Android';
    elif    [ "${operating_system^^}" == 'BSD' ];       then __BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME='BSD';
    elif    [ "${operating_system,,}" == 'haiku' ];     then __BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME='Haiku';
    elif    [ "${operating_system,,}" == 'linux' ];     then __BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME='Linux';
    elif    [ "${operating_system^^}" == 'OSX' ];       then __BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME='OSX';
    elif    [ "${operating_system,,}" == 'windows' ];   then __BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME='Windows';
    else
        echo "The ${operating_system} operating system is not supported" >&2;
        echo >&2;

        __ERR='error'; break 1;
    fi

    [ "${__BU__BIN__MAFB_OS__ARGS__FILE_OS_POSITION,,}" == 'left' ]     && __os_pos_l="${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}.";
    [ "${__BU__BIN__MAFB_OS__ARGS__FILE_OS_POSITION,,}" == 'right' ]    && __os_pos_r=".${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}";

    # If the OS directory is found in the module's folder.
    if [ -d "${__BU__BIN__MAFB_OS__GLOBVARS__PATHS__MODULE_DIR}/${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}" ]; then

        __BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_NAME_LIB_OS_DEPENDENT="${__os_pos_l}${__BU__BIN__MAFB_OS__ARGS__FILE_NAME}${__os_pos_r}.lib";
        __BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_OS_DEPENDENT="${__BU__BIN__MAFB_OS__GLOBVARS__PATHS__MODULE_DIR}/${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME}/${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_NAME_LIB_OS_DEPENDENT}";

        # Creating the library file into the module's OS directory where it belongs.
        if [ ! -f "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_OS_DEPENDENT}" ]; then
            touch "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_OS_DEPENDENT}";
        else
            echo "The ${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_OS_DEPENDENT} file already exists" >&2;
            echo >&2;

            #__ERR='error'; break 1;
        fi

        #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        #~ STEP ONE : Writing the "FILE'S INFORMATIONS :" section into each new files with a here document
        #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        WriteFileInformations \
            "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_NAME_LIB_OS_DEPENDENT}" \
            "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_OS_DEPENDENT}" \
            || { declare -r __ERR='error'; break 1; };

        #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        #~ STEP TWO : Writing the "SCRIPT'S DESCRIPTION :" section into each new files with a here document
        #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        WriteScriptDescription \
            "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_OS_DEPENDENT}" \
            || { declare -r __ERR='error'; break 1; };

        #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        #~ STEP THREE : Writing the "SHELLCHECK GLOBAL DISABLER :" section and the code which prevent the direct execution of its host file
        #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        WriteShellcheckGlobalDisablerAndDirectExecutionPreventionCode \
            "${__BU__BIN__MAFB_OS__GLOBVARS__FILES__FILE_PATH_LIB_OS_DEPENDENT}" \
            || { __ERR='error'; break 1; };
    else
        echo "The folder for the ${__BU__BIN__MAFB_OS__GLOBVARS__OS__OS_NAME} operating system was not found in the ${__BU__BIN__MAFB_OS__ARGS__MODULE_NAME} module's folder" >&2;
        echo >&2;

        false;
    fi
done

if [ "${__ERR}" == 'error' ]; then exit 1; else exit 0; fi
