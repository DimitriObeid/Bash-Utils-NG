# ---------------------
# FILE'S INFORMATIONS :

# Name          : Bash-utils-init.sh
# Author(s)     : Dimitri OBEID
# Version       : Beta 0.2-NG


# --------------------
# FILE'S DESCRIPTION :

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
# -----------------------------------------------------------



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### INITIALIZER RESOURCES - FUNCTIONS REQUIRED TO INITIALIZE AND CONFIGURE MODULE ENGINE

## BASH VERSION HANDLING

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

## ==============================================

## RUNTIME'S CORE CONFIGURATION

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

    # Default location : "${HOME}"
    declare -g    __BU_MODULE_INIT__ROOT_HOME="${HOME}";
    declare -g -i __bu_module_init__root_home__lineno="$(( LINENO - 1 ))";

    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ STORING THE NAME OF THE FRAMEWORK'S TEMPORARY DIRECTORY
    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    # Default name : "tmp"
    declare -g    __BU_MODULE_INIT__TMP_DIR_NAME="tmp";
    declare -g -i __bu_module_init__tmp_dir_name__lineno="$(( LINENO - 1 ))";

    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ FINDING THE ".Bash-utils" FOLDER
    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    # If the framework base is not being installed on the user's hard drive, the ".Bash-utils" folder has to be found in its defined path (default path : ${HOME}).
    if ! BU.ModuleInit.IsFrameworkBeingInstalled; then

        # If the ".Bash-utils" folder does not exists in its defined parent directory.
        if [ ! -d "${__BU_MODULE_INIT__ROOT_HOME}/.Bash-utils" ]; then
            # TODO : Check if the framework is compiled and when the translation variables will be created, use them if the former conditon is true.
            BU.ModuleInit.PrintErrorMissingBashUtilsHomeFolder "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" "$(( LINENO - 1 ))";

            # WARNING : Do not call the "BU.ModuleInit.AskPrintLog()" function here, the current function is defined before the "${__BU_MODULE_INIT_MSG_ARRAY" array.
            BU.ModuleInit.Exit 1;

            return "${?}";

        # Else, if the ".Bash-utils" folder exists in its defined parent directory,
        # then the ".Bash-utils" default parent folder is defined as the user's home directory.
        else
            declare -g -i __bu_module_init__root__lineno="$(( LINENO + 4 ))";

            declare -g \
            __BU_MODULE_INIT__ROOT;

            # No need to call the "BU.ModuleInit.CheckPathIntegrity()" function, as at this point, the ".Bash-utils" folder MUST exist, or else these lines of code would not be executed.
            __BU_MODULE_INIT__ROOT="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__ROOT_HOME}" ".Bash-utils")";

            # If the base code of the framework is not compiled in a single file.
            if ! BU.ModuleInit.IsFrameworkCompiled; then
                # shellcheck disable=SC2034
                declare -g __bu_module_init__initializer_path__lineno="$(( LINENO + 5 ))";

                declare -g \
                __BU_MODULE_INIT__INITIALIZER_PATH;

                # Since the "Bash-utils-init.sh" script has to be found to be executed, the verification of the integrity of its path is not necessary. 
                __BU_MODULE_INIT__INITIALIZER_PATH="$(BU.ModuleInit.FindPath "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" "$(basename "${BASH_SOURCE[0]}")")";
            fi
        fi

    # Else, if the ".Bash-utils" folder doesn't exists in its defined parent directory AND the framework base is being installed on the user's hard drive,
    # then the ".Bash-utils" default parent folder is defined as the "/tmp" folder in the system root directory. This redefinition is important for the next path variables' values.
    else
        # Checking if the ".Bash-utils" folder does not exists in the user's home directory.
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

            #
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

                echo "__BU_MODULE_INIT__ROOT : ${__BU_MODULE_INIT__ROOT}"
            };

        else
            #
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

    declare -g -i __bu_module_init__tmp_dir_path__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__TMP_DIR_PATH;

    __BU_MODULE_INIT__TMP_DIR_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__ROOT}" "${__BU_MODULE_INIT__TMP_DIR_NAME}")";

    # Since the "${__BU_MODULE_INIT__TMP_DIR_PATH}" folder might not exist, the "BU.ModuleInit.CheckPathIntegrity()" function must not be called here, and the folder must be created.
    if [ ! -d "${__BU_MODULE_INIT__ROOT}/${__BU_MODULE_INIT__TMP_DIR_NAME}" ]; then
        mkdir -p -v "${__BU_MODULE_INIT__ROOT}/${__BU_MODULE_INIT__TMP_DIR_NAME}";    
    fi

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

    __BU_MODULE_INIT__CONFIG_DIR_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__CONFIG_DIR_PARENT}" "${__BU_MODULE_INIT__CONFIG_DIR_NAME}")";

    BU.ModuleInit.CheckPathIntegrity    "${__BU_MODULE_INIT__CONFIG_DIR_PATH}" "${?}" \
                                        "$(basename "${BASH_SOURCE[0]}")" \
                                        "${FUNCNAME[0]}" \
                                        "${__bu_module_init__config_dir_path__lineno}" \
                                        || return "${?}";

    # Module's initializer script directory path
    declare -g -i __bu_module_init__config_init_dir_parent__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_INIT_DIR_PARENT="${__BU_MODULE_INIT__CONFIG_DIR_PATH}";

    declare -g -i __bu_module_init__config_init_dir_name__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_INIT_DIR_NAME='initializer';

    declare -g -i __bu_module_init__config_init_dir_path__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__CONFIG_INIT_DIR_PATH;
    
    __BU_MODULE_INIT__CONFIG_INIT_DIR_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__CONFIG_INIT_DIR_PARENT}" "${__BU_MODULE_INIT__CONFIG_INIT_DIR_NAME}")"

    BU.ModuleInit.CheckPathIntegrity    "${__BU_MODULE_INIT__CONFIG_INIT_DIR_PATH}" "${?}" \
                                        "$(basename "${BASH_SOURCE[0]}")" \
                                        "${FUNCNAME[0]}" \
                                        "${__bu_module_init__config_init_dir_path__lineno}" \
                                        || return "${?}";

    # Translation files for the initializer script + the main module config and init files
    declare -g -i __bu_module_init__config_init_lang_dir_parent__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PARENT="${__BU_MODULE_INIT__CONFIG_INIT_DIR_PATH}";

    declare -g -i __bu_module_init__config_init_lang_dir_name__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_NAME='locale';

    declare -g -i __bu_module_init__config_init_lang_dir_path__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH;
    
    __BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PARENT}" "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_NAME}")";

    BU.ModuleInit.CheckPathIntegrity    "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH}" "${?}" \
                                        "$(basename "${BASH_SOURCE[0]}")" \
                                        "${FUNCNAME[0]}" \
                                        "${__bu_module_init__config_init_lang_dir_path__lineno}" \
                                        || return "${?}";

    # Modules configurations directory
    declare -g -i __bu_module_init__config_modules_dir_parent__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_MODULES_DIR_PARENT="${__BU_MODULE_INIT__CONFIG_DIR_PATH}";

    declare -g -i __bu_module_init__config_modules_dir_name__lineno="$(( LINENO + 1 ))";
    declare -g    __BU_MODULE_INIT__CONFIG_MODULES_DIR_NAME='modules';

    declare -g -i __bu_module_init__config_modules_dir_path__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__CONFIG_MODULES_DIR_PATH;
    
    __BU_MODULE_INIT__CONFIG_MODULES_DIR_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__CONFIG_MODULES_DIR_PARENT}" "${__BU_MODULE_INIT__CONFIG_MODULES_DIR_NAME}")";

    BU.ModuleInit.CheckPathIntegrity    "${__BU_MODULE_INIT__CONFIG_MODULES_DIR_PATH}" "${?}" \
                                        "$(basename "${BASH_SOURCE[0]}")" \
                                        "${FUNCNAME[0]}" \
                                        "${__bu_module_init__config_modules_dir_path__lineno}" \
                                        || return "${?}";

    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ INITIALIZER SCRIPT'S CONFIGURATION FILES
    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    # Path to the "Status.conf" file, which contains the global status variables used by the modules initializer.
    declare -g -i __bu_module_init__config_init_dir__status__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__CONFIG_INIT_DIR__STATUS;
    
    __BU_MODULE_INIT__CONFIG_INIT_DIR__STATUS="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__CONFIG_INIT_DIR_PATH}" "Status.conf")";

    BU.ModuleInit.CheckPathIntegrity    "${__BU_MODULE_INIT__CONFIG_INIT_DIR__STATUS}" "${?}" \
                                        "$(basename "${BASH_SOURCE[0]}")" \
                                        "${FUNCNAME[0]}" \
                                        "${__bu_module_init__config_init_dir__status__lineno}" \
                                        || return "${?}";

    #~ ~~~~~~~~~~~~~~~~~~~
    #~ MODULES DIRECTORIES
    #~ ~~~~~~~~~~~~~~~~~~~

    declare -g -i __bu_module_init__modules_dir__lineno="$(( LINENO + 4 ))";

    declare -g \
    __BU_MODULE_INIT__MODULES_DIR;
    
    __BU_MODULE_INIT__MODULES_DIR="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__ROOT}" "modules")";

    BU.ModuleInit.CheckPathIntegrity    "${__BU_MODULE_INIT__MODULES_DIR}" "${?}" \
                                        "$(basename "${BASH_SOURCE[0]}")" \
                                        "${FUNCNAME[0]}" \
                                        "${__bu_module_init__modules_dir__lineno}" \
                                        || return "${?}";

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
    
    __BU_MODULE_INIT__LIB_ROOT_DIR__FILE_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__LIB_ROOT_DIR_FILE__PARENT_DIR}" "${__BU_MODULE_INIT__LIB_ROOT_DIR__FILE_NAME}")";

    BU.ModuleInit.CheckPathIntegrity    "${__BU_MODULE_INIT__LIB_ROOT_DIR__FILE_PATH}" "${?}" \
                                        "$(basename "${BASH_SOURCE[0]}")" \
                                        "${FUNCNAME[0]}" \
                                        "${__bu_module_init__lib_root_dir__file_path__lineno}" \
                                        || return "${?}";

    unset __BU_MODULE_INIT__TMP_VAR__FIND_PATH_FUNC_NO_ERR;

    # if [ -z "${__BU_MODULE_INIT__LIB_ROOT_DIR__FILE_PATH}" ]; then
    #     declare -g    __BU_MODULE_INIT__LIB_ROOT_DIR_ROOT__FILE_NAME="Bash-utils-root-val-ROOT.path";
    #     declare -g -i __bu_module_init__lib_root_dir_root__file_name__lineno="$(( LINENO - 1 ))";

    #     declare -g    __BU_MODULE_INIT__LIB_ROOT_DIR_ROOT_FILE_PARENT_DIR="${__BU_MODULE_INIT__ROOT}";
    #     declare -g -i __bu_module_init__lib_root_dir_root_file__parent_dir__lineno="$(( LINENO - 1 ))";

    #     declare -g -i __bu_module_init__lib_root_dir_root__file_path__lineno="$(( LINENO + 4 ))";

    #     declare -g \
    #     __BU_MODULE_INIT__LIB_ROOT_DIR_ROOT__FILE_PATH;
        
    #     __BU_MODULE_INIT__LIB_ROOT_DIR_ROOT__FILE_PATH="$(BU.ModuleInit.FindPath "${__BU_MODULE_INIT__LIB_ROOT_DIR_ROOT_FILE_PARENT_DIR}" "${__BU_MODULE_INIT__LIB_ROOT_DIR_ROOT__FILE_NAME}" 'f')" || {
    #         printf \
    #             "${__BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT}" \
    #             "$(basename \
    #                 "${BASH_SOURCE[0]}")" \
    #             "${LINENO}" \
    #             '$__BU_MODULE_INIT__MODULES_DIR';

    #         BU.ModuleInit.Exit 1;

    #         return "${?}";
    #     };
    # fi

    #~ ~~~~
    #~ MISC
    #~ ~~~~

    # Storing the "false" value in the variable whose purpose is to check via the "BU.ModuleInit.IsFrameworkTranslated()"
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



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### INITIALIZER RESOURCES - MULTILINGUAL MANAGEMENT AND TRANSLATIONS

## LANGUAGE DETECTION

# ················································································································
# NOTE : In the functions with embedded translations, only the languages spoken by more than 100 million people in
# the world (according to this website : https://lingua.edu/the-20-most-spoken-languages-in-the-world-in-2022/)
# will be embedded, as well as a few extra languages, in order to avoid bloating the initializer script with
# thousands and thousands of lines of hard-coded messages.

