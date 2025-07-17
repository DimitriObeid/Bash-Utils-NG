#!/usr/bin/env bash

# -----------------------
# SCRIPT'S INFORMATIONS :

# Name          : Bash-utils-init.sh
# Author(s)     : Dimitri OBEID
# Version       : Beta 0.2-NG


# ----------------------
# SCRIPT'S DESCRIPTION :

# This file contains the main part of the framework initializer script.

# This script declares every global variables, defines some useful functions you may use in the main module,
# and initializes all the modules you need for your scripts, from their configuration files to their initializer file.


# ----------------------------
# SHELLCHECK GLOBAL DISABLER :

# Add a coma after each warning code to disable multiple warnings at one go.

# Do not uncomment the "shellcheck disable" line, or else the "$(shellcheck)" command will be executed during the script's execution, and will not detect any coding mistake during a debugging process.

# DO NOT ADD A COMA AFTER A SHELLCHECK CODE IF THERE'S NO OTHER SHELLCHECK CODE FOLLOWING IT, OR ELSE THE "$(shellcheck)" COMMAND WILL RETURN ERRORS DURING THE DEBUGGING PROCESS !!!

# IF YOU WANT TO ADD ANOTHER SHELLCHECK CODE, WRITE THIS CODE DIRECTLY AFTER THE COMMA, WITHOUT ADDING A BLANK SPACE AFTER IT !!!

# shellcheck disable=SC2154,SC1090


# ------------------------
# NOTES ABOUT SHELLCHECK :

# To display the content of a variable in a translated string, the use of the "$(printf)" command is mandatory in order to interpret each "%s" pattern as the value of a variable.

# This means that the Shellcheck warning code SC2059 will be triggered anyway, since we have no choice but to store the entirety of every translated strings into global variables, many of which contain the above-mentioned pattern.

# If you add new messages to translate, you must call the "# shellcheck disable=SC2059" directive before the line where you call the
# "$(printf)" command to display the translated message, otherwise Shellcheck will display many warnings during the debugging procedure.

# If the message is displayed inside a function, you can write the "# shellcheck disable=SC2059" directive on the line above the declaration of the said function.

# You can also write this directive at the beginning of a Bash script, but I would not recommand you to do so, since you may use the "$(printf)" command in another context, without the same purpose.


# --------------------------------------------------------------------------------------
# DO NOT EXECUTE THIS SCRIPT DIRECTLY, instead, just source it in your main script file.

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

# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### INITIALIZER RESOURCES - FUNCTIONS REQUIRED TO INITIALIZE THE MODULE ENGINE

## 

# ····················································
# Checking the currently used Bash language's version.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#	- echo		| (-e)
#	- printf	|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.CheckBashMinimalVersion()
{
    if [ "${BASH_VERSINFO[0]:-0}" -lt 4 ]; then
		printf "BASH-UTILS MODULES INITIALIZATION ERROR : In \n\t%s,\n\tline $(( LINENO - 1 ))\n\n", "$(basename "${BASH_SOURCE[0]}")" >&2;
        printf "\nThis Bash library requires at least the Bash language's version 4.0.0\n\n"
		echo >&2;

		printf "Your Bash version is : %s" "${BASH_VERSION}" >&2;
		echo >&2

		printf "Please install at least the Bash version 4.0.0 to use this library" >&2;
		echo >&2;

		# WARNING : Do not call the "BU.ModuleInit.AskPrintLog()" function here, the current function is defined before the "${__BU_MODULE_INIT_MSG_ARRAY}" array.
		return 1;
	fi
}

# ··························································································································································
# Defining a function in order to suppress every shellcheck advices about the "printf" command, in order to do so at once AND to keep the code's decoration.

# Note : the second purpose of this function is to hide its long code in any code editor, in order to make the navigation easier into this very large file.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.FindPath()                              -> Modules initializer script (this file)
#   - BU.ModuleInit.IsFrameworkBeingInstalled()             -> Modules initializer script (this file)
#   - BU.ModuleInit.IsFrameworkCompiled()                   -> Modules initializer script (this file)
#   - BU.ModuleInit.PrintErrorMissingBashUtilsHomeFolder()  -> Modules initializer script (this file)