# ····························································································································
# Rewriting the library's languages messages (this function MUST NOT be called if the framework is compiled in a single file).

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#	- echo		|
#	- local		|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.SetInitLocale."${__BU_MODULE_INIT__USER_LANG}"()    -> Modules initializer script's locale files ("config/initializer/locale/${__BU_MODULE_INIT__USER_LANG}.locale").

#   - BU.ModuleInit.GetModuleInitLanguage_RestOfLibrary()               -> Modules initializer script (this file)
#   - BU.ModuleInit.IsFrameworkCompiled()                               -> Modules initializer script (this file)
#   - BU.ModuleInit.SourceEnglishTranslationFiles()                     -> Modules initializer script (this file)


# shellcheck disable=SC1091,SC1090
function BU.ModuleInit.GetModuleInitLanguage()
{
    #**** Parameters ****
    local p_lang_ISO_639_1=${1:-NULL};  # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : Wanted language.

    #**** Variables ****
    local v_betaLang;       # VAR TYPE : Array      - DESC : Array of languages whose support is not yet fully implemented.
    local v_supportedLang;  # VAR TYPE : Array      - DESC : Array of languages whose support is fully implemented.
    local v_langMatch;      # VAR TYPE : String     - DESC :
    local v_langMatchBeta;  # VAR TYPE : String     - DESC :

    local v_isPrinted;      # VAR TYPE : Bool       - DESC : Checks if one of the languages supported by the "Bash-utils-init.sh" file was found on the user's system and that the translated message was printed.

    #**** Code ****
    v_isPrinted='false';

    v_betaLang=('bg' 'cs' 'da' 'de' 'el' 'es' 'et' 'fi' 'hu' 'id' 'it' 'ja' 'lt' 'lv' 'nl' 'pl' 'pt' 'ro' 'ru' 'sk' 'sl' 'sv' 'tr' 'uk' 'zh');
    v_supportedLang=('en' 'fr');

    [[ ${v_supportedLang[*]}    =~ ${p_lang_ISO_639_1,,} ]] && v_langMatch="match";
    [[ ${v_betaLang[*]}         =~ ${p_lang_ISO_639_1,,} ]] && v_langMatchBeta="matchBeta";

    # If the selected language was not found among the supported languages.
    if [ -z "${v_langMatch}" ] && [ -z "${v_langMatchBeta}" ]; then
        if [ -n "${p_lang_ISO_639_1}" ]; then
#            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ar' ] && echo "" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'de' ] && echo "WARNUNG : Die von Ihnen gewählte Sprache (${p_lang_ISO_639_1,,}) wird (noch) nicht vom Initialisierungsskript unterstützt" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'en' ] && echo "WARNING : Your selected language (${p_lang_ISO_639_1,,}) is not (yet) supported by the initialisation script" >&2 && v_isPrinted='true';
            
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'es' ] && echo "ADVERTENCIA : El idioma seleccionado (${p_lang_ISO_639_1,,}) no está soportado (todavía) por el script de inicialización" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'fr' ] && echo "ATTENTION : La langue sélectionnée (${p_lang_ISO_639_1,,}) n'est pas (encore) supportée par le script d'initialisation" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'hi' ] && echo "चेतावनी: आपकी चयनित भाषा (${p_lang_ISO_639_1,,}) प्रारंभिक स्क्रिप्ट द्वारा समर्थित (अभी तक) नहीं है" >&2 && v_isPrinted='true';

            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'id' ] && echo "PERINGATAN: Bahasa yang Anda pilih (${p_lang_ISO_639_1,,}) tidak (belum) didukung oleh skrip inisialisasi" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ja' ] && echo "警告 選択された言語（${p_lang_ISO_639_1,,}）は、初期化スクリプトでは（まだ）サポートされていません。" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ko' ] && echo "경고: 선택한 언어(${p_lang_ISO_639_1,,})는 초기화 스크립트에서 아직 지원되지 않습니다." >&2 && v_isPrinted='true';

            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'pt' ] && echo "AVISO : A sua língua seleccionada (${p_lang_ISO_639_1,,}) não é (ainda) suportada pelo guião de inicialização" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ru' ] && echo "ВНИМАНИЕ : Выбранный вами язык (${p_lang_ISO_639_1,,}) не поддерживается (пока) скриптом инициализации" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'tr' ] && echo "UYARI: Seçtiğiniz dil (${p_lang_ISO_639_1,,}) başlangıç komut dosyası tarafından (henüz) desteklenmemektedir." >&2 && v_isPrinted='true';

            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'uk' ] && echo "ПОПЕРЕДЖЕННЯ: вибрана вами мова (${p_lang_ISO_639_1,,}) ще не підтримується скриптом ініціалізації" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'zh' ] && echo "警告： 您选择的语言（${p_lang_ISO_639_1,,}）还不被初始化脚本支持。" >&2 && v_isPrinted='true';

            [ "${v_isPrinted}" != 'true' ] && echo "WARNING : Your selected language (${p_lang_ISO_639_1,,}) is not (yet) supported by the initialisation script" >&2;
        else
#            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ar' ] && echo "" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'de' ] && echo "WARNUNG : Die derzeit von Ihrem Betriebssystem verwendete Sprache (${__BU_MODULE_INIT__USER_LANG,,}) wird (noch) nicht vom Initialisierungsskript unterstützt" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'en' ] && echo "WARNING : The language currently used by your operating system (${__BU_MODULE_INIT__USER_LANG,,}) is not (yet) supported by the initialisation script" >&2 && v_isPrinted='true';
            
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'es' ] && echo "ADVERTENCIA : El idioma utilizado actualmente por su sistema operativo (${__BU_MODULE_INIT__USER_LANG,,}) no es (todavía) soportado por el script de inicialización" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'fr' ] && echo "ATTENTION : La langue actuellement utilisée par votre système d'exploitation (${__BU_MODULE_INIT__USER_LANG,,}) n'est pas (encore) supportée par le script d'initialisation" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'hi' ] && echo "चेतावनी: आपकी वर्तमान भाषा (${__BU_MODULE_INIT__USER_LANG,,}) प्रारंभिक स्क्रिप्ट द्वारा समर्थित (अभी तक) नहीं है" >&2 && v_isPrinted='true';

            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'id' ] && echo "PERINGATAN: Bahasa yang saat ini digunakan oleh sistem operasi Anda (${__BU_MODULE_INIT__USER_LANG ,,}) tidak (belum) didukung oleh skrip inisialisasi" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ja' ] && echo "警告 オペレーティングシステムが現在使用している言語（${__BU_MODULE_INIT__USER_LANG,,}）は、初期化スクリプトでは（まだ）サポートされていません。" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ko' ] && echo "경고: 현재 운영 체제에서 사용 중인 언어(${__BU_MODULE_INIT__USER_LANG})는 초기화 스크립트에서 아직 지원되지 않습니다." >&2 && v_isPrinted='true';

            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'pt' ] && echo "AVISO: O idioma actualmente utilizado pelo seu sistema operativo (${__BU_MODULE_INIT__USER_LANG,,}) não é (ainda) suportado pelo script de arranque" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ru' ] && echo "ВНИМАНИЕ: Язык, используемый в настоящее время вашей операционной системой (${__BU_MODULE_INIT__USER_LANG,,}), не поддерживается (пока) сценарием загрузки" >&2 && v_isPrinted='true';           
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'tr' ] && echo "UYARI: Mevcut diliniz (${__BU_MODULE_INIT__USER_LANG,,}) başlangıç komut dosyası tarafından (henüz) desteklenmemektedir." >&2 && v_isPrinted='true';

            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'uk' ] && echo "ПОПЕРЕДЖЕННЯ: Мова, яку наразі використовує ваша операційна система (${__BU_MODULE_INIT__USER_LANG,,}), ще не підтримується скриптом ініціалізації" >&2 && v_isPrinted='true';
            [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'zh' ] && echo "警告： 您当前的语言（${__BU_MODULE_INIT__USER_LANG,,}）不被初始化脚本所支持。" >&2 && v_isPrinted='true';

            [ "${v_isPrinted}" != 'true' ] && echo "WARNING : Your current language (${__BU_MODULE_INIT__USER_LANG,,}) is not (yet) supported by the initialisation script" >&2;
        fi; echo >&2;

        # Setting the value of the "${v_isPrinted}" variable to "false" in order to ensure that the following messages will be printed in English if one of the following messages would be missing.
        v_isPrinted='false';

#        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ar' ] && echo "" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'de' ] && echo "Das Initialisierungsskript wird Englisch als Standardsprache verwenden." >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'en' ] && echo "The initialisation script will use English as default language" >&2 && v_isPrinted='true';
        
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'es' ] && echo "El script de inicialización utilizará el inglés como idioma por defecto" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'fr' ] && echo "Le script d'initialisation utilisera l'anglais en tant que langue par défaut" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'hi' ] && echo "प्रारंभिक लिपि अंग्रेजी को डिफ़ॉल्ट भाषा के रूप में उपयोग करेगी।" >&2 && v_isPrinted='true';

        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'id' ] && echo "Skrip inisialisasi akan menggunakan bahasa Inggris sebagai bahasa default" >&2 && v_isPrinted='true';        
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ja' ] && echo "初期化スクリプトでは、デフォルトの言語としてenglishを使用します。" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ko' ] && echo "초기화 스크립트는 기본 언어로 영어를 사용합니다." >&2 && v_isPrinted='true';

        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'pt' ] && echo "O guião de inicialização utilizará o inglês como língua padrão" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ru' ] && echo "Скрипт инициализации будет использовать английский язык в качестве языка по умолчанию" >&2 && v_isPrinted='true';        
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'tr' ] && echo "Başlangıç komut dosyası varsayılan dil olarak İngilizceyi kullanacaktır." >&2 && v_isPrinted='true';

        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'uk' ] && echo "Скрипт ініціалізації буде використовувати англійську мову як мову за замовчуванням" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'zh' ] && echo "初始化脚本将使用英语作为默认语言。" >&2 && v_isPrinted='true';

        [ "${v_isPrinted}" != 'true' ] && echo "The initialisation script will use English as default language" >&2;

        echo >&2;

        # Changing the current language to English.
        LANG="en_US.UTF-8";

        __BU_MODULE_INIT__USER_LANG="${LANG%%_*}";

        # Setting the value of the "${v_isPrinted}" variable to "false" in order to ensure that the following messages will be printed in English if one of the following messages would be missing.
        v_isPrinted='false';

    # Else, if the selected language's translation file is still in a Beta version.
    elif [ -z "${v_langMatch}" ] && [ -n "${v_langMatchBeta}" ]; then

        #**** Conditional variables ****
        local a; # ARG TYPE : String    - DESC : Shorter name for the "${__BU_MODULE_INIT__USER_LANG}" global variable.
        local b; # ARG TYPE : String    - DESC : Shorter name for the "${p_lang_ISO_639_1}" local variable.

        #**** Conditional code ****
        a="${__BU_MODULE_INIT__USER_LANG,,}";
        b="${p_lang_ISO_639_1}";

        # Setting the value of the "${v_isPrinted}" variable to "false" in order to ensure that the following messages will be printed in English if one of the following messages would be missing.
        v_isPrinted='false';

        [ "${a}" == "ar" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: الملف اللغوي الذي حددته (%s) لا يزال في مرحلة تجريبية.\n" "${b}.locale" >&2; } || \
                { printf "INFO: معلومات: ملف اللغة المحدد وفقًا لإعدادات نظام التشغيل الخاص بك (%s) لا يزال في مرحلة تجريبية.\n" "${b}.locale" >&2; };
            }
            echo "قد يحتوي هذا الملف على ترجمات غير دقيقة ونصوص غير كاملة وأخطاء مطبعية، لذا يوصى باستخدام هذه الترجمة بحذر.";
            v_isPrinted='true';
        };
        [ "${a}" == "de" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: Die von Ihnen ausgewählte Übersetzungsdatei (%s) befindet sich noch in der Beta-Phase.\n" "${b}.locale" >&2; } || \
                { printf "INFO: Die gemäß den Einstellungen Ihres Betriebssystems ausgewählte Übersetzungsdatei (%s) befindet sich noch in der Beta-Phase.\n" "${b}.locale" >&2; };
            }
            echo "Diese Datei kann fehlerhafte Übersetzungen, fehlende Texte und Tippfehler enthalten. Verwenden Sie diese Übersetzung mit Vorsicht." >&2;
            v_isPrinted='true';
        };
        [ "${a}" == "en" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: The language file you selected (%s) is still in a Beta version.\n" "${b}.locale" >&2; } || \
                { printf "INFO: The language file selected according to your operating system's settings (%s) is still in a Beta version.\n" "${b}.locale" >&2; };
            }
            echo "This file may contain incorrect translations, incomplete text, and typographical errors, so it is recommended that you use this translation with caution." >&2
            v_isPrinted='true';
        };
        [ "${a}" == "es" ] && {
            [ -n "${b}" ] && {
                { printf "INFORMACIÓN: El archivo de traducción que ha seleccionado (%s) aún se encuentra en fase beta.\n" "${b}.locale" >&2; } || \
                { printf "INFO: El archivo de idioma seleccionado según la configuración de su sistema operativo (%s) aún está en versión Beta.\n" "${b}.locale" >&2; };
            }
            echo "Este archivo puede contener traducciones incorrectas, texto incompleto y errores tipográficos, por lo que se recomienda utilizar esta traducción con precaución." >&2;
            v_isPrinted='true';
        };
        [ "${a}" == "fr" ] && {
            [ -n "${b}" ] && {
                { printf "INFO : Le fichier de traduction que vous avez sélectionné (%s) est toujours en version Beta.\n" "${b}.locale" >&2; } || \
                { printf "INFO : Le fichier de traduction sélectionné selon les paramètres de votre système d'exploitation (%s) est toujours en version Beta.\n" "${b}.locale" >&2; };
            }
            echo "Ce fichier peut contenir des traductions incorrectes, du texte incomplet et des erreurs typographiques. Il est donc recommandé de l'utiliser avec prudence." >&2;
            v_isPrinted='true';
        };
        [ "${a}" == "hi" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: आपके द्वारा चुनी गई भाषा फ़ाइल (%s) अभी भी बीटा में है\n" "${b}.locale" >&2; } || \
                { printf "INFO: आपके ऑपरेटिंग सिस्टम सेटिंग्स (%s) के अनुसार चुनी गई भाषा फ़ाइल अभी भी बीटा संस्करण में है\n" "${b}.locale" >&2; };
            }
            echo "इस फ़ाइल में गलत अनुवाद, अधूरा पाठ और मुद्रण संबंधी त्रुटियाँ हो सकती हैं, इसलिए यह अनुशंसा की जाती है कि आप इस अनुवाद का उपयोग सावधानी से करें" >&2;
            v_isPrinted='true';
        };
        [ "${a}" == "id" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: Berkas bahasa yang Anda pilih (%s) masih dalam versi Beta.\n" "${b}.locale" >&2; } || \
                { printf "INFO: Berkas bahasa yang dipilih sesuai dengan pengaturan sistem operasi Anda (%s) masih dalam versi Beta.\n" "${b}.locale" >&2; };
            }
            echo "Berkas ini mungkin mengandung terjemahan yang tidak akurat, teks yang tidak lengkap, dan kesalahan ketik, jadi disarankan agar Anda menggunakan terjemahan ini dengan hati-hati." >&2;
            v_isPrinted='true';
        };
        [ "${a}" == "ja" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: 選択された言語ファイル（%s）は現在ベータ版です。\n" "${b}.locale" >&2; } || \
                { printf "INFO: 選択された言語ファイル（%s）は、お使いのオペレーティングシステムの設定に基づいて選択されましたが、まだベータ版です。\n" "${b}.locale" >&2; };
            }
            echo "このファイルには、誤った翻訳、不完全なテキスト、およびタイプミスが含まれている可能性があります。したがって、この翻訳を使用する際は注意が必要です。" >&2;
            v_isPrinted='true';
        };
        [ "${a}" == "ko" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: 선택하신 언어 파일 (%s)은 아직 베타 단계에 있습니다.\n" "${b}.locale" >&2; } || \
                { printf "INFO: 운영 체제 설정(%s)에 따라 선택한 언어 파일은 여전히 베타 버전입니다.\n" "${b}.locale" >&2; };
            }
            echo "이 파일에는 잘못된 번역, 불완전한 텍스트 및 타자 오류가 포함될 수 있으므로 주의하여 사용하시기 바랍니다.";
        };
        [ "${a}" == "pt" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: O ficheiro de idioma que selecionou (%s) ainda está na versão Beta.\n" "${b}.locale" >&2; } || \
                { printf "INFO: O ficheiro de idioma selecionado de acordo com as configurações do seu sistema operativo (%s) ainda está na versão Beta.\n" "${b}.locale" >&2; };
            }
            echo "Este ficheiro pode conter traduções incorretas, texto incompleto e erros tipográficos, por isso recomenda-se que utilize esta tradução com cautela." >&2;
            v_isPrinted='true';
        };
        [ "${a}" == "ru" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: Выбранный вами языковой файл (%s) все еще находится в стадии бета-тестирования.\n" "${b}.locale" >&2; } || \
                { printf "INFO: Языковой файл, выбранный в соответствии с настройками вашей операционной системы (%s), все еще находится в стадии бета-тестирования.\n" "${b}.locale" >&2; };
            }
            echo "Этот файл может содержать неверные переводы, неполный текст и типографские ошибки, поэтому рекомендуется использовать этот перевод с осторожностью." >&2;
            v_isPrinted='true';
        };
        [ "${a}" == "tr" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: Seçtiğiniz dil dosyası (%s) hala Beta sürümündedir.\n" "${b}.locale" >&2; } || \
                { printf "INFO: İşletim sistemi ayarlarınıza göre seçilen dil dosyası (%s) hala Beta sürümündedir.\n" "${b}.locale" >&2; };
            }
            echo "Bu dosya yanlış çeviriler, eksik metinler ve yazım hataları içerebilir, bu nedenle bu çeviriyi dikkatli kullanmanız önerilir." >&2;
            v_isPrinted='true';
        };
        [ "${a}" == "uk" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: Вибраний вами мовний файл (%s) все ще перебуває в бета-версії.\n" "${b}.locale" >&2; } || \
                { printf "INFO: Мовний файл, вибраний відповідно до налаштувань вашої операційної системи (%s), все ще перебуває в бета-версії.\n" "${b}.locale" >&2; };
            }
            echo "Цей файл може містити некоректні переклади, неповний текст та друкарські помилки, тому рекомендуємо використовувати цей переклад з обережністю." >&2;
            v_isPrinted='true';
        };
        [ "${a}" == "zh" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: 您选择的语言文件（%s）目前仍处于测试版阶段。\n" "${b}.locale" >&2; } || \
                { printf "INFO: 根据您的操作系统设置（%s）选择的语言文件仍处于测试阶段。\n" "${b}.locale" >&2; };
            }
            echo "本文件可能包含不准确的翻译、不完整的文本及排版错误，因此我们建议您在使用本翻译时务必谨慎。" >&2;
            v_isPrinted='true';
        };
        [ "${v_isPrinted,,}" != "true" ] && {
            [ -n "${b}" ] && {
                { printf "INFO: The language file you selected (%s) is still in a Beta version.\n" "${b}.locale" >&2; } || \
                { printf "INFO: The language file selected according to your operating system's settings (%s) is still in a Beta version.\n" "${b}.locale" >&2; };
            }
            echo "This file may contain incorrect translations, incomplete text, and typographical errors, so it is recommended that you use this translation with caution." >&2
        };

        v_isPrinted='false';

        echo >&2;
    fi

	if [ "${p_lang_ISO_639_1^^}" == 'NULL' ]; then
#        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ar' ] && echo "" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'de' ] && echo "ACHTUNG : Keine Sprache wird als Argument angegeben, wenn die Funktion « ${FUNCNAME[0]}() » aufgerufen wird" >&2 && v_isPrinted='true';
		[ "${__BU_MODULE_INIT__USER_LANG,,}" == 'en' ] && echo "WARNING : No language specified as argument when calling the « ${FUNCNAME[0]}() » function" >&2 && v_isPrinted='true';
		
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'es' ] && echo "ADVERTENCIA : No se especifica ningún idioma como argumento al llamar a la función « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
		[ "${__BU_MODULE_INIT__USER_LANG,,}" == 'fr' ] && echo "ATTENTION : Aucune langue spécifiée en argument lors de l'appel de la fonction « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'hi' ] && echo "चेतावनी: फंक्शन « ${FUNCNAME[0]}() » कॉल करते समय तर्क के रूप में कोई भाषा निर्दिष्ट नहीं की गई है" >&2 && v_isPrinted='true';

        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'id' ] && echo "PERINGATAN: Tidak ada bahasa yang ditentukan sebagai argumen saat memanggil fungsi « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ja' ] && echo "WARNING : 「${FUNCNAME[0]}()」関数の呼び出し時に、引数として指定された言語がありません。" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ko' ] && echo "경고: 함수 « ${FUNCNAME[0]}() »를 호출할 때 인수로 지정된 언어가 없습니다." >&2 && v_isPrinted='true';

        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'pt' ] && echo "ATENÇÃO : Nenhuma língua especificada como argumento ao chamar a função « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ru' ] && echo "ВНИМАНИЕ : При вызове функции « ${FUNCNAME[0]}() » в качестве аргумента не указан язык" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'tr' ] && echo "UYARI: « ${FUNCNAME[0]}() » işlevi, argüman olarak bir dil belirtilmeden çağrılmıştır." >&2 && v_isPrinted='true';

        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'uk' ] && echo "ПОПЕРЕДЖЕННЯ : Мова не вказана як аргумент при виклику « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'zh' ] && echo "警告： 函数\"${FUNCNAME[0]}() \"的调用没有指定语言作为参数。" >&2 && v_isPrinted='true';

        [ "${v_isPrinted}" != 'true' ] && echo "WARNING : No language specified as argument when calling the « ${FUNCNAME[0]}() » function" >&2;

        echo >&2;

        # Setting the value of the "${v_isPrinted}" variable to "false" in order to ensure that the following messages will be printed in English if one of the following messages would be missing.
        v_isPrinted='false';

		BU.ModuleInit.GetModuleInitLanguage_RestOfLibrary || return 1;

    elif [ "${p_lang_ISO_639_1^^}" != 'NULL' ] && [ ! -f "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH}/${p_lang_ISO_639_1}.locale" ]; then