# shellcheck disable=SC2059,SC2016
function BU.ModuleInit.DefineBashUtilsGlobalVariablesBeforeInitializingTheModules()
{
    #**** Code ****

    # PID
    declare -g    __BU_MODULE_INIT__PROJECT_PID="${$}";
    declare -g -i __bu_module_init__project_pid__lineno="$(( LINENO - 1 ))";

    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ FINDING THE ".Bash-utils" FOLDER'S PARENT DIRECTORY
    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    declare -g    __BU_MODULE_INIT__ROOT_HOME="${HOME}";
    declare -g -i __bu_module_init__root_home__lineno="$(( LINENO - 1 ))";

    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ STORING THE NAME OF THE FRAMEWORK'S TEMPORARY DIRECTORY
    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    declare -g    __BU_MODULE_INIT__TMP_DIR_NAME="tmp";
    declare -g -i __bu_module_init__tmp_dir_name__lineno="$(( LINENO - 1 ))";

    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ FINDING THE ".Bash-utils" FOLDER
    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    # If the framework base is not being installed on the user's hard drive.
    if ! BU.ModuleInit.IsFrameworkBeingInstalled; then
        # If the ".Bash-utils" folder exists in its defined parent directory,
        # then the ".Bash-utils" default parent folder is defined as the user's home directory.
        if [ -d "${__BU_MODULE_INIT__ROOT_HOME}/.Bash-utils" ]; then
            declare -g -i __bu_module_init__root__lineno="$(( LINENO + 4 ))";

            declare -g \
            __BU_MODULE_INIT__ROOT;
            
            __BU_MODULE_INIT__ROOT="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__ROOT_HOME}" ".Bash-utils" 'd' || {
                printf \
                    "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
                    "$(basename \
                        "${BASH_SOURCE[0]}")" \
                    "${__bu_module_init__root__lineno}" \
                    '$__BU_MODULE_INIT__ROOT';

                BU.ModuleInit.Exit 1; return "${?}";
            })";

            # If the base code of the framework is not compiled in a single file.
            if ! BU.ModuleInit.IsFrameworkCompiled; then
                # shellcheck disable=SC2034
                declare -g __bu_module_init__initializer_path__lineno="$(( LINENO + 4 ))";

                declare -g \
                __BU_MODULE_INIT__INITIALIZER_PATH;
                
                __BU_MODULE_INIT__INITIALIZER_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__ROOT_HOME}" "$(basename "${BASH_SOURCE[0]}")" 'f' || {
                    printf \
                        "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
                        "$(basename \
                            "${BASH_SOURCE[0]}")" \
                        "${__bu_module_init__initializer_path__lineno}" \
                        '$__BU_MODULE_INIT__INITIALIZER_PATH';

                    BU.ModuleInit.Exit 1; return "${?}";
                })";
            fi
        # Else, if the ".Bash-utils" folder does not exists in its defined parent directory.
        else
            BU.ModuleInit.PrintErrorMissingBashUtilsHomeFolder "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" "$(( LINENO - 1 ))";

            # WARNING : Do not call the "BU.ModuleInit.AskPrintLog()" function here, the current function is defined before the "${__BU_MODULE_INIT_MSG_ARRAY" array.
            BU.ModuleInit.Exit 1;

            return "${?}";
        fi

    # Else, if the ".Bash-utils" folder doesn't exists in its defined parent directory AND the framework base is being installed on the user's hard drive,
    # then the ".Bash-utils" default parent folder is defined as the "/tmp" folder in the system root directory. This redefinition is important for the next path variables' values.
    else
        # Checking if the ".Bash-utils" folder exists in the user's home directory.
        if [ ! -d "${__BU_MODULE_INIT__ROOT_HOME}" ]; then
            # Redefining the "${__BU_MODULE_INIT__ROOT_HOME}" global variable.
            declare -g    __BU_MODULE_INIT__ROOT_HOME='/tmp';
            declare -g -i __bu_module_init__root_home__lineno="$(( LINENO - 1 ))";

            # Creating the framework's temporary folder to store the temporary files generated by the initializer script.
            mkdir -p "${__BU_MODULE_INIT__ROOT_HOME}/.Bash-utils/${__BU_MODULE_INIT__TMP_DIR_NAME}" > /dev/null || {
                mkdir -p "${__BU_MODULE_INIT__ROOT_HOME}/.Bash-utils/${__BU_MODULE_INIT__TMP_DIR_NAME}" || {
                    echo "ERROR : PLEASE LAUNCH THIS SCRIPT WITH SUPER-USER PRIVILEGES, OR CHECK YOUR PERMISSIONS ON THE « ${__BU_MODULE_INIT__ROOT_HOME} » DIRECTORY";
                }

                declare -g __BU_MODULE_INIT__ROOT_HOME="${HOME}";
            }

            BU.ModuleInit.FindPath "${__BU_MODULE_INIT__ROOT_HOME}" ".Bash-utils" && {
                declare -g -i __bu_module_init__root__lineno="$(( LINENO + 4 ))";

                declare -g \
                __BU_MODULE_INIT__ROOT;

                __BU_MODULE_INIT__ROOT="$(BU.ModuleInit.FindPath "/${__BU_MODULE_INIT__ROOT_HOME}/.Bash-utils" "${__BU_MODULE_INIT__TMP_DIR_NAME}" 'd')" || {
                    printf \
                        "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
                        "$(basename \
                            "${BASH_SOURCE[0]}")" \
                        "${__bu_module_init__root__lineno}" \
                        '$__BU_MODULE_INIT__ROOT';

                    BU.ModuleInit.Exit 1;

                    return "${?}";
                };
            };

        else
            BU.ModuleInit.FindPath "${__BU_MODULE_INIT__ROOT_HOME}" ".Bash-utils" && {
                declare -g -i __bu_module_init__root__lineno="$(( LINENO + 4 ))";

                declare -g \
                __BU_MODULE_INIT__ROOT;
                
                __BU_MODULE_INIT__ROOT="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__ROOT_HOME}/.Bash-utils" "${__BU_MODULE_INIT__TMP_DIR_NAME}" 'd')" || {
                    printf \
                        "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
                        "$(basename \
                            "${BASH_SOURCE[0]}")" \
                        "${__bu_module_init__root__lineno}" \
                        '$__BU_MODULE_INIT__ROOT';

                    BU.ModuleInit.Exit 1;

                    return "${?}";
                };
            };
        fi
    fi

    #~ ~~~~~~~~~~~~~~~~~~~
    #~ TEMPORARY DIRECTORY
    #~ ~~~~~~~~~~~~~~~~~~~

    if [ ! -d "${__BU_MODULE_INIT__ROOT}/${__BU_MODULE_INIT__TMP_DIR_NAME}" ]; then mkdir -p "${__BU_MODULE_INIT__ROOT}/${__BU_MODULE_INIT__TMP_DIR_NAME}"; fi

    declare -g -i __bu_module_init__tmp_dir_path__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__TMP_DIR_PATH;
    
    __BU_MODULE_INIT__TMP_DIR_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__ROOT}" "${__BU_MODULE_INIT__TMP_DIR_NAME}" 'd')" || {
        printf \
            "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
            "$(basename \
                "${BASH_SOURCE[0]}")" \
            "${LINENO}" \
            '$__BU_MODULE_INIT__TMP_DIR_PATH';

        BU.ModuleInit.Exit 1;

        return "${?}";
    };

    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ CONFIGURATIONS DIRECTORIES
    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~

    # Configurations directory path
    declare -g -i __bu_module_init__config_dir_parent__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_DIR_PARENT="${__BU_MODULE_INIT__ROOT}";

    declare -g -i __bu_module_init__config_dir_name__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_DIR_NAME='config';

    declare -g -i __bu_module_init__config_dir_path__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__CONFIG_DIR_PATH;
    
    __BU_MODULE_INIT__CONFIG_DIR_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__CONFIG_DIR_PARENT}" "${__BU_MODULE_INIT__CONFIG_DIR_NAME}" 'd')" || {
        printf \
            "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
            "$(basename \
                "${BASH_SOURCE[0]}")" \
            "${LINENO}" \
            '$__BU_MODULE_INIT__CONFIG_DIR_PATH';

        BU.ModuleInit.Exit 1; return "${?}";
    };

    # Module's initializer script directory path
    declare -g -i __bu_module_init__config_init_dir_parent__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_INIT_DIR_PARENT="${__BU_MODULE_INIT__CONFIG_DIR_PATH}";

    declare -g -i __bu_module_init__config_init_dir_name__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_INIT_DIR_NAME='initializer';

    declare -g -i __bu_module_init__config_init_dir_path__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__CONFIG_INIT_DIR_PATH;
    
    __BU_MODULE_INIT__CONFIG_INIT_DIR_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__CONFIG_INIT_DIR_PARENT}" "${__BU_MODULE_INIT__CONFIG_INIT_DIR_NAME}" 'd')" || {
        printf \
            "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
            "$(basename \
                "${BASH_SOURCE[0]}")" \
            "${LINENO}" \
            '$__BU_MODULE_INIT__CONFIG_INIT_DIR_PATH';

        BU.ModuleInit.Exit 1;

        return "${?}";
    };

    # Modules configurations directory
    declare -g -i __bu_module_init__config_modules_dir_parent__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_MODULES_DIR_PARENT="${__BU_MODULE_INIT__CONFIG_DIR_PATH}";

    declare -g -i __bu_module_init__config_modules_dir_name__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_MODULES_DIR_NAME='modules';

    declare -g -i __bu_module_init__config_modules_dir_path__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__CONFIG_MODULES_DIR_PATH;
    
    __BU_MODULE_INIT__CONFIG_MODULES_DIR_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__CONFIG_MODULES_DIR_PARENT}" "${__BU_MODULE_INIT__CONFIG_MODULES_DIR_NAME}" 'd')" || {
        printf \
            "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
            "$(basename \
                "${BASH_SOURCE[0]}")" \
            "${LINENO}" \
            '$__BU_MODULE_INIT__CONFIG_MODULES_DIR_PATH';

        BU.ModuleInit.Exit 1; return "${?}";
    };

    # Translation files for the initializer script + the main module config and init files
    declare -g -i __bu_module_init__config_init_lang_dir_parent__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PARENT="${__BU_MODULE_INIT__CONFIG_INIT_DIR_PATH}";

    declare -g -i __bu_module_init__config_init_lang_dir_name__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_NAME='locale';

    declare -g -i __bu_module_init__config_init_lang_dir_path__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH;
    
    __BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PARENT}" "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_NAME}" 'd')" || {
        printf \
            "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
            "$(basename \
                "${BASH_SOURCE[0]}")" \
            "${LINENO}" \
            '$__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH';

        BU.ModuleInit.Exit 1;

        return "${?}";
    };

    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ INITIALIZER SCRIPT'S CONFIGURATION FILES
    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    declare -g -i __bu_module_init__config_init_dir__status__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__CONFIG_INIT_DIR__STATUS;
    
    __BU_MODULE_INIT__CONFIG_INIT_DIR__STATUS="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__CONFIG_INIT_DIR_PATH}" "Status.conf" 'f')" || {
        printf \
            "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
            "$(basename \
                "${BASH_SOURCE[0]}")" \
            "${LINENO}" \
            '$__BU_MODULE_INIT__CONFIG_INIT_DIR__STATUS';

        BU.ModuleInit.Exit 1;

        return "${?}";
    };

    #~ ~~~~~~~~~~~~~~~~~~~
    #~ MODULES DIRECTORIES
    #~ ~~~~~~~~~~~~~~~~~~~

    declare -g -i __bu_module_init__modules_dir__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__MODULES_DIR;
    
    __BU_MODULE_INIT__MODULES_DIR="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__ROOT}" "modules" 'd')" || {
        printf "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
            "$(basename \
                "${BASH_SOURCE[0]}")" \
            "${LINENO}" \
            '$__BU_MODULE_INIT__MODULES_DIR';

        BU.ModuleInit.Exit 1;

        return "${?}";
    };

    #~ ~~~~~~~~~~~~~
    #~ MODULES FILES
    #~ ~~~~~~~~~~~~~

    declare -g -i __bu_module_init__config_init_dir__aliases_conf__parent__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__MODULES_DIR__ALIASES_CONF__PARENT="${__BU_MODULE_INIT__CONFIG_MODULES_DIR_PATH}";

    # DO NOT FILL A VALUE TO THE "${__BU_MODULE_INIT__MODULES_DIR__ALIASES_CONF__NAMES/PATH}" GLOBAL VARIABLES HERE, IT WILL BE DONE IN THE "BashUtils_InitModules()" FUNCTION.
    declare -g -i __bu_module_init__config_init_dir__aliases_conf__name__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__MODULES_DIR__ALIASES_CONF__NAMES=();

    declare -g -i __bu_module_init__config_init_dir__aliases_conf__path__lineno="$(( LINENO + 2 ))";

    declare -g    __BU_MODULE_INIT__MODULES_DIR__ALIASES_CONF__PATH="";


    declare -g -i __bu_module_init__config_init_dir__aliases_conf__parent__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__MODULES_DIR__ALIASES_OS_CONF__PARENT="${__BU_MODULE_INIT__CONFIG_MODULES_DIR_PATH}";


    # DO NOT FILL A VALUE TO THE "${__BU_MODULE_INIT__MODULES_DIR__ALIASES_OS_CONF__NAMES/PATH}" GLOBAL VARIABLES HERE, IT WILL BE DONE IN THE "BashUtils_InitModules()" FUNCTION.
    declare -g -i __bu_module_init__config_init_dir__aliases_conf__name__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__MODULES_DIR__ALIASES_OS_CONF__NAMES=();

    declare -g -i __bu_module_init__config_init_dir__aliases_conf__path__lineno="$(( LINENO + 2 ))";

    declare -g    __BU_MODULE_INIT__MODULES_DIR__ALIASES_OS_CONF__PATH="";

    #~ ~~~~~~~~~~~
    #~ OTHER FILES
    #~ ~~~~~~~~~~~

    # Creating a global variable for storing the instruction not to stop the script if the "${__BU_MODULE_INIT__LIB_ROOT_DIR__FILE_PATH}" is not found, since a super-user privileged version exists.
    declare -g    __BU_MODULE_INIT__TMP_VAR__FIND_PATH_FUNC_NO_ERR='no-err';

    declare -g    __BU_MODULE_INIT__LIB_ROOT_DIR__FILE_NAME="Bash-utils-root-val.path";
    declare -g -i __bu_module_init__lib_root_dir__file_name__lineno="$(( LINENO - 1 ))";

    declare -g    __BU_MODULE_INIT__LIB_ROOT_DIR_FILE__PARENT_DIR="${__BU_MODULE_INIT__ROOT}";
    declare -g -i __bu_module_init__lib_root_dir_file__parent_dir__lineno="$(( LINENO - 1 ))";

    # Path to the framework's library root directory
    declare -g -i __bu_module_init__lib_root_dir__file_path__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__LIB_ROOT_DIR__FILE_PATH;
    
    __BU_MODULE_INIT__LIB_ROOT_DIR__FILE_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__LIB_ROOT_DIR_FILE__PARENT_DIR}" "${__BU_MODULE_INIT__LIB_ROOT_DIR__FILE_NAME}" 'f')" || {
        printf \
            "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
            "$(basename \
                "${BASH_SOURCE[0]}")" \
            "${LINENO}" \
            '$__BU_MODULE_INIT__MODULES_DIR';

        BU.ModuleInit.Exit 1;

        return "${?}";
    };

    unset __BU_MODULE_INIT__TMP_VAR__FIND_PATH_FUNC_NO_ERR;

    if [ -z "${__BU_MODULE_INIT__LIB_ROOT_DIR__FILE_PATH}" ]; then
        declare -g    __BU_MODULE_INIT__LIB_ROOT_DIR_ROOT__FILE_NAME="Bash-utils-root-val-ROOT.path";
        declare -g -i __bu_module_init__lib_root_dir_root__file_name__lineno="$(( LINENO - 1 ))";

        declare -g    __BU_MODULE_INIT__LIB_ROOT_DIR_ROOT_FILE_PARENT_DIR="${__BU_MODULE_INIT__ROOT}";
        declare -g -i __bu_module_init__lib_root_dir_root_file__parent_dir__lineno="$(( LINENO - 1 ))";

        declare -g -i __bu_module_init__lib_root_dir_root__file_path__lineno="$(( LINENO + 4 ))";

        declare -g \
        __BU_MODULE_INIT__LIB_ROOT_DIR_ROOT__FILE_PATH;
        
        __BU_MODULE_INIT__LIB_ROOT_DIR_ROOT__FILE_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__LIB_ROOT_DIR_ROOT_FILE_PARENT_DIR}" "${__BU_MODULE_INIT__LIB_ROOT_DIR_ROOT__FILE_NAME}" 'f')" || {
            printf \
                "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
                "$(basename \
                    "${BASH_SOURCE[0]}")" \
                "${LINENO}" \
                '$__BU_MODULE_INIT__MODULES_DIR';

            BU.ModuleInit.Exit 1;

            return "${?}";
        };
    fi

    #~ ~~~~
    #~ MISC
    #~ ~~~~

    # Storing the "false" value in the variable whose purpose is to check via the "BU.ModuleInit.IsTranslated()"
    # function if the framework's main module is translated thanks to the CSV file parser.
    declare -g    __BU_MODULE_INIT__BU_BASE_IS_TRANSLATED="false";
    declare -g -i __bu_module_init__bu_base_is_translated__lineno="$(( LINENO - 1 ))";

    declare -g    __BU_MODULE_INIT__CSV_TRANSLATION_FILE__DELIM=',';
    declare -g -i __bu_module_init__csv_translation_file__delim__lineno="$(( LINENO - 1 ))";

    declare -g -i __bu_module_init__date_log__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__DATE_LOG;
    
    __BU_MODULE_INIT__DATE_LOG="[ $(date +"%Y-%m-%d %H:%M:%S") ]";

    # If you want to use another language than your system's, please redefine the "${LANG}" environment variable before sourcing this initialization file.
    declare -g -i __bu_module_init__user_lang__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__USER_LANG;

    __BU_MODULE_INIT__USER_LANG="$(echo "${LANG}" | cut -d _ -f1)";

    # Array of allowed values for the "${__BU_MODULE_INIT_STAT_DEBUG_BASHX}" global variable
    declare -g -i __bu_module_init__bashx_debug_vals_array__lineno="$(( LINENO + 2 ))";

    declare -g \
    __BU_MODULE_INIT__BASHX_DEBUG_VALS_ARRAY=('C' 'cs' 'cat' 'cats' 'categ' 'categs' 'category' 'categorie' 'categories' \
                                              'fi' 'fil' 'fils' 'fis'  'file' 'files' \
                                              'FN' 'FNC' 'FNCS' 'FNS' 'FNCT' 'FNCTS' \
                                              'fun' 'funs' 'func' 'funcs' 'funct' 'functs' 'function' 'functions' \
                                              'M' 'ms' 'mod' 'mods' 'module' 'modules' \
                                              'S' 'ss' 'sub' 'subs' 'subc' 'subcs' 'subcat'  'subcats' 'subcateg'  'subcategs'  'subcategory'  'subcategorie'  'subcategories' \
                                              'sc' 'scs' 'scat' 'scats' 'scateg' 'scategs' 'scategory'  'scategorie' 'scategories' \
                                              's-'  's-s' 's-c' 's-cs' 's-cat' 's-cats' 's-categ' 's-categs' 's-category' 's-categorie' 's-categories' \
                                              'sub-' 'sub-s' 'sub-c' 'sub-cs' 'sub-cat' 'sub-cats' 'sub-categ' 'sub-categs' 'sub-category' 'sub-categorie' 'sub-categories');
    return 0;
}