#		[ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ar' ] && echo "" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'de' ] && echo "ACHTUNG : Die Übersetzungsdatei für die Sprache, die beim Aufruf der Funktion « ${FUNCNAME[0]}() » als Argument angegeben wurde, konnte im Ordner « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} » nicht gefunden werden" >&2 && v_isPrinted='true';
		[ "${__BU_MODULE_INIT__USER_LANG,,}" == 'en' ] && echo "WARNING : The translation file for the language specified as an argument when calling the « ${FUNCNAME[0]}() » function was not found in the « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} » directory" >&2 && v_isPrinted='true';

		[ "${__BU_MODULE_INIT__USER_LANG,,}" == 'es' ] && echo "ADVERTENCIA : El archivo de traducción para el idioma especificado como argumento al llamar a la función « ${FUNCNAME[0]}() » no se encontró en el directorio « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} »" >&2 && v_isPrinted='true';
		[ "${__BU_MODULE_INIT__USER_LANG,,}" == 'fr' ] && echo "ATTENTION : Le fichier de traduction destiné à la langue spécifiée en argument lors de l'appel de la fonction « ${FUNCNAME[0]}() » n'a pas été trouvé dans le dossier « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} »" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'hi' ] && echo "चेतावनी: फ़ंक्शन को कॉल करते समय एक तर्क के रूप में निर्दिष्ट भाषा के लिए अनुवाद फ़ाइल « ${FUNCNAME[0]}() » डायरेक्टरी में नहीं मिली « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} »" >&2 && v_isPrinted='true';

        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'id' ] && echo "PERINGATAN: File terjemahan untuk bahasa yang ditentukan sebagai argumen saat memanggil fungsi « ${FUNCNAME[0]}() » tidak ditemukan di direktori « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} »" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ja' ] && echo "警告 : \" ${FUNCNAME[0]}() \" 関数呼び出しで引数として指定された言語の翻訳ファイルが \" ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} \" ディレクトリに見つかりませんでした." >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ko' ] && echo "경고: « ${FUNCNAME[0]}() » 함수를 호출할 때 인수로 지정된 언어의 번역 파일이 « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} » 디렉토리에서 발견되지 않았습니다." >&2 && v_isPrinted='true';

        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'pt' ] && echo "ATENÇÃO : O ficheiro de tradução para a língua especificada como argumento ao chamar a função « ${FUNCNAME[0]}() » não foi encontrado na pasta « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} »" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ru' ] && echo "ВНИМАНИЕ : Файл перевода для языка, указанного в качестве аргумента при вызове функции « ${FUNCNAME[0]}() » не найден в каталоге « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} »." >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'tr' ] && echo "UYARI: « ${FUNCNAME[0]}() » işlevini çağırırken argüman olarak belirtilen dilin çeviri dosyası « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} » dizininde bulunamadı." >&2 && v_isPrinted='true';

        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'uk' ] && echo "ПОПЕРЕДЖЕННЯ: Файл перекладу для мови, вказаної як аргумент під час виклику функції « ${FUNCNAME[0]}() », не знайдено у каталозі « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} »" >&2 && v_isPrinted='true';
        [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'zh' ] && echo "警告： 在调用\"${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH}\"目录中作为参数指定的语言翻译文件在\"${FUNCNAME[0]}() \"函数中没有找到。" >&2 && v_isPrinted='true';

        [ "${v_isPrinted}" != 'true' ] && echo "WARNING : The translation file for the language specified as an argument when calling the « ${FUNCNAME[0]}() » function was not found in the « ${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH} » directory" >&2;

        # Setting the value of the "${v_isPrinted}" variable to "false" in order to ensure that the following messages will be printed in English if one of the following messages would be missing.
        v_isPrinted='false';

        echo >&2;

        BU.ModuleInit.GetModuleInitLanguage_RestOfLibrary || return 1;

    else
        # Sourcing the English translation files first, since these files are the most supported, so that if new variables are added, no empty strings will be displayed if the next language files are not updated yet.
        BU.ModuleInit.SourceEnglishTranslationFiles "${__BU_MODULE_INIT__USER_LANG,,}" || return 1;

        # Sourcing the current language's translations file if the base of the framework is not compiled.
        BU.ModuleInit.IsFrameworkCompiled || {
            source "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH}/${p_lang_ISO_639_1}.locale" || {
#                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ar' ] && echo "" >&2 && v_isPrinted='true';
                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'de' ] && echo "ACHTUNG : Die Übersetzungsdatei für die als Argument angegebene Sprache konnte beim Aufruf der Funktion « ${FUNCNAME[0]}() » nicht gefunden werden." >&2 && v_isPrinted='true';
                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'en' ] && echo "WARNING : Unable to source the translation file for the language specified as argument when calling the « ${FUNCNAME[0]}() » function" >&2 && v_isPrinted='true';

                [ "${__BU_MODULE_INIT__USER_LANG,,}" == "es" ] && echo "ADVERTENCIA : No se ha podido obtener el archivo de traducción para el idioma especificado en el argumento al llamar a la función « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'fr' ] && echo "ATTENTION : Impossible de sourcer le fichier de traduction destiné à la langue spécifiée en argument lors de l'appel de la fonction « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'hi' ] && echo "चेतावनी: फंक्शन « ${FUNCNAME[0]}() » कॉल करते समय एक तर्क के रूप में निर्दिष्ट भाषा के लिए अनुवाद फ़ाइल को स्रोत करने में असमर्थ" >&2 && v_isPrinted='true';

                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'id' ] && echo "PERINGATAN: Tidak dapat menemukan file terjemahan untuk bahasa yang ditentukan sebagai argumen saat memanggil fungsi « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ja' ] && echo "WARNING : \"${FUNCNAME[0]}() \"関数呼び出しは、引数で指定された言語の翻訳ファイルをソースにできません。" >&2 && v_isPrinted='true';
                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ko' ] && echo "경고: 지정된 언어의 번역 파일이 발견되지 않았습니다. 이 문제는 « ${FUNCNAME[0]}() » 함수를 호출할 때 발생했습니다." >&2 && v_isPrinted='true';

                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'pt' ] && echo "ATENÇÃO : Não foi possível obter o ficheiro de tradução para a língua especificada como argumento ao chamar a função « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ru' ] && echo "ВНИМАНИЕ : Невозможно включить файл перевода для языка, указанного в качестве аргумента, при вызове функции « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'tr' ] && echo "UYARI: Belirtilen dil için çeviri dosyası bulunamadı. Bu sorun, « ${FUNCNAME[0]}() » işlevini çağırırken ortaya çıktı." >&2 && v_isPrinted='true';

                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'uk' ] && echo "ПОПЕРЕДЖЕННЯ: Не вдалося включити файл перекладу для мови, вказаної як аргумент під час виклику функції « ${FUNCNAME[0]}() »" >&2 && v_isPrinted='true';
                [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'zh' ] && echo "警告： 当调用\"${FUNCNAME[0]}() \"函数时，不可能为作为参数指定的语言提供翻译文件源。" >&2 && v_isPrinted='true';

                # If the language chosen by the user is not (yet) supported directly in this function, the message is displayed in English.
                [ "${v_isPrinted}" != 'true' ] && echo "WARNING : Unable to source the translation file for the language specified as argument when calling the « ${FUNCNAME[0]}() » function" >&2;

                echo >&2;

                BU.ModuleInit.GetModuleInitLanguage_RestOfLibrary || return 1;

                return 0;
            }
        }

        # Calling the function which defines every variables containing the translated messages.
        BU.ModuleInit.SetInitLocale."${__BU_MODULE_INIT__USER_LANG}" || return 1;

        return 0;
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
function BU.ModuleInit.IsInitializerTranslated()
{
    if [ "${__BU_MODULE_INIT_IS_TRANSLATION_FILES_SOURCED,,}" == 'true' ]; then
        return 0;
    else
        return 1;
    fi
}

# ················································································································
# NOTE : In the functions with embedded translations, only the languages spoken by more than 100 million people in
# the world (according to this website : https://lingua.edu/the-20-most-spoken-languages-in-the-world-in-2022/)
# will be embedded, as well as a few extra languages, in order to avoid bloating the initializer script with
# thousands and thousands of lines of hard-coded messages.

# ·····················································································
# Checking if the framework's features are translated to another language than English.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   -

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.IsFrameworkTranslated()
{
    if [ "${__BU_MODULE_INIT__BU_BASE_IS_TRANSLATED,,}" == 'true' ]; then
        return 0;
    else
        return 1;
    fi
}

## ==============================================

## PRE-FILE INCLUSION LOGIC

# ·························································································································································································
# Printing the message that warns the user that the rest of the framework will use english as default language (this function is not called if the framework is compiled in a single file).

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
# 	- echo		|
#	- local		|
#	- sleep		|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.GetModuleInitLanguage_SetEnglishAsDefaultLanguage()         -> Modules initializer script (this file)


# shellcheck disable=
function BU.ModuleInit.GetModuleInitLanguage_RestOfLibrary()
{
    #**** Variables ****
    local v_isPrinted; # VAR TYPE : Bool   - DESC : Checks if one of the languages supported by the "Bash-utils-init.sh" file was found on the user's system and that the translated message was printed.

    #**** Code ****
    echo '------------------------------------------------------------------------' >&2;
    echo >&2;

#    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ar' ] && echo "" >&2 && v_isPrinted='true';
    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'de' ] && echo "Der Rest der Bibliothek wird Englisch als Standardsprache verwenden" >&2 && v_isPrinted='true';
    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'en' ] && echo "The rest of the library will use English as default language" >&2 && v_isPrinted='true';
    
    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'es' ] && echo "El resto de la biblioteca utilizará el inglés como idioma por defecto" >&2 && v_isPrinted='true';
    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'fr' ] && echo "Le reste de la librairie utilisera l'anglais en tant que langue par défaut" >&2 && v_isPrinted='true';
    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'hi' ] && echo "बाकी पुस्तकालय अंग्रेजी को डिफ़ॉल्ट भाषा के रूप में उपयोग करेंगे।" >&2 && v_isPrinted='true';

    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'id' ] && echo "Seluruh perpustakaan akan menggunakan bahasa Inggris sebagai bahasa default" >&2 && v_isPrinted='true';
    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ja' ] && echo "ライブラリの残りの部分では、デフォルト言語として英語が使用されます。" >&2 && v_isPrinted='true';
    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ko' ] && echo "나머지 라이브러리는 영어를 기본 언어로 사용합니다." >&2 && v_isPrinted='true';

    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'pt' ] && echo "O resto da biblioteca utilizará o inglês como língua padrão" >&2 && v_isPrinted='true';
    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'ru' ] && echo "Остальная часть библиотеки будет использовать английский язык в качестве языка по умолчанию" >&2 && v_isPrinted='true';
    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'tr' ] && echo "Kütüphanenin geri kalanı için varsayılan dil olarak İngilizce kullanılacaktır." >&2 && v_isPrinted='true';

    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'uk' ] && echo "Решта бібліотеки буде використовувати англійську мову за замовчуванням" >&2 && v_isPrinted='true';
    [ "${__BU_MODULE_INIT__USER_LANG,,}" == 'zh' ] && echo "图书馆的其余部分将使用英语作为默认语言" >&2 && v_isPrinted='true';

    # If the language chosen by the user is not (yet) supported directly in this function, the message is displayed in English.
    [ "${v_isPrinted}" != 'true' ] && echo "The rest of the library will use English as default language" >&2;

    echo >&2;

    sleep 0.5;

    BU.ModuleInit.GetModuleInitLanguage_SetEnglishAsDefaultLanguage || return 1;

    return 0;
}

# ·········································································································································································································
# Set english as default language if an unsupported language is stored in the "${__BU_MODULE_INIT__USER_LANG}" global variable (this function is not called if the framework is compiled in a single file).

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#	- local	|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.SourceEnglishTranslationFiles()     -> Modules initializer script (this file)


# shellcheck disable=SC1090,SC1091
function BU.ModuleInit.GetModuleInitLanguage_SetEnglishAsDefaultLanguage()
{
    #**** Variables ****
    local v_lang_backup="${__BU_MODULE_INIT__USER_LANG}"; # VAR TYPE : ISO 639-1 code   - DESC : Backupping the former language used / chosen by the user.

    #**** Code ****

    # Changing the current language to English.
    LANG="en_US.UTF-8";

    __BU_MODULE_INIT__USER_LANG="${LANG%%_*}";

    BU.ModuleInit.SourceEnglishTranslationFiles "${v_lang_backup}" || return 1;

    return 0;
}