## ==============================================

## FUNCTIONS NEEDED FOR THE TRANSLATIONS OF MESSAGES BEFORE THE INCLUSION OF THE TRANSLATION FILES.

# ················································································································
# NOTE : In the functions with embedded translations, only the languages spoken by more than 100 million people in
# the world (according to this website : https://lingua.edu/the-20-most-spoken-languages-in-the-world-in-2022/)
# will be embedded, as well as a few extra languages, in order to avoid bloating the initializer script with
# thousands and thousands of lines of hard-coded messages.

# ·····································································································································································································
# Printing the message called in the "BU.ModuleInit.IsInScript()" function, which tells the user that the Bash Utils framework cannot tell if its code is executed from a file or an interactive shell.

# WARNING : Do not call the "BU.ModuleInit.Msg()" function into this function, as this function is called into the "BU.ModuleInit.Msg()" function via the "BU.ModuleInit.Exit()" function.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   - echo		|
#	- local		|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.PrintIsInScriptEnvironmentErrorMessage()
{
    #**** Variables ****
    local v_isPrinted;  # VAR TYPE : Bool   - DESC : Checks if one of the languages supported by the "Bash-utils-init.sh" file was found on the user's system and that the translated message was printed.
    local v__userLang;  # VAR TYPE : String - DESC : Stores the IS0 639-1 code of the language currently used by the framework.

    #**** Code ****
    v__userLang="$(echo "${LANG}" | cut -d _ -f1)";

#    [ "${v__userLang,,}" == 'ar' ] && echo "يرجى تشغيل كود إطار عمل Bash-utils من ملف Bash المصدر ، أو تحقق من العملية الرئيسية" >&2 && v_isPrinted='true';
    [ "${v__userLang,,}" == 'de' ] && echo "Bitte führen Sie den bash-utils-Framework-Code aus der bash-Quelldatei aus oder überprüfen Sie den Hauptprozess" >&2 && v_isPrinted='true';
    [ "${v__userLang,,}" == 'en' ] && echo "Please run the Bash-utils framework's code from a Bash source file, or check the parent process" >&2 && v_isPrinted='true';

    [ "${v__userLang,,}" == 'es' ] && echo "Por favor, ejecute el código del framework bash-utils desde el archivo fuente bash o compruebe el proceso principal" >&2 && v_isPrinted='true';
    [ "${v__userLang,,}" == 'fr' ] && echo "Veuillez exécuter le code du framework Bash Utils à partir d'un fichier source Bash ou vérifier le processus parent" >&2 && v_isPrinted='true';
    [ "${v__userLang,,}" == 'hi' ] && echo "कृपया बैश स्रोत फ़ाइल से बैश-यूटिल्स फ्रेमवर्क का कोड चलाएं, या मूल प्रक्रिया की जांच करें" >&2 && v_isPrinted='true';

    [ "${v__userLang,,}" == 'id' ] && echo "Jalankan kode kerangka kerja Bash-utils dari berkas sumber Bash atau periksa proses utama" >&2 && v_isPrinted='true';
    [ "${v__userLang,,}" == 'ja' ] && echo "Bash ソース ファイルから Bash-utils フレームワーク コードを実行するか、親プロセスを確認します。" >&2 && v_isPrinted='true';
    [ "${v__userLang,,}" == 'ko' ] && echo "Bash 소스 파일에서 Bash-utils 프레임워크 코드를 실행하거나 기본 프로세스를 확인하십시오." >&2 && v_isPrinted='true';

    [ "${v__userLang,,}" == 'pt' ] && echo "Execute o código da estrutura Bash-utils a partir do ficheiro fonte do Bash ou verifique o processo principal" >&2 && v_isPrinted='true';
    [ "${v__userLang,,}" == 'ru' ] && echo "Пожалуйста, запустите код фреймворка « Bash-utils » из исходного файла « Bash » или проверьте родительский процесс" >&2 && v_isPrinted='true';
    [ "${v__userLang,,}" == 'tr' ] && echo "Lütfen Bash-utils çerçevesinin kodunu bir Bash kaynak dosyasından çalıştırın veya ana işlemi kontrol edin" >&2 && v_isPrinted='true';

    [ "${v__userLang,,}" == 'uk' ] && echo "Будь ласка, запустіть код фреймворку « Bash-utils » з вихідного файлу « Bash » або перевірте батьківський процес" >&2 && v_isPrinted='true';
    [ "${v__userLang,,}" == 'zh' ] && echo "请从 Bash 源文件运行 Bash-utils 框架的代码，或者检查父进程" >&2 && v_isPrinted='true';

    [ "${v_isPrinted}" != 'true' ] && echo "Please run the Bash-utils framework's code from a Bash source file, or check the parent process" >&2;

    echo >&2;
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### INITIALIZER RESOURCES - OTHER FUNCTIONS

## CORE FUNCTIONS

# ·······························
# Defining the framework's traps.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   - echo  |
#   - trap	|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.DefineTraps()
{
    BU.ModuleInit.IsTranslated; local __v="${?}"; echo "Translated : ${__v}"

    #**** Variables ****
    if ! BU.ModuleInit.IsTranslated; then
        # If the string variables are not defined from translation files' by the time the trap is called, their message will be displayed in English for everyone.

        declare -g __BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGHUP;         # VAR TYPE : String     - DESC :
        declare -g __BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGINT;         # VAR TYPE : String     - DESC :
        declare -g __BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGSTP;         # VAR TYPE : String     - DESC :
        declare -g __BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGTERM;        # VAR TYPE : String     - DESC :
        declare -g __BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGTRAP;        # VAR TYPE : String     - DESC :

        # Defining strings variables.
        __BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGHUP="Terminal closure detected (HUP)";
        __BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGINT="Interrupted by the user (Ctrl+C)";
        __BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGSTP="Manual pause (Ctrl+Z)";
        __BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGTERM="Termination signal received (TERM)";
        __BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGTRAP="SIGTRAP signal received";
    fi

    #**** Code ****

    # Defining traps.
    trap 'BU.ModuleInit.Exit 0' EXIT;
    trap 'printf "\n[HUP] %s" "${__BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGHUP}"' SIGHUP;
    trap 'printf "\n[INT] %s" "${__BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGINT}"; BU.ModuleInit.Exit 2' SIGINT;
    # trap 'printf "\n[TSTP] %s\n" "${__BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGSTP}"; kill -STOP ${$}' SIGSTP;
    trap 'printf "\n[TERM] %s" "${__BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGTERM}"' SIGTERM;
    trap 'printf "\n[] %s" "${__BU_MODULE_INIT_MSG__DEFINE_TRAPS__SIGTRAP}"' SIGTRAP;
}

# ····················································································································································
# Stopping the execution of the framework in case an error occurs, after printing an error message, according to the way the main script was executed.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   - exit		|
#	- local		|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.IsInScript()                        -> Modules initializer script (this file)


# shellcheck disable=
function BU.ModuleInit.Exit()
{
    #**** Variables ****
    local p_code=${1:-1};
    
    #***** Code *****
    BU.ModuleInit.IsInScript && exit "${p_code}";
    
    return "${p_code}";
}

# ··································································································································································································
# Checking if the function and / or sourced code currently executed is a part of a script file (with the "${BASH_SOURCE}" variable) or running in an interactive shell (with the "${PS1}" variable).

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   - local	|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.PrintIsInScriptEnvironmentErrorMessage() -> Modules initializer script (this file)


# shellcheck disable=
function BU.ModuleInit.IsInScript()
{
    #**** Code ****
    if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
        return 1;
    elif [[ -n "$BASH_VERSION" ]]; then
        return 0;
    else
        BU.ModuleInit.PrintIsInScriptEnvironmentErrorMessage;

        return 255;
    fi
}

# ·····················································································
# Checking if the framework's features are translated to another language than English.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   -

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.IsTranslated()                   { if [ "${__BU_MODULE_INIT__BU_BASE_IS_TRANSLATED,,}" == 'true' ]; then return 0; else return 1; fi }



## ==============================================

## MODULES ENGINE'S FUNCTIONS



## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### BEGINNING OF THE INITIALIZATION PROCESS

## CHECKING IF THE CURRENT SHELL IS BASH

if [ -z "${BASH_VERSION}" ]; then
    lang=$(echo "${LANG}" | cut -d_ -f1)

    case "${lang}" in
        de)
            echo "BASH-UTILS FEHLER: Ihre aktuelle Shell ist nicht « Bash », sondern « ${SHELL##*/} »." >&2 ;;
        en)
            echo "BASH-UTILS ERROR: Your current shell interpreter is not « Bash », but « ${SHELL##*/} »." >&2 ;;
        es)
            echo "ERROR DE BASH-UTILS: Su intérprete de shell actual no es « Bash », sino « ${SHELL##*/} »." >&2 ;;
        fr)
            echo "ERREUR BASH-UTILS : Votre interpréteur actuel n’est pas « Bash », mais « ${SHELL##*/} »." >&2 ;;
        hi)
            echo "BASH-UTILS त्रुटि: आपका वर्तमान शेल इंटरप्रेटर « Bash » नहीं है, बल्कि « ${SHELL##/} » है" >&2 ;;
        id)
            echo "KESALAHAN BASH-UTILS: Shell Anda saat ini bukan « Bash », melainkan « ${SHELL##*/} »." >&2 ;;
        ja)
            echo "BASH-UTILS エラー: 現在のシェルインタプリタは「Bash」ではなく、「${SHELL##/}」です。" >&2 ;;
        ko)
            echo "BASH-UTILS 오류: 현재 셸 인터프리터는 Bash가 아니라 ${SHELL##/}입니다." >&2 ;;
        pt)
            echo "ERRO DO BASH-UTILS : O seu interpretador de shell não é o « Bash », mas sim o « ${SHELL##/} »" >&2 ;;
        ru)
            echo "ОШИБКА BASH-UTILS: Текущий интерпретатор оболочки — не « Bash », а « ${SHELL##*/} »." >&2 ;;
        tr)
            echo "BASH-UTILS HATASI: Mevcut kabuk yorumlayıcınız « Bash » değil, « ${SHELL##/} »." >&2 ;;
        uk)
            echo "ПОМИЛКА BASH-UTILS: Поточний інтерпретатор — не « Bash », а « ${SHELL##*/} »." >&2 ;;
        zh)
            echo "BASH-UTILS 错误：你当前的 shell 解释器不是「Bash」，而是「${SHELL##/}」。" >&2 ;;
        *)
            echo "BASH-UTILS ERROR: This script requires Bash, but you are using « ${SHELL##*/} »." >&2 ;;
    esac

    echo >&2;

    # WARNING : Do not call the "BU.ModuleInit.AskPrintLog()" function here, this code is executed before the initialization of the "${__BU_MODULE_INIT_MSG_ARRAY[@]}" array.

    # Handling the situation where the code is executed from a script or when this file is included in the user's prompt.
    case "${0}" in
        -*)
            # Si "${0}" commence par un tiret, c'est probablement un shell interactif
            return 1 2>/dev/null;
            ;;
        *)
            # Si ce script est exécuté directement, on fait un exit
            [ "$(basename -- "${0}")" != "sh" ] && exit 1
            
            return 1 2>/dev/null;
            ;;
    esac