# ······························································································································
# Writing the error messages that , before the definition of the necessary variables for the inclusion of the translation files.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#	- cut		| (-d | -f1)
#	- echo		|
#	- local		|
#	- printf	|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.PrintErrorMissingBashUtilsHomeFolder()
{
    #**** Parameters ****
    local v_file=${1:-${BASH_SOURCE[0]}};   # ARG TYPE : String     - REQUIRED | DEFAULT VAL : "${BASH_SOURCE[0]}"  - DESC : File where the error happened.
    local v_func=${2:-${FUNCNAME[1]}};      # ARG TYPE : String     - REQUIRED | DEFAULT VAL : "${FUNCNAME[1]}"     - DESC : Function where the error happened.
    local v_line=${3:-${LINENO}};           # ARG TYPE : Int        - REQUIRED | DEFAULT VAL : "${LINENO}"          - DESC : Line where the error happened.

    #**** Variables ****
    local __bu_module_init__user_lang;      # VAR TYPE : ISO 639-1 Code     - DESC : Getting the language used / chosen by the user.
    local v_installFile;                    # VAR TYPE : File               - DESC : Name of the framework installation program.
    local v_isPrinted;                      # VAR TYPE : Bool               - DESC : Checks if one of the languages supported by the "Bash-utils-init.sh" file was found on the user's system and that the translated message was printed.

    #**** Code ****
    __bu_module_init__user_lang="$(echo "${LANG}" | cut -d _ -f1)";

    v_installFile='install_and_update.sh';

    echo >&2;

    # العربية | Arabic
#     [ "${__bu_module_init__user_lang,,}" == 'ar' ] && {
#         #**** Conditional variables ****
#         local v_ar_fatal_error;      # VAR TYPE : String     # DESC : Storing the Arabic fatal error string in order not to break the line's layout, nor the ">&2" redirection.
#         local v_ar_err_explain;      # VAR TYPE : String     # DESC : Storing the Arabic explanation string in order not to break the line's layout, nor the ">&2" redirection.
#         local v_ar_err_advices;      # VAR TYPE : String     # DESC : Storing the Arabic advices string in order not to break the line's layout, nor the ">&2" redirection.
#
#         #**** Conditonal code ****
#         v_ar_fatal_error="";
#         v_ar_err_explain="";
#         v_ar_err_advices="";
#
#         printf "${v_ar_fatal_error}" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;
#
#         echo "${v_ar_err_explain}" >&2; echo >&2;
#         echo "${v_ar_err_advices}" >&2;
#     }

    # Deutch | German
    [ "${__bu_module_init__user_lang,,}" == 'de' ] && {
        printf "IN DER DATEI « %s », AN DIE FUNKTION « %s », ZUR LINIE « %s », BASH-UTILS FATALER FEHLER :\n" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;

        echo "Der Stammordner des Bash-Utils-Konfigurationsverzeichnisses « .Bash-utils » existiert nicht in Ihrem Heimatverzeichnis" >&2; echo >&2;
        echo "Bitte kopieren Sie diesen Ordner in Ihr Home-Verzeichnis. Sie können es installieren, indem Sie die Datei « ${v_installFile} » ausführen, oder Sie können es im Verzeichnis « Bash-utils/install » finden" >&2;

        v_isPrinted='true';
    };

    # English
    [ "${__bu_module_init__user_lang,,}" == 'en' ] && {
        printf "IN « %s » FILE, AT « %s() » FUNCTION, ON LINE « %s » --> BASH-UTILS FATAL ERROR\n" "${v_file}" "${v_func}" "${v_line}">&2; echo >&2;

        echo "The Bash Utils framework's configurations root folder « .Bash-utils » doesn't exists in your home directory" >&2; echo >&2;
        echo "Please copy this folder into your home directory. You can install it by executing the « ${v_installFile} » file, or you can find it in the « Bash-utils/install » directory" >&2;
    };

    # Español | Spanish
    [ "${__bu_module_init__user_lang,,}" == 'es' ] && {
        printf "EN EL FICHERO « %s », A LA FUNCIÓN « %s », A LA LÍNEA « %s » --> ERROR FATAL DE BASH-UTILS :\n" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;

        echo "La carpeta raíz para las configuraciones de Bash Utils « .Bash-utils » no existe en su directorio personal." >&2; echo >&2;
        echo "Por favor, copie este archivo en su directorio personal. Puede instalarlo ejecutando el archivo « ${v_installFile} », o puede encontrarlo en la carpeta « Bash-utils/install »" >&2;

        v_isPrinted='true';
    };

    # Français | French
    [ "${__bu_module_init__user_lang,,}" == 'fr' ] && {
        printf "DANS LE FICHIER « %s », À LA FONCTION « %s() », À LA LIGNE « %s » --> ERREUR FATALE DE BASH-UTILS\n" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;

        echo "Le dossier racine des configurations du framework Bash Utils « .Bash-utils » n'existe pas dans votre répertoire personnel" >&2; echo >&2;
        echo "Veuillez copier ce dossier dans votre répertoire personnel. Vous pouvez l'installer en exécutant le fichier « ${v_installFile} », ou vous pouvez le trouver dans le dossier « Bash-utils/install »" >&2;

        v_isPrinted='true';
    };

    # हिंदी | Hindi
    [ "${__bu_module_init__user_lang,,}" == 'hi' ] && {
        printf "« %s » फ़ाइल में, « %s ()» फ़ंक्शन में, ऑनलाइन « %s » --> बैश-यूटिल्स त्रुटि\n" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;

        echo "बैश यूटिल कॉन्फ़िगरेशन रूट फ़ोल्डर « .bash-utils» आपके होम डायरेक्टरी में मौजूद नहीं है" >&2; echo >&2;
        echo "कृपया इस फ़ोल्डर को अपनी होम निर्देशिका में कॉपी करें। आप इसे «${v_installFile}» फ़ाइल निष्पादित करके स्थापित कर सकते हैं, या आप इसे « Bash-utils/install » निर्देशिका में पा सकते हैं" >&2;

        v_isPrinted='true';
    }

    # Bahasa Indonesia | Indonesian
    [ "${__bu_module_init__user_lang,,}" == 'id' ] && {
        printf "DALAM FILE « %s », PADA « %s » FUNGSI, DI GARIS « %s » --> KESALAHAN FATAL BASH-UTILS\n" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;

        echo "Folder akar konfigurasi kerangka kerja Bash Utils « .Bash-utils » tidak ada di direktori beranda Anda" >&2; echo >&2;
        echo "Silakan salin folder ini ke direktori beranda Anda. Anda dapat menginstalnya dengan mengeksekusi file « ${v_installFile} », atau Anda dapat menemukannya di direktori « Bash-utils/install »." >&2;

        v_isPrinted='true';
    }

    # 日本語 | Japanese
    [ "${__bu_module_init__user_lang,,}" == 'ja' ] && {
        printf "« %s » ファイル、AT « %s() » 関数、« %s » 行 --> BASH-UTILS エラー" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;

        echo "Bash Utilsの設定ルートフォルダ「.Bash-utils」がホームディレクトリに存在しない。" >&2; echo >&2;
        echo "このフォルダーをホーム ディレクトリにコピーします。 インストールするには、« ${v_installFile} » ファイルを実行するか、このファイルは « Bash-utils/install » ディレクトリにあります。" >&2;

        v_isPrinted='true';
    }

    # 한국인 | Korean
    [ "${__bu_module_init__user_lang,,}" == 'ko' ] && {
        printf "" >&2 && echo >&2;

        echo "" >&2; echo >&2;
        echo "" >&2;

        v_isPrinted='true';
    }

    # Português | Portuguese
    [ "${__bu_module_init__user_lang,,}" == 'pt' ] && {
        printf "EM « %s » FICHEIRO, NA FUNÇÃO « %s() », EM LINHA « %s » --> BASH-UTILS ERRO FATAL\n" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;

        echo "A pasta de configuração da raiz da estrutura Bash Utils « .Bash-utils » não existe no seu directório home" >&2; echo >&2;
        echo "Por favor copie esta pasta para o seu directório pessoal. Pode instalá-lo executando o ficheiro « ${v_installFile} », ou pode encontrá-lo na pasta « Bash-utils/install »" >&2;

        v_isPrinted='true';
    };

    # Русский | Russian
    [ "${__bu_module_init__user_lang,,}" == 'ru' ] && {
        printf "В ФАЙЛЕ « %s », К ФУНКЦИИ « %s », К СТРОКЕ « %s » --> ФАТАЛЬНАЯ ОШИБКА « BASH-UTILS »\n" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;

        echo "Корневая папка конфигураций фреймворка 'Bash Utils' « .Bash-utils » не существует в вашем домашнем каталоге" >&2; echo >&2;
        echo "Пожалуйста, скопируйте эту папку в свой домашний каталог. Вы можете установить его, запустив файл « ${v_installFile} », или вы можете найти его в папке « Bash-utils/install »" >&2;

        v_isPrinted='true';
    };

    # Türkçe | Turkish
    [ "${__bu_module_init__user_lang,,}" == 'tr' ] && {
        printf "" >&2 && echo >&2;

        echo "" >&2; echo >&2;
        echo "" >&2;

        v_isPrinted='true';
    }

    # Українська | Ukrainian
    [ "${__bu_module_init__user_lang,,}" == 'uk' ] && {
        printf "У ФАЙЛІ « %s », НА ФУНКЦІЇ « %s », ДО ЛІНІЇ « %s », --> « BASH-UTILS » ФАТАЛЬНА ПОМИЛКА\n" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;

        echo "Папка кореневої конфігурації фреймворку Bash Utils « .Bash-utils » не існує у вашому домашньому каталозі" >&2; echo >&2;
        echo "Будь ласка, скопіюйте цю папку до вашої домашньої директорії. Ви можете встановити його, запустивши файл « ${v_installFile} » або знайшовши його в папці « Bash-utils/install »" >&2;

        v_isPrinted='true';
    }

    # 简体中文 | Simplified Chinese
    [ "${__bu_module_init__user_lang,,}" == 'zh' ] && {
        printf "在文件 « %s » 中，在函数 « %s() » 中，行 « %s » --> BASH-UTILS 错误" "${v_file}" "${v_func}" "${v_line}" >&2; echo >&2;

        echo "Bash Utils 配置根文件夹 \".bash-utils\" 在您的主目录中不存在" >&2; echo >&2;
        echo "请将此文件夹复制到您的主目录中。 您可以通过执行 \"${v_installFile}\" 文件来安装它，也可以在 \"Bash-utils/install\" 目录中找到它" >&2;

        v_isPrinted='true';
    }

    # If the language chosen by the user is not (yet) supported directly in this function, the message is displayed in English.
    [ "${v_isPrinted}" != 'true' ] && [[ "${__bu_module_init__user_lang,,}" == * ]] && {
        printf "IN « %s » FILE, AT « %s() » FUNCTION, ON LINE « %s » --> BASH-UTILS ERROR\n" "${v_file}" "${v_func}" "${v_line}">&2; echo >&2;

        echo "The Bash Utils configurations root folder « .Bash-utils » doesn't exists in your home directory" >&2; echo >&2;
        echo "Please copy this folder in your home directory. You can install it by executing the « ${v_installFile} » file, or you can find it in the « Bash-utils/install » directory" >&2;
    };

    echo;
}

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

# ············································································································
# Printing the messages which tell to the user that

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   - echo		|
#	- local		|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.MsgLine()       -> Modules initializer script (this file)


# shellcheck disable=
function BU.ModuleInit.PrintLogErrorNoTranslationFilesSourced()
{
    # No need to redefine the three arguments inside this function, the scope of the "BU.ModuleInit.PrintLogError()"
    # function's local variables reach the sub-functions called inside the "BU.ModuleInit.PrintLogError()" function.

    #**** Variables ****
    local v_isPrinted;  # VAR TYPE : Bool               - DESC : Checks if one of the languages supported by the "Bash-utils-init.sh" file was found on the user's system and that the translated message was printed.
    local v_userLang;   # VAR TYPE : ISO 639-1 code     - DESC :

    #**** Code ****
    v_userLang="$(echo "${LANG}" | cut -d _ -f1)";

#    [ "${v_userLang,,}" == 'ar' ] && BU.ModuleInit.MsgLine "$(printf "[خطأ] الملف: ٪s | السطر: ٪s | الكود: ٪s"                         "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' && v_isPrinted='true';
    [ "${v_userLang,,}" == 'de' ] && BU.ModuleInit.MsgLine "$(printf "[ FEHLER ] DATEI : %s | LINIEN : %s | FEHLERCODE : %s"    "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';
    [ "${v_userLang,,}" == 'en' ] && BU.ModuleInit.MsgLine "$(printf "[ ERROR ] FILE : %s | LINE : %s | CODE : %s"              "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';

    [ "${v_userLang,,}" == 'es' ] && BU.ModuleInit.MsgLine "$(printf "[ ERROR ] FICHERO : %s | LÍNEA : %s | CÓDIGO : %s"        "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';
    [ "${v_userLang,,}" == 'fr' ] && BU.ModuleInit.MsgLine "$(printf "[ ERREUR ] FICHER : %s | LIGNE : %s | CODE : %s"          "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';
    [ "${v_userLang,,}" == 'hi' ] && BU.ModuleInit.MsgLine "$(printf "[त्रुटि] फ़ाइल: %s | रेखा: %s | कोड: %s"                             "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';

    [ "${v_userLang,,}" == 'id' ] && BU.ModuleInit.MsgLine "$(printf "[ KESALAHAN ] FILE : %s | LINE : %s | KODE : %s"          "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';
    [ "${v_userLang,,}" == 'ja' ] && BU.ModuleInit.MsgLine "$(printf "[エラー] ファイル: %s | 行: %s | コード: %s"                  "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';
    [ "${v_userLang,,}" == 'ja' ] && BU.ModuleInit.MsgLine "$(printf "[ 오류 ] 파일: %s | 줄: %s | 코드: %s"                        "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';

    [ "${v_userLang,,}" == 'pt' ] && BU.ModuleInit.MsgLine "$(printf "[ ERRO ] FICHEIRO : %s | LINHA : %s | CÓDIGO : %s"        "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';
    [ "${v_userLang,,}" == 'ru' ] && BU.ModuleInit.MsgLine "$(printf "[ ОШИБКА ] ФАЙЛ : %s | ЛИНИЯ : %s | КОД : %s"             "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';
    [ "${v_userLang,,}" == 'tr' ] && BU.ModuleInit.MsgLine "$(printf "[ HATA ] DOSYA : %s | HAT : %s | KOD: %s"                 "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';
    
    [ "${v_userLang,,}" == 'uk' ] && BU.ModuleInit.MsgLine "$(printf "[ ПОМИЛКА ] ФАЙЛ : %s | ЛІНІЯ : %s | КОД : %s"            "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';
    [ "${v_userLang,,}" == 'zh' ] && BU.ModuleInit.MsgLine "$(printf "[错误] 文件：%s | 行：%s | 代码：%s"                          "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2 && v_isPrinted='true';

    # If the language chosen by the user is not (yet) supported directly in this function, the message is displayed in English.
    [ "${v_isPrinted}" != 'true' ] && BU.ModuleInit.MsgLine "$(printf "[ERROR] FILE : %s | LINE : %s | CODE : %s" "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2;

	# TODO : check if it is better to directly call the "echo" command or the "BU.ModuleInit.MsgLine()" function.
    echo >&2;

    return 0;
}

# ·······································
# Sourcing the English translation files.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#	- # declare | (-i)
#	- echo		|
#	- local		|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.IsFrameworkCompiled()   -> Modules initializer script (this file)
#   - BU.ModuleInit.SetInitLocale.en()      -> Modules initializer script (this file)


# shellcheck disable=SC1090,SC1091
function BU.ModuleInit.SourceEnglishTranslationFiles()
{
    #**** Parameters ****
    local p_lang_backup=${1:-'en'}; # ARG TYPE : ISO 639-1 code    - REQUIRED | DEFAULT VAL : en    - DESC : language in which the  language's backup from the "BU.ModuleInit.GetModuleInitLanguage_SetEnglishAsDefaultLanguage()" function.

    #**** Code ****
    BU.ModuleInit.IsFrameworkCompiled || {
        source "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH}/en.locale" || {
            echo >&2;

            # العربية | Arabic
#             [ "${v_userLang,,}" == 'ar' ] && {
#                 #**** Conditional variables ****
#                 declare -i i;             # VAR TYPE : Int        # DESC : Number of iteration for the loop which determines the number of characters to display over the fatal error string.
#                 declare -i x;             # VAR TYPE : Int        # DESC : Number of characters stored into the "${v_ar_fatalErr}" variable;
#
#                 local v_ar_fatalErr;      # VAR TYPE : String     # DESC : Storing the Arabic fatal error string in order not to break the line's layout, nor the ">&2" redirection.
#                 local v_ar_err_expl;      # VAR TYPE : String     # DESC : Storing the Arabic explanation string in order not to break the line's layout, nor the ">&2" redirection.
#                 local v_ar_err_stop;      # VAR TYPE : String     # DESC : Storing the Arabic termination string in order not to break the line's layout, nor the ">&2" redirection.
#
#                 #**** Conditional code ****
#                 v_ar_fatalErr="خطأ فادح: تعذر تضمين ملف الترجمة باللغة الإنجليزية";
#                 v_ar_err_expl="نظرًا لأنه يتم تخزين الرسائل في ملف تهيئة الوحدة النمطية في متغيرات ، فإن هذا الملف يعتمد على ملفات الترجمة هذه ، والتي تحدد هذه المتغيرات.";
#                 v_ar_err_stop="إنهاء تنفيذ النص";
#
#                 x="${#v_ar_fatalErr}";
#
#                 for ((i=0; i<x; i++)); do
#                     echo -n '-' >&2;
#                 done
#                 echo "${v_ar_fatalErr}" >&2;
#
#                 echo "${v_ar_err_expl}" >&2;
#                 echo "${v_ar_err_stop}" >&2;
#                 echo >&2;
#
#                 v_isPrinted='true';
#             }

            # Deutch | German
            [ "${p_lang_backup,,}" == 'de' ] && {
                echo '------------------------------------------------------------------------------------------------' >&2 && echo >&2;
                echo "FATALER FEHLER : DIE ENGLISCHE ÜBERSETZUNGSDATEI KONNTE NICHT VON DER QUELLE REFERENZIERT WERDEN" >&2 && echo >&2;

                echo "Da die Nachrichten in der Modulinitialisierungsdatei in Variablen gespeichert werden, stützt sich diese Datei auf diese Übersetzungsdateien, die diese Variablen definieren" >&2;
                echo "Anhalten der Skriptausführung" >&2;
                echo >&2;
            }

            # English
            [ "${p_lang_backup,,}" == 'en' ] && {
                echo '-----------------------------------------------------------' >&2 && echo >&2;
                echo "FATAL ERROR : UNABLE TO SOURCE THE ENGLISH TRANSLATION FILE" >&2 && echo >&2;

                echo "Since the messages in the module initialization file are stored into variables, this file relies on these translation files, which define these variables" >&2;
                echo "Terminating the script's execution" >&2;
                echo >&2;
            }

            # Español | Spanish
            [ "${p_lang_backup,,}" == 'es' ] && {
                echo '-----------------------------------------------------------------' >&2 && echo >&2;
                echo "ERROR FATAL: IMPOSIBLE OBTENER EL ARCHIVO DE TRADUCCIÓN AL INGLÉS" >&2 && echo >&2;

                echo "Como los mensajes del fichero de inicialización del módulo se almacenan en variables, este fichero es asumido por estos ficheros de traducción, que definen estas variables" >&2;
                echo "Detener la ejecución del script" >&2;
                echo >&2;
            }

            # Français | French
            [ "${p_lang_backup,,}" == 'fr' ] && {
                echo '------------------------------------------------------------------------' >&2 && echo >&2;
                echo "ERREUR FATALE : IMPOSSIBLE D'INCLURE LE FICHIER DE TRADUCTION EN ANGLAIS" >&2 && echo >&2;

                echo "Comme les messages du fichier d'initialisation du module sont stockés dans des variables, ce fichier s'appuie sur ces fichiers de traduction, qui définissent ces variables" >&2;
                echo "Arrêt de l'exécution du script" >&2;
                echo >&2;
            }

            # हिंदी | Hindi
            [ "${p_lang_backup,,}" == 'hi' ] && {
                echo '--------------------------------------------------------' >&2 && echo >&2;
                echo 'घातक त्रुटि: अंग्रेजी अनुवाद फ़ाइल शामिल करने में असमर्थ' >&2 && echo >&2;

                echo "चूंकि संदेशों को मॉड्यूल इनिशियलाइज़ेशन फ़ाइल में वेरिएबल्स में संग्रहीत किया जाता है, इसलिए यह फ़ाइल उन ट्रांसलेशन फ़ाइलों पर निर्भर करती है जो इन वेरिएबल्स को परिभाषित करती हैं।" >&2;
                echo "अंत स्क्रिप्ट निष्पादन" >&2;
                echo >&2;
            }

            # Bahasa Indonesia | Indonesian
            [ "${p_lang_backup,,}" == 'id' ] && {
                echo '-----------------------------------------------------------------------' >&2 && echo >&2;
                echo 'KESALAHAN FATAL: TIDAK DAPAT MENYERTAKAN FILE TERJEMAHAN BAHASA INGGRIS' >&2 && echo >&2;

                echo "Karena pesan-pesan dalam berkas inisialisasi modul disimpan ke dalam variabel, berkas ini bergantung pada berkas terjemahan ini, yang mendefinisikan variabel-variabel ini" >&2;
                echo "Membatalkan eksekusi skrip" >&2;
                echo >&2;
            }

            # 日本語 | Japanese
            [ "${p_lang_backup,,}" == 'ja' ] && {
                echo '。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。' >&2 && echo >&2;
                echo '致命的なエラー: 英語の翻訳ファイルを含めることはできません' >&2 && echo >&2;

                echo "モジュール初期化ファイル内のメッセージは変数に格納されるため、このファイルは変換ファイルに依存してこれらの変数を生成します。" >&2;
                echo "スクリプトの実行を停止する" >&2;
                echo >&2;
            }

            # 한국인 | Korean
            [ "${p_lang_backup,,}" == 'ko' ] && {
                echo '。。。。。。。。。。。。。。。。。。。。。。。' >&2 && echo >&2;
                echo "치명적 오류: 영어 번역 파일을 포함할 수 없습니다." >&2 && echo >&2;

                echo "모듈 초기화 파일의 메시지는 변수에 저장되므로 이러한 파일은 이러한 변수를 정의하기 위해 이러한 번역 파일에 의존합니다." >&2;
                echo "스크립트 실행 종료" >&2;
                echo >&2;
            }

            # Português | Portuguese
            [ "${p_lang_backup,,}" == 'pt' ] && {
                echo '-----------------------------------------------------------------------' >&2 && echo >&2;
                echo "ERRO FATAL: IMPOSSIBILIDADE DE INCLUIR O FICHEIRO DE TRADUÇÃO EM INGLÊS" >&2 && echo >&2;

                echo "Como as mensagens no ficheiro de inicialização do módulo são armazenadas em variáveis, este ficheiro baseia-se nestes ficheiros de tradução, que definem estas variáveis" >&2;
                echo "Interrupção da execução do guião" >&2;
                echo >&2;
            }

            # Русский | Russian
            [ "${p_lang_backup,,}" == 'ru' ] && {
                echo '----------------------------------------------------------------------' >&2 && echo >&2;
                echo "ФАТАЛЬНАЯ ОШИБКА: НЕВОЗМОЖНО ВКЛЮЧИТЬ ФАЙЛ ПЕРЕВОДА НА АНГЛИЙСКИЙ ЯЗЫК" >&2 && echo >&2;

                echo "Поскольку сообщения в файле инициализации модуля хранятся в переменных, этот файл опирается на файлы перевода, которые определяют эти переменные" >&2;
                echo "Прерывание выполнения сценария" >&2;
                echo >&2;
            }

            # Türkçe | Turkish
            [ "${p_lang_backup,,}" == 'tr' ] && {
                echo '--------------------------------------------------' >&2 && echo >&2;
                echo 'ÖNEMLİ HATA: İNGİLİZCE ÇEVİRİ DOSYASI DAHİL OLAMAZ' >&2 && 
                
                echo "Modül başlatma dosyasındaki mesajlar değişkenlerde saklandığından, bu dosya bu değişkenleri tanımlayan çeviri dosyalarına dayanır." >&2;
                echo "Komut dosyasının yürütülmesini sonlandırın" >&2;
                echo >&2;
            }

            # Українська | Ukrainian
            [ "${p_lang_backup,,}" == 'uk' ] && {
                echo '-----------------------------------------------------------------------' >&2 && echo >&2;
                echo "ФАТАЛЬНА ПОМИЛКА: НЕ ВДАЛОСЯ ВКЛЮЧИТИ ФАЙЛ ПЕРЕКЛАДУ НА АНГЛІЙСЬКУ МОВУ" >&2 && echo >&2;

                echo "Оскільки повідомлення у файлі ініціалізації модуля зберігаються у змінних, цей файл покладається на файли перекладу, які визначають ці змінні" >&2;
                echo "Переривання виконання поточного скрипта" >&2;
                echo >&2;
            }

            # 简体中文 | Simplified Chinese
            [ "${p_lang_backup,,}" == 'zh' ] && {
                echo '。。。。。。。。。。。。。。。' >&2 && echo >&2;
                echo '致命错误：无法获取英文翻译文件' >&2 && echo >&2;

                echo "由于模块初始化文件中的消息存储在变量中，该文件依赖于定义这些变量的这些翻译文件" >&2;
                echo "终止脚本执行" >&2;
                echo >&2;
            }

            # If the language chosen by the user is not (yet) supported directly in this function, the message is displayed in English.
            [[ "${p_lang_backup}" == * ]] && {
                echo '-----------------------------------------------------------' >&2 && echo >&2;
                echo "FATAL ERROR : UNABLE TO SOURCE THE ENGLISH TRANSLATION FILE" >&2 && echo >&2;

                echo "Since the messages in the module initialization file are stored into variables, this file relies on these translation files, which define these variables" >&2;
                echo "Terminating the script's execution" >&2;
                echo >&2;
            }

            # WARNING : Do not call the "BU.ModuleInit.AskPrintLog()" function here, the current function is defined before the "${__BU_MODULE_INIT_MSG_ARRAY}" array.
            return 1;
        }

        # Calling the function which defines every variables containing the messages in English.
        BU.ModuleInit.SetInitLocale.en || return 1;

        return 0;
    }

    return 0;
}

## ==============================================

## STRING TRANSLATION





## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### INITIALIZER RESOURCES - DEBUGS AND TESTS

## DEBUG & TESTING FUNCTIONS

function __TestFunction()
{
    declare -i i;

    for ((i=5; i>=1; i--)); do
        echo "STOP TEST IN ${i}s";
 
        sleep 1;
    done

    echo;

    echo "STOP TEST";
    echo;

    BU.ModuleInit.Exit 0;
}