fi

## ==============================================

## STARTING A TIMER IN ORDER TO CHECK THE INITIALIZATION PROCESS'S TIME

# Do not assign any value here now, it will be done at the end of the framework's initialization process.
declare -i __BU_MODULE_INIT__FRAMEWORK_INITIALIZATION_PROCESS_TIMER;

## ==============================================

## CHECKING THE VERSION OF BASH CURRENTLY USED TO EXECUTE THE FRAMEWORK

# Checking the version of the Bash language currently used on the user's system.
BU.ModuleInit.CheckBashMinimalVersion || BU.ModuleInit.Exit 1;

## ==============================================

## CALLING THE TRAPS RESOURCES

BU.ModuleInit.DefineTraps;

sleep 5

echo "STOP TEST"; exit 0;

## ==============================================

## DEFINING GLOBAL VARIABLES



# Calling the function previously defined, or else the global variables will not be declared.
BU.ModuleInit.DefineBashUtilsGlobalVariablesBeforeInitializingTheModules;

## ==============================================

## CALLING THE NEEDED FUNCTIONS (DEFINED IN THIS FILE) THAT MUST BE CALLED BEFORE INITIALIZING THE FIRST GLOBAL VARIABLES

# THE "BU.ModuleInit.GetModuleInitLanguage()" FUNCTION MUST BE THE FIRST FUNCTION TO BE CALLED !!!!