## ==============================================

## LOGGING FUNCTIONS





## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### INITIALIZER RESOURCES - FRAMEWORK INITIALIZER'S CORE UTILITIES

## EXIT FUNCTIONS

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
    #**** Variables ****
    if ! BU.ModuleInit.IsFrameworkTranslated; then
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
    BU.ModuleInit.IsInScript || {
        # echo "Returning from function with code ${p_code}";

        return "${p_code}";
    }

    # echo "Exiting script with code ${p_code}";

    exit "${p_code}";
}

## ==============================================

## SPECIFIC CHECKINGS ABOUT THIS SCRIPT'S EXECUTION METHOD

# ······················································································
# Checking if the framework is being installed thanks to the installation script (TODO).

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   -

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.IsFrameworkBeingInstalled()
{
    if  [ "${__BU_MODULE_PRE_INIT__IS_FRAMEWORK_INSTALLED,,}" == 'true' ] || \
        [[ ( "${0,,}" == "./install-framework."?(ba)sh )  || ( "${0,,}" == "install-framework".?(ba)sh ) ]]; then 
        
        return 0;
    else
        return 1;
    fi
}

# ······································································································
# Checking if the Bash Utils framework's main code is executed from a stable version of a compiled file.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   -

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.IsFrameworkCompiledStable()
{
    #**** Variables ****
    local v_currFile;

    v_currFile="$(basename "${BASH_SOURCE[0]}")";

    #**** Code ****
    if [[ "${v_currFile##*/,,}" == bash-utils-stable?(-full|-multilang|-[a-z][a-z]).?(ba)sh ]]; then
        return 0;
    else
        return 1;
    fi
}

# ·········································································································
# Checking if the Bash Utils framework's main code is executed from an unstable version of a compiled file.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   -

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.IsFrameworkCompiledUnstable()
{
    #**** Variables ****
    local v_currFile;

    #**** Code ****
    v_currFile="$(basename "${BASH_SOURCE[0]}")";

    if [[ "${v_currFile##*/,,}" == bash-utils?(-unstable)?(-full|-multilang|-[a-z][a-z]).?(ba)sh ]]; then
        return 0;
    else
        return 1;
    fi
}

# ············································································································································································································
# Checking if the whole framework's main code (config, initializer and main module's code) is compiled in a single localized file (English is not shipped or is not the only language shipped into this file).

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   -

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.IsFrameworkCompiledLocalized()
{
    #**** Variables ****
    local v_currFile;

    v_currFile="$(basename "${BASH_SOURCE[0]}")";

    #**** Code ****
    if  [[ ("${v_currFile##*/,,}" == bash-utils?(-?(un)stable)-[a-z][a-z].?(ba)sh) || \
        ("${v_currFile##*/,,}" == bash-utils?(-?(un)stable)?(-full|-multilang).?(ba)sh) ]] && \
        [ "$(wc -l "${v_currFile}" | cut -f1 -d" ")" -ge 15000 ];
    then
        return 0;
    else
        return 1;
    fi
}

# ························································································································································································
# Checking if the whole framework's main code (config, initializer and main module's code) is compiled in a single unlocalized file (English is the only language shipped into this file).

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   - echo	|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.

# shellcheck disable=
function BU.ModuleInit.IsFrameworkCompiledUnlocalized()
{
    #**** Variables ****
    local v_currFile;

    v_currFile="$(basename "${BASH_SOURCE[0]}")";

    #**** Code ****
    if  [[ "${v_currFile##*/,,}" == bash-utils?(-?(un)stable)-full.?(ba)sh ]] && \
        [ "$(wc -l "${v_currFile}" | cut -f1 -d" ")" -ge 15000 ];
    then
        echo "FILE = ${v_currFile}";

        return 0;
    else
        return 1;
    fi
}

# ····································································································································
# Checking if the whole framework's main code (config, initializer and main module's code) is compiled in a single (un)localized file.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#   -

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.IsFrameworkCompiledLocalized()      -> Modules initializer script (this file)
#   - BU.ModuleInit.IsFrameworkCompiledUnlocalized()    -> Modules initializer script (this file)