# Since this function gets the language currently used by the system, if you want to change the language, you just have to define
# a new value to the "${LANG}" environment variable before calling the "BashUtils_InitModules()" function in your main script file.

# Setting the whole project's language by getting and sourcing the "gettext.sh" file.

# If the framework is compiled, then you should call the "Bash-utils-${language}.sh" file which corresponds to the language that you want to use.
BU.ModuleInit.IsFrameworkCompiledLocalized || {
    if [ "${__BU_MODULE_INIT__USER_LANG,,}" != 'en' ]; then
        BU.ModuleInit.GetModuleInitLanguage "${__BU_MODULE_INIT__USER_LANG}" || { BU.ModuleInit.Exit 1; return "${?}"; };
    fi
}

#
declare -g __BU_MODULE_INIT_IS_TRANSLATION_FILES_SOURCED='true';

## ==============================================

## DEFINING NEW GLOBAL VARIABLES TO STORE THE INITIALIZATION LOGS AND DISPLAY THEM OR NO

# NOTE : The redirections are processed by the "BU.ModuleInit.Msg" function.

# This global variable stores the log messages.
declare -a -g __BU_MODULE_INIT_MSG_ARRAY=();

# This global variables stores a random text. It's enough to determine if the messages can be printed and / or stored in the "${__BU_MODULE_INIT_MSG_ARRAY" array with the "BU.ModuleInit.Msg" function.
declare -g __BU_MODULE_INIT_MSG_ARRAY_EXISTS="$((RANDOM % 255))";

# This global variable stores the processing mode (partial or full).

# By default, it stores the '--mode-log-partial' value, in order to avoid the initialization process being too much verbose.
declare -g __BU_MODULE_INIT_MSG_ARRAY_MODE='--mode-log-partial';

# This global variable stores the value (given in the "BashUtils_InitModules()" function's main loop)
# which authorizes the displaying of the logs messages on the screen.

# By default, it stores no value, so that the messages are redirected to the "${__BU_MODULE_INIT_MSG_ARRAY" only,
# without being redirected to the screen too (these instructions are processed in the "BU.ModuleInit.Msg" function).
declare -g __BU_MODULE_INIT_MSG_ARRAY_PERMISSION='';

## ==============================================

## CALLING THE OTHER FUNCTIONS FOR INITIALIZATION

# Writing the initialization content into the messages array. It will be displayed later on the screen if the « --log-init-display » argument is passed with the « module » argument.
__BU_MODULE_INIT_MSG_ARRAY+=("$(BU.ModuleInit.Msg "${__BU_MODULE_INIT_MSG__OUT_OF_FNCT__MSG_INITIALIZING_THE_MODULES}")");
__BU_MODULE_INIT_MSG_ARRAY+=("$(BU.ModuleInit.Msg)");

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### SOURCING THE MODULES