# shellcheck disable=
function BU.ModuleInit.IsFrameworkCompiled()
{
    #**** Variables ****
    local v_currFile;

    v_currFile="$(basename "${BASH_SOURCE[0]}")";

    #**** Code ****
    if  BU.ModuleInit.IsFrameworkCompiledLocalized || \
        BU.ModuleInit.IsFrameworkCompiledUnlocalized;
    then
        return 0;
    else
        return 1;
    fi
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
function BU.ModuleInit.IsFrameworkTranslated()
{
    if [ "${__BU_MODULE_INIT__BU_BASE_IS_TRANSLATED,,}" == 'true' ]; then
        return 0;
    else
        return 1;
    fi
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### INITIALIZER RESOURCES - MODULES ENGINE'S FUNCTIONS

## FILESYSTEM MANAGEMENT

# ······················································································
# Checking the validity of the path returned by the "BU.ModuleInit.FindPath()" function.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#	- declare	| (-i)
#	- echo		|
#	- find		| (-maxdepth | -iname | -print)
#	- grep		| (-v)
#	- local		|
#	- touch		|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.IsFrameworkBeingInstalled()             -> Modules initializer script (this file)
#   - BU.ModuleInit.PrintLogError()                         -> Modules initializer script (this file)

# shellcheck disable=
function BU.ModuleInit.CheckPathIntegrity()
{
    #**** Parameters ****
    local p_target=${1:-$'\0'};     # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : Targeted directory or file.
    local p_code=${2:-0};           # ARG TYPE : Int        - REQUIRED | DEFAULT VAL : 0        - DESC : Return code of the "BU.ModuleInit.FindPath()" function.
    local p_basename=${3:-NULL};    # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC :
    local p_funcname=${4:-NULL};    # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC :
    local p_lineno=${5:-NULL};      # ARG TYPE : Int        - REQUIRED | DEFAULT VAL : NULL     - DESC :

    #**** Variables ****
    # If the framework is not yet translated when this function is called. 
    if ! BU.ModuleInit.IsFrameworkTranslated; then
        declare -g __BU_MODULE_INIT_MSG__CURRENT_LOCALE_FILE__BU_ERROR;
        declare -g __BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__PATH_MISSING;
        declare -g __BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__PATH_NOT_FOUND;
        declare -g __BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__TOP_LEVEL_FUNCTION;
        declare -g __BU_MODULE_INIT_MSG__PRINT_MISSING_PATH_FOR_DEFINED_GLOBAL_VARIABLE__NO_FNCT;

        __BU_MODULE_INIT_MSG__CURRENT_LOCALE_FILE__BU_ERROR="IN « %s » FILE, AT « %s() » FUNCTION, ON LINE « %s » --> BASH-UTILS ERROR";
        __BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__PATH_MISSING="${__BU_MODULE_INIT_MSG__CURRENT_LOCALE_FILE__BU_ERROR} : NO PATH PASSED AS ARGUMENT";
        __BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__PATH_NOT_FOUND="${__BU_MODULE_INIT_MSG__CURRENT_LOCALE_FILE__BU_ERROR} : UNABLE TO FIND THIS PATH";
        __BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__TOP_LEVEL_FUNCTION="Function where the « %s() » function was called : %s()";
    fi

    #**** Code ****
    # Debug command to check if the path's integrity is valid.
    # echo "Path integrity check : ${p_target}";

    # If the target directory  /   file was not found
    if [ ! -d "${p_target}" ] && [ ! -f "${p_target}" ]; then
        BU.ModuleInit.PrintLogError "${BASH_SOURCE[0]}" "${p_lineno}" 'E_BUINIT__CHECK_PATH_INTEGRITY__TARGET_PATH_NOT_FOUND';

        printf "${__BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__PATH_NOT_FOUND} --> %s\n" "${p_basename}" "${p_funcname}" "${p_lineno}" "${p_target}" >&2; echo >&2;

        printf "${__BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__TOP_LEVEL_FUNCTION}\n" "${FUNCNAME[0]}" "${FUNCNAME[1]}" >&2;

        return 1;
    fi

    # If no path was passed.
    if [ -z "${p_target}" ]; then
        BU.ModuleInit.PrintLogError "${BASH_SOURCE[0]}" "${p_lineno}" 'E_BUINIT__CHECK_PATH_INTEGRITY__TARGET_PATH_MISSING_VAL';

        printf "${__BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__PATH_MISSING} --> %s\n" "${p_basename}" "${p_funcname}" "${p_lineno}" "${p_target}" >&2; echo >&2;

        printf "${__BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__TOP_LEVEL_FUNCTION}\n" "${FUNCNAME[0]}" "${FUNCNAME[1]}" >&2;

        return 1;
    fi

	return 0;



    # # Return code : 29 -> If the "Bash-utils-root-val.path" was not found,
    # if [ -z "${__BU_MODULE_INIT__TMP_VAR__FIND_PATH_FUNC_NO_ERR}" ]; then
    #     BU.ModuleInit.PrintLogError "${BASH_SOURCE[0]}" "${v_e_lineno}" 'E_BUINIT__FIND_PATH__ECHO_2__PATH_NOT_FOUND';

    #     printf "${__BU_MODULE_INIT_MSG__CHECKPATH__PATH_NOT_FOUND} --> %s/%s\n" "$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}" "${LINENO}" "${v_parentdir}" "${v_target}" >&2; echo >&2;

    #     printf "${__BU_MODULE_INIT_MSG__CHECKPATH__TOP_LEVEL_FUNCTION}\n" "${FUNCNAME[0]}" "${FUNCNAME[1]}" >&2;

    #     BU.ModuleInit.Exit 1; return "${?}";
    # fi


        # #**** Error management variables ****
        # declare -i v_e_lineno="$(( LINENO - 2 ))";  # VAR TYPE : Int   - DESC : Storing the line where the last command has failed to execute correctly.

        # #**** Error management code ****
        # if [ "${v_shut,,}" != 'shut' ]; then
        #     echo >&2;

        #         # If the "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH}" directory is not defined yet, or if the current file is not a compiled version of the Bash Utils Framework,
        #         # it means that the translation files are not sourced yet, so the messages to display are hard-coded in this file.
        #         if ! BU.ModuleInit.IsInitializerTranslated && ! BU.ModuleInit.IsFrameworkCompiled && ! BU.ModuleInit.IsFrameworkBeingInstalled; then
        #             BU.ModuleInit.PrintLogError "${BASH_SOURCE[0]}" "${v_e_lineno}" 'E_BUINIT__FIND_PATH__ECHO_1__PATH_NOT_FOUND';

        #             BU.ModuleInit.FindPathNoTranslationFilesSourced "${FUNCNAME[0]}" "${FUNCNAME[1]}" "${BASH_SOURCE[0]}" "${v_e_lineno}" 'echo';

        #             BU.ModuleInit.Exit 1; return "${?}";
        #         else
        #             BU.ModuleInit.PrintLogError "${BASH_SOURCE[0]}" "${v_e_lineno}" 'E_BUINIT__FIND_PATH__ECHO_2__PATH_NOT_FOUND';

        #             printf "${__BU_MODULE_INIT_MSG__CHECKPATH__PATH_NOT_FOUND} --> %s/%s\n" "$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}" "${LINENO}" "${v_parentdir}" "${v_target}" >&2; echo >&2;

        #             printf "${__BU_MODULE_INIT_MSG__CHECKPATH__TOP_LEVEL_FUNCTION}\n" "${FUNCNAME[0]}" "${FUNCNAME[1]}" >&2;

        #             BU.ModuleInit.Exit 1; return "${?}";
        #         fi
        #     fi

        # # else
        #     if [ "${v_shut,,}" != 'shut' ]; then declare -i lineno="${LINENO}";
        #         BU.ModuleInit.Msg >&2;

        #         # If the "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH}" directory is not defined yet, or if the current file is not a compiled version of the Bash Utils Framework,
        #         # it means that the translation files are not sourced yet, so the messages to display are hard-coded in this file.
        #         if [ -z "${__BU_MODULE_INIT_IS_TRANSLATION_FILES_SOURCED}" ] && ! BU.ModuleInit.IsFrameworkCompiled && ! BU.ModuleInit.IsFrameworkBeingInstalled; then
        #             BU.ModuleInit.PrintLogError "${BASH_SOURCE[0]}" "${v_e_lineno}" 'E_BUINIT__FIND_PATH__MSG_1__PATH_NOT_FOUND';

        #             BU.ModuleInit.FindPathNoTranslationFilesSourced "${FUNCNAME[0]}" "${FUNCNAME[1]}" "${BASH_SOURCE[0]}" "${v_e_lineno}" 'echo';

        #             BU.ModuleInit.Exit 1; return "${?}";
        #         else
        #             BU.ModuleInit.PrintLogError "${BASH_SOURCE[0]}" "${v_e_lineno}" 'E_BUINIT__FIND_PATH__MSG_2__PATH_NOT_FOUND';

        #             BU.ModuleInit.Msg "$(printf "${__BU_MODULE_INIT_MSG__CHECKPATH__PATH_NOT_FOUND} --> %s/%s\n" "$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}" "${LINENO}" "${v_parentdir}" "${v_target}")" >&2; BU.ModuleInit.Msg >&2;

        #             BU.ModuleInit.Msg "$(printf "${__BU_MODULE_INIT_MSG__CHECKPATH__TOP_LEVEL_FUNCTION}\n" "${FUNCNAME[0]}" "${FUNCNAME[1]}")" >&2;

        #             BU.ModuleInit.AskPrintLog || { BU.ModuleInit.Exit 1; return "${?}"; };

        #             BU.ModuleInit.Exit 1; return "${?}";
        #         fi
        #     fi
        # # fi

        # #**** Error management variables ****
        # declare -i v_e_lineno="$(( LINENO - 2 ))";  # VAR TYPE : Int   - DESC : Storing the line where the last command has failed to execute correctly.

        # #**** Error management code ****
        # if [ -z "${__BU_MODULE_INIT_MSG_ARRAY_EXISTS}" ]; then
        #     if [ "${v_shut,,}" != 'shut' ]; then
        #         echo >&2;

        #         # If the "${__BU_MODULE_INIT__CONFIG_INIT_LANG_DIR_PATH}" directory is not defined yet, or if the current file is not a compiled version of the Bash Utils Framework,
        #         # it means that the translation files are not sourced yet, so the messages to display are hard-coded in this file.
        #         if ! BU.ModuleInit.IsInitializerTranslated && ! BU.ModuleInit.IsFrameworkCompiled && ! BU.ModuleInit.IsFrameworkBeingInstalled; then
        #             BU.ModuleInit.PrintLogError "${BASH_SOURCE[0]}" "${v_e_lineno}" 'E_BUINIT__FIND_PATH__ECHO_1__PATH_NOT_FOUND';

        #             BU.ModuleInit.FindPathNoTranslationFilesSourced "${FUNCNAME[0]}" "${FUNCNAME[1]}" "${BASH_SOURCE[0]}" "${v_e_lineno}" 'echo';

        #             BU.ModuleInit.Exit 1; return "${?}";
        #         else
        #             BU.ModuleInit.PrintLogError "${BASH_SOURCE[0]}" "${v_e_lineno}" 'E_BUINIT__FIND_PATH__ECHO_2__PATH_NOT_FOUND';

        #             printf "${__BU_MODULE_INIT_MSG__CHECKPATH__PATH_NOT_FOUND} --> %s/%s\n" "$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}" "${LINENO}" "${v_parentdir}" "${v_target}" >&2; echo >&2;

        #             printf "${__BU_MODULE_INIT_MSG__CHECKPATH__TOP_LEVEL_FUNCTION}\n" "${FUNCNAME[0]}" "${FUNCNAME[1]}" >&2;

        #             BU.ModuleInit.Exit 1; return "${?}";
        #         fi
        #     fi
        # fi
}

# ··············································································································
# Getting the path returned by the "find" command, to make the directories and files searching case insensitive.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#	- find		| (-maxdepth | -iname | -print)
#	- grep		| (-v)
#	- local		|
#	- touch		|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - Feel free to call a function if it is needed for your contribution.


# shellcheck disable=
function BU.ModuleInit.FindPath()
{
    #**** Parameters ****
    local p_parentDir=${1:-$'\0'};  # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : Parent directory.
    local p_target=${2:-$'\0'};     # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : Targeted directory or file.

    #**** Variables ****
    local v_code;                   # VAR TYPE : Int        - DESC : Custom error code.

    #**** Code ****
    find "${p_parentDir}" -maxdepth 1 -iname "${p_target}" -print 2>&1 | grep -v "Permission denied";

    v_code="${?}";

    # Returning a custom error code to better manage the error in the "BU.ModuleInit.CheckPathIntegrity()" function.
    if [ "${v_code}" -ne 0 ]; then
        # If no custom code is to be returned, then the classic code 1 is returned.
        echo "${p_parentDir}/${p_target}";

        return "${v_code}";
    else
        return 0;
    fi
}

# ···············································
# Writing a text under a line with the same size.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#	- echo		|
#	- local		|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.Msg()               -> Modules initializer script (this file)
#   - BU.ModuleInit.MsgLineCount()      -> Modules initializer script (this file)


# shellcheck disable=
function BU.ModuleInit.MsgLine()
{
    #**** Parameters ****
    local p_str=${1:-$'\0'};        # ARG TYPE : String     - OPTIONAL  | DEFAULT VAL : NULL    - DESC : String to write.
    local p_line=${2:-$'\0'};       # ARG TYPE : Char       - OPTIONAL  | DEFAULT VAL : NULL    - DESC : Line character.
    local p_context=${3:-'echo'};   # ARG TYPE : String     - OPTIONAL  | DEFAULT VAL : NULL    - DESC : Context of the function's call (should the text be processed by the "BU.ModuleInit.Msg" function or with a simple "echo" command ?).

    #**** Code ****
    if      [ "${p_context,,}" == 'echo' ]; then
        BU.ModuleInit.MsgLineCount "${#p_str}" "${p_line}" 'echo';
        echo "${p_str}";

    elif    [ "${p_context,,}" == 'msg' ]; then
        BU.ModuleInit.MsgLineCount "${#p_str}" "${p_line}" 'msg' || return 1;
        BU.ModuleInit.Msg "${p_str}" || return 1;
    fi

    return 0;
}

# ······························································································································
# Drawing a line with a character, that is the same lenght as a string, in order to separate the messagges from different steps.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#	- declare	| (-i)
#	- echo		|
#	- local		|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.Msg()               -> Modules initializer script (this file)


# shellcheck disable=
function BU.ModuleInit.MsgLineCount()
{
    #**** Parameters ****
    local p_number=${1:-$'\0'};     # ARG TYPE : Int    - REQUIRED | DEFAULT VAL : NULL     - DESC : Number of times the character has to be display.
    local p_line=${2:-$'\0'};       # ARG TYPE : Int    - REQUIRED | DEFAULT VAL : NULL     - DESC : Line character.
    local p_context=${3:-'echo'};   # ARG TYPE : NULL   - REQUIRED | DEFAULT VAL : NULL     - DESC : Context of the function's call (should the text be processed by the "BU.ModuleInit.Msg" function or with a simple "echo" command ?).

    #**** Variables ****
    declare -i i;   # VAR TYPE : Int    - DESC : "For" loop counter

    #**** Code ****
    if      [ "${p_context,,}" == 'echo' ]; then
        for ((i=0; i<p_number; i++)); do echo -n "${p_line}"; done; echo;

    elif    [ "${p_context,,}" == 'msg' ]; then
        for ((i=0; i<p_number; i++)); do BU.ModuleInit.Msg "${p_line}" '-n' || return 1; done; BU.ModuleInit.Msg || return 1;
    fi

    return 0;
}

# ···················································
# Print an error message in the log storage variable.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured shell commands and their options(s) :
#	- echo	|
#	- local	|

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.ModuleInit.Msg()       -> Modules initializer script (this file)
#   - BU.ModuleInit.MsgLine()   -> Modules initializer script (this file)

#   - BU.ModuleInit.PrintLogErrorNoTranslationFilesSourced() -> Modules initializer script (this file)


# shellcheck disable=
function BU.ModuleInit.PrintLogError()
{
    #**** Parameters ****
    local p_file=${1:-$'\0'};       # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : File where the error happened.
    local p_lineno=${2:-$'\0'};     # ARG TYPE : Int        - REQUIRED | DEFAULT VAL : NULL     - DESC : Line where the error happened.
    local p_errcode=${3:-$'\0'};    # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : Error code, in order to find what kind of error happened.

    #**** Code ****
    if [ -z "${__BU_MODULE_INIT_MSG_ARRAY_EXISTS}" ]; then
        echo >&2;

        # No need to redefine the three arguments inside this sub-function, the scope of the current function's local variables reach the sub-functions called inside the current function.
        BU.ModuleInit.PrintLogErrorNoTranslationFilesSourced;
    else
        true;
        # TODO
        # if [ "${__BU_MODULE_INIT_MSG_ARRAY_PERMISSION,,}" != '--log-shut-display' ]; then
        #     local v_msg_arr_mode_backup="${__BU_MODULE_INIT_MSG_ARRAY_PERMISSION}";

        #     __BU_MODULE_INIT_MSG_ARRAY_PERMISSION='--log-shut-display';
        # fi

        # BU.ModuleInit.Msg >&2;

        # # shellcheck disable=SC2059
        # BU.ModuleInit.MsgLine "$(printf "${__BU_MODULE_INIT_MSG__PRINTLOG_ERROR__PRINT_ERROR}" "${p_file}" "${p_lineno}" "${p_errcode}")" '-' 'echo' >&2;

        # BU.ModuleInit.Msg >&2;

        # if [ -n "${v_msg_arr_mode_backup}" ]; then __BU_MODULE_INIT_MSG_ARRAY_PERMISSION="${v_msg_arr_mode_backup}"; fi
    fi

    return 0;
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### BEGINNING OF THE INITIALIZATION PROCESS

## CHECKING IF THE CURRENT SHELL IS BASH

if [ -z "${BASH_VERSION}" ]; then
    ____bu_lang=$(echo "${LANG}" | cut -d_ -f1)

    case "${____bu_lang}" in
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

## STARTING A TIMER IN ORDER TO CHECK THE INITIALIZATION PROCESS' TIME

# Do not assign any value here now, it will be done at the end of the framework's initialization process.
declare -gi __BU_MODULE_INIT__FRAMEWORK_INITIALIZATION_PROCESS_TIMER;

## ==============================================

## CHECKING THE VERSION OF BASH CURRENTLY USED TO EXECUTE THE FRAMEWORK

# Checking the version of the Bash language currently used on the user's system.
BU.ModuleInit.CheckBashMinimalVersion || BU.ModuleInit.Exit 1;

## ==============================================

## CALLING THE TRAPS RESOURCES

BU.ModuleInit.DefineTraps;

## ==============================================

## DEFINING GLOBAL VARIABLES



# Calling the function previously defined, or else the global variables will not be declared.
BU.ModuleInit.DefineBashUtilsGlobalVariablesBeforeInitializingTheModules || { BU.ModuleInit.Exit "${?}"; return "${?}"; };

## ==============================================

## CALLING THE NEEDED FUNCTIONS (DEFINED IN THIS FILE) THAT MUST BE CALLED BEFORE INITIALIZING THE FIRST GLOBAL VARIABLES

# THE "BU.ModuleInit.GetModuleInitLanguage()" FUNCTION MUST BE THE FIRST FUNCTION TO BE CALLED !!!!

# Since this function gets the language currently used by the system, if you want to change the language, you just have to define
# a new value to the "${LANG}" environment variable before calling the "BashUtils_InitModules()" function in your main script file.

# Checking if an error occurs during the sourcing of a locale file.
declare -g __BU_MODULE_INIT__LOCALE_INIT__HAS_ERROR_OCCURED='false';

# Counting the number of unnamed variables.
declare -ag __BU_MODULE_INIT__LOCALE_INIT__UNNAMED_VARS_NB=();

# Counting the number of badly formatted variables names.
declare -ag __BU_MODULE_INIT__LOCALE_INIT__BAD_FMT_NAMEVARS_NB=();

# If the framework is compiled, then you should call the "Bash-utils-${language}.sh" file which corresponds to the language that you want to use.
BU.ModuleInit.IsFrameworkCompiledLocalized || {
    if [ "${__BU_MODULE_INIT__USER_LANG,,}" != 'en' ]; then
        BU.ModuleInit.GetModuleInitLanguage "${__BU_MODULE_INIT__USER_LANG}" || { BU.ModuleInit.Exit 1; return "${?}"; };
    fi
}

#
declare -g __BU_MODULE_INIT_IS_TRANSLATION_FILES_SOURCED='true';

__TestFunction; return "${?}";

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