## INCLUSION OF LIBRARY FILES ACCORDING TO THE INCLUDED MODULE

# ············································································································································
# Please call immediately this function once this file is sourced, and pass it each module you need as arguments, and their supported options.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.Main.Decho.Decho.Function()                -> Main -> Decho.lib
#   - BU.Main.Decho.Decho.Highlight()               -> Main -> Decho.lib
#   - BU.Main.Decho.Decho.Path()                    -> Main -> Decho.lib

#   - BU.Main.Headers.Header.Green()                -> Main -> Headers.lib
#   - BU.Main.Headers.Header.Warning()              -> Main -> Headers.lib

#   - BU.Main.Status.ChangeSTAT_INITIALIZING()      -> Main -> Status.lib
#   - BU.Main.Status.CheckStatIsInitializing()      -> Main -> Status.lib

#   - BU.ModuleInit.AskPrintLog()                   -> Modules initializer script (this file)
#   - BU.ModuleInit.Exit()                          -> Modules initializer script (this file)
#   - BU.ModuleInit.IsInScript()                    -> Modules initializer script (this file)
#   - BU.ModuleInit.Msg()                           -> Modules initializer script (this file)


# shellcheck disable=SC1090
function BashUtils_InitModules()
{

    #**** Pre-initialization processing ****
    if [ -n "${__BU_MODULE_INIT_IS_SOURCED}" ] && [ "sourced" == "${__BU_MODULE_INIT_IS_SOURCED}" ]; then
        # shellcheck disable=SC2059
        BU.Main.Headers.Header.Warning \
            "$(printf "${__BU_MODULE_INIT_MSG__BU_IM__IS_ALREADY_CALLED}\n" \
                "$(BU.Main.Decho.Decho.Function \
                    "${FUNCNAME[0]}")")";

        return 1;
    fi

    #**** Parameters ****
    local p_modules_list=("${@}");    # List of all the modules to include passed as arguments

	#**** Variables (global) ****

	#**** Variables (local) ****

	#**** Code ****
	# Checking if the arguments array length is equal to zero (no arguments passed).
	if [ -z "${p_modules_list[*]}" ]; then local lineno="${LINENO}";
        # shellcheck disable=SC2059
		printf "${__BU_MODULE_INIT_MSG__BU_IM__MUST_PASS_A_MODULE_NAME}\n\n" "$(basename "${BASH_SOURCE[0]}")" "${lineno}" "${FUNCNAME[0]}" >&2;

        BU.ModuleInit.AskPrintLog || { BU.ModuleInit.Exit 1; return "${?}"; };

        BU.ModuleInit.Exit 1;

        return "${?}";
	fi

    # Writing the list of the installed modules.
	__BU_MODULE_INIT_MSG_ARRAY+=("$(BU.ModuleInit.Msg "${__BU_MODULE_INIT_MSG__BU_IM__MODULES_INIT_MSG}")");
	__BU_MODULE_INIT_MSG_ARRAY+=("$(BU.ModuleInit.Msg)");

    # Listing the included modules.
	for module_args in "${p_modules_list[@]}"; do
        i=0; # Module's array index incrementer.

        if [[ "${module_args,,}" == 'module --'* ]]; then
            # shellcheck disable=SC2059
            __BU_MODULE_INIT_MSG_ARRAY+=("$(BU.ModuleInit.Msg "$(printf "${__BU_MODULE_INIT_MSG__BU_IM__MODULES_INIT_MSG__LOOP_ADD_ARRAY_INDEX__IS_MODULE_PARAM}" "${i}" "${module_args}")")");
        else
            i="$(( i + 1 ))" # Incrementing the module's array index

            # Name and arguments of the module stored as the nth index of the module list array.

            # shellcheck disable=SC2059
            __BU_MODULE_INIT_MSG_ARRAY+=("$(BU.ModuleInit.Msg "$(printf "${__BU_MODULE_INIT_MSG__BU_IM__MODULES_INIT_MSG__LOOP_ADD_ARRAY_INDEX__IS_NOT_MODULE_PARAM}" "${i}" "${module_args}")")");
        fi
	done

	__BU_MODULE_INIT_MSG_ARRAY+=("$(BU.ModuleInit.Msg)");
	__BU_MODULE_INIT_MSG_ARRAY+=("$(BU.ModuleInit.Msg)");

	# The modules initialization's main process was moved into the "BashUtils_InitModules._()" function, in order ease the access of its functionnalities from any module initializer function.
    BashUtils_InitModules._ "${p_modules_list[@]}" || {
        BU.ModuleInit.Exit 1;

        return "${?}";
    };

	# Sourcing the user defined aliases file if the library is directly used from a script file.
	if ! BU.ModuleInit.IsInScript && [ -f "${__BU_MAIN_PROJECT_ALIAS_FILE_PATH}" ] && [ -n "${__BU_MAIN_PROJECT_ALIAS_FILE_PATH}" ]; then BU.Main.Files.SourceFile "${__BU_MAIN_PROJECT_ALIAS_FILE_PATH}" || return 1; fi

	# /////////////////////////////////////////////////////////////////////////////////////////////// #

	#### ENDING THE WHOLE INITIALIZATION PROCESS

	# shellcheck disable=SC2059
	BU.Main.Headers.Header.Green "$(printf "${__BU_MODULE_INIT_MSG__BU_IM__END_OF_FRAMEWORK_INIT}" "$(BU.Main.Decho.Decho.Highlight "${__BU_MAIN_PROJECT_NAME}")" "$(BU.Main.Decho.Decho.Path "${__BU_MAIN_PROJECT_FILE_PATH}" "${__BU_MAIN_COLOR_TXT_PATH}")")";

	# This is the ONLY line where the "${__BU_MAIN_STAT_INITIALIZING}" global status variable's value can be modified.
	# DO NOT set it anymore to "true", or else your script can be prone to bugs.
    if  BU.Main.Status.CheckStatIsInitializing; then
        BU.Main.Status.ChangeSTAT_INITIALIZING "false" "$(basename "${BASH_SOURCE[0]}")" "${LINENO}" || return 1;
	fi

	# Note : the "${__BU_MODULE_INIT_MSG_ARRAY" variable is purged from the logged messages after writing its content in the project's log file.

	# Setting a global variable that prevent a new call of this function.
	__BU_MODULE_INIT_IS_SOURCED='sourced';

	# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	# Backupping a message variable in case the current function is called again, in order to display again the same error message after unsetting every initialization message variables.
	# local var_backup="${__BU_MODULE_INIT_MSG__BU_IM__IS_ALREADY_CALLED}";

	# ---------------------------------------------------------------------------------
	# Unsetting every initialization message variables in order to free up some memory.

	# DO NOT DOUBLE QUOTE THE COMMAND SUBSTITUTION !!!!!

	# shellcheck disable=SC2046
	# unset $(compgen -v "__BU_MODULE_INIT_MSG__");

	# ---------------------------------------------------------------------------
	# Resetting the "${__BU_MODULE_INIT_MSG__BU_IM__IS_ALREADY_CALLED}" variable.
	# __BU_MODULE_INIT_MSG__BU_IM__IS_ALREADY_CALLED="${var_backup}";

    # Defining a function which is to be used to check if the framework is already sourced, in order to avoid too many checkings in the very beginning of any script that uses this framework, and a new inclusion of the framework's files.

    # Just write this line at the beginning of your script : "x="$(IsInBUFramework)"; if [ "${x^^}" != 'BU' ]; then".

    # After the 'then', call the "BashUtils_InitModules()" with it's mandatory arguments, and then your wanted arguments.
    if ! BU.ModuleInit.IsInScript; then function IsInBUFramework() { echo "BU"; return 0; }; fi

	return 0;
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #
