#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : latex-compiler.sh
# Author(s)     : Dimitri OBEID
# Version       : 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# This script recursively compiles EVERY ".tex" files from the project's root folder.

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

## FILEPATHS ARRAY

# ARG TYPE : Array
# REQUIRED
# DEFAULT VAL : .

# DESC : This array contains all the paths to the LaTeX files to be compiled into a PDF file.
declare -agr __BU__BIN__LATEX_COMPILER__ARGS__FILEPATHS=("${@}");

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

## COMMANDS

# Storing the name of the "$(latexmk)" command.
__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD='latexmk';

## ==============================================

## PATHS

# Path to the "Bash-utils" directory.
declare -g      __BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__BASH_UTILS__DIR;
                __BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__BASH_UTILS__DIR="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path" || echo "Unable to get the path to the \"Bash-utils\" folder" >&2; exit 1)";
    readonly    __BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__BASH_UTILS__DIR;

# Path to the parent directory of the file which stores the the list of compiled files and their MD5 checksum.
declare -gr __BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_DIR="${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__BASH_UTILS__DIR}/docs/00 DATA/cmp";

# Path to the file which stores the list of files without comments and their MD5 checksum.

# This technique also allows not to ship many LaTeX source files, which would unnecessarily increase the size of the Git repository with all the languages
# which need to be supported and take too many hard drive memory on older computers, where an user would prefer to install their needed documentation only.
declare -gr __BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__UNCOMMENTED_FILES_LIST="${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_DIR}/LaTeX_uncommented.list";

# Path to the file which stores the list of compiled files and their MD5 checksum.
declare -gr __BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_FILES_LIST="${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_DIR}/LaTeX_compiled.list";

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### FUNCTIONS DEFINITION

## COMPILATION PROCESS

# ···········································································································
# Checking if the content of the file to compile was not modified since its last compilation, by implementing
# this functionality the same way as the Shellchecking function from the framework compiler's code.

# TODO :

# Implement a feature which checks if the only modifications made were comments, so that the file won't be compiled.
# The processed file should be copied in a temporary file and the comments have to be deleted into this file.

# The LaTeX comments begin with a '%'. The lines where only a comment is present must be deleted, and if a LaTeX command
# is called before the comment, the latter and the blank space separating the command and the comment must be deleted.

# shellcheck disable=
function BU.DevBin.LatexCompiler.Function.CheckIsAlreadyCompiled()
{
    return 0;
}

# ··································
# LaTeX to PDF compilation function.

# shellcheck disable=
function BU.DevBin.LatexCompiler.Functions.CompileLatexToPDF()
{
    #**** Parameters ****
    local p_filepath=${1:-$'\0'};   # ARG TYPE : Filepath   - REQUIRED | DEFAULT VAL : NULL     - DESC : Path to the LaTeX file to compile.

    #**** Variables ****
    local v_compiler_env;           # VAR TYPE : Filepath   - DESC : Cutting the path which precedes the "Bash-utils/" sub-string in order to unify the compilation environments by processing the relative path of a file instead of its absolute path (if someone else compiles a version of the framework stored in their home folder, instead of "/usr/local/lib/" for example).
    local v_existing_md5;           # VAR TYPE : CMD        - DESC : Storing the output of the "$(grep)" command used to get the current file's corresponding md5 checksum from the "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_FILES_LIST}" file.
    local v_new_md5;                # VAR TYPE : CMD        - DESC : Storing the output of the "$(md5sum)" command used to calculate the current file's corresponding md5 checksum.

    #**** Code ****
    v_compiler_env='Bash-utils';
    v_compiler_env="${p_filepath#*"${v_compiler_env}"}";
    v_compiler_env="Bash-utils${v_compiler_env}";

    if [ -z "${p_filepath}" ]; then
        BU.DevBin.LatexCompiler.Functions.HandleErrorInput 'E_MISSING_FILEPATH'; return "${?}";
    
    elif [ ! -f "${p_filepath}" ]; then
        BU.DevBin.LatexCompiler.Functions.HandleErrorInput 'E_INCORRECT_FILE_PATH'; return "${?}";
    fi

    # Checking first if the file was already compiled by parsing the "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_FILES_LIST}" file.
    if grep -qi "${v_compiler_env}" "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_FILES_LIST}"; then

        # Extracting the current file's corresponding MD5 checksum from the "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_FILES_LIST}".
        v_existing_md5=$(grep -i "${v_compiler_env}" "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_FILES_LIST}" | awk '{print $1}');

        # Calculating the MD5 checksum of the current file.
        v_new_md5="$(md5sum "${p_filepath}" | awk '{print $1}')";

        # Checking if both checksums correspond to each other.
        if [ "${v_existing_md5}" != "${v_new_md5}" ]; then
            BU.DevBin.LatexCompiler.Function.CheckIsAlreadyCompiled || {
                BU.DevBin.LatexCompiler.Functions.HandleErrorInput 'E_COMPILATION_AND_MODIFICATION_CHECKING_FAILED';

                return 1;
            }
        else
            # shellcheck disable=SC2059
            printf "${__BU__BIN__LIB_COMPILER_V4__GLOBVARS__MSG_S__SHELLCHECK__SUCCESS_FILE_ALREADY_SHELLCHECKED}\n" "${v_compiler_env}";
        fi
    else
        BU.DevBin.LatexCompiler.Function.CheckIsAlreadyCompiled || {
            BU.DevBin.LatexCompiler.Functions.HandleErrorInput 'E_COMPILATION_AND_MODIFICATION_CHECKING_FAILED';

            return 1;
        }
    fi

    # Compiling the targeted file.
    latexmk -pdf "${p_filepath}" || { 
        BU.DevBin.LatexCompiler.Functions.HandleErrorInput 'E_COMPILATION_FAILED'; return "${?}";
    };

    return 0;
}

## ==============================================

## ERRORS MANAGER

# ··············································································
# Handling the eventual errors which could occur during the compilation process.

# shellcheck disable=
function BU.DevBin.LatexCompiler.Functions.HandleErrorInput()
{
    #**** Parameters ****
    local p_code=${1:-$'\0'};   # ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : Error string.

    #**** Code ****
    if [ "${p_code^^}" == 'E_MISSING_FILEPATH' ]; then
        echo "ERROR : MISSING FILE PATH PASSED INTO THE ${FUNCNAME[1]}() FUNCTION !" >&2;

    elif [ "${p_code^^}" == 'E_INCORRECT_FILE_PATH' ]; then
        echo "ERROR : INCORRECT FILE PATH PASSED INTO THE ${FUNCNAME[1]}() FUNCTION !" >&2;

    elif [ "${p_code^^}" == 'E_COMPILATION_AND_MODIFICATION_CHECKING_FAILED' ]; then
        echo "ERROR : AN ERROR OCCURED WHILE CHECKING IF THE CURRENT FILE WAS ALREADY COMPILED AND MODIFIED SINCE THE LAST COMPILATION" >&2;

    elif [ "${p_code^^}" == 'E_COMPILATION_FAILED' ]; then
        echo "ERROR : AN ERROR OCCURED DURING THE COMPILATION OF THE PREVIOUS FILE !" >&2;
        echo "Please correct this / these error(s) with the help of your LaTeX editor" >&2;
    fi

    echo >&2;

    read -pr "Do you want to continue the compiler's execution ? (Y/N)" __read_handle_error_input;

    case "${__read_handle_error_input^^}" in
        'Y'|'YE'|'YES'|'YS')    return 0;;
        *)                      return 1;;
    esac

    return 0;
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

if ! command -v "${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD}"; then
    if      [[ "${LANG,,}" == de_* ]]; then echo "Der Befehl '\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})' wurde auf Ihrem System nicht gefunden. Ausführung des Compilers gestoppt" >&2;
    elif    [[ "${LANG,,}" == en_* ]]; then echo "The '\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})' command was not found on your system. Terminating the compiler's execution" >&2;
    elif    [[ "${LANG,,}" == es_* ]]; then echo "El comando '\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})' no fue encontrado en su sistema. Detener la ejecución del compilador" >&2;

    elif    [[ "${LANG,,}" == fr_* ]]; then echo "La commande '\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})' n'a pas été trouvée sur votre système. Arrêt de l'exécution du compilateur" >&2;
    elif    [[ "${LANG,,}" == id_* ]]; then echo "Perintah '\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})' tidak ditemukan pada sistem Anda. Menghentikan eksekusi kompiler" >&2;
    elif    [[ "${LANG,,}" == pt_* ]]; then echo "O comando '\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})' não foi encontrado no seu sistema. Impedir o compilador de funcionar" >&2;

    elif    [[ "${LANG,,}" == ru_* ]]; then echo "Команда '\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})' не найдена в вашей системе. Остановка работы компилятора" >&2;
    elif    [[ "${LANG,,}" == sv_* ]]; then echo "Kommandot '\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})' hittades inte på ditt system. Avsluta körningen av kompilatorn" >&2;
    elif    [[ "${LANG,,}" == tr_* ]]; then echo "'\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})' komutu sisteminizde bulunamadı. Derleyici yürütmesini sonlandır" >&2;

    elif    [[ "${LANG,,}" == uk_* ]]; then echo "Команду '\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})' не знайдено у вашій системі. Зупинка роботи компілятора" >&2;
    elif    [[ "${LANG,,}" == zh_* ]]; then echo "在您的系统中没有找到命令 '\$(${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD})'。终止编译器执行" >&2;

    else
        echo "The '${__BU__BIN__LATEX_COMPILER__GLOBVARS__CMDS__CMD}' command was not found on your system. Terminating the compiler's execution" >&2;
    fi

    echo >&2; exit 1;
fi

# Checking first if the "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_FILES_LIST}" file and its parent directory exists.
if [ ! -d "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_DIR}" ]; then
    mkdir -p -v "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_DIR}" || {
        echo "ERROR : UNABLE TO CREATE THE \"${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_DIR}\" DIRECTORY !!!" >&2;
        echo >&2;

        echo "Terminating the script's execution" >&2;
        echo >&2;

        exit 1;
    };
else
    if [ ! -f "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_FILES_LIST}" ]; then
        touch "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_FILES_LIST}"  || {
            echo "ERROR : UNABLE TO CREATE THE \"${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__COMPILED_FILES_LIST}\" FILE !!!" >&2;
            echo >&2;

            echo "Terminating the script's execution" >&2;
            echo >&2;

            exit 1;
        };
    fi
fi

# Doing the same thing with the "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__UNCOMMENTED_FILES_LIST}" file.
if [ ! -f "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__UNCOMMENTED_FILES_LIST}" ]; then
    touch "${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__UNCOMMENTED_FILES_LIST}"  || {
        echo "ERROR : UNABLE TO CREATE THE \"${__BU__BIN__LATEX_COMPILER__GLOBVARS__PATHS__UNCOMMENTED_FILES_LIST}\" FILE !!!" >&2;
        echo >&2;

        echo "Terminating the script's execution" >&2;
        echo >&2;

        exit 1;
    };
fi

# If a single file path was passed as argument.
if [ "${#__BU__BIN__LATEX_COMPILER__ARGS__FILEPATHS[@]}" -eq 1 ]; then
    BU.DevBin.LatexCompiler.Functions.CompileLatexToPDF "${__BU__BIN__LATEX_COMPILER__ARGS__FILEPATHS[0]}" || exit 1;

# Else, if multiple file paths were passed as argument
elif [ "${#__BU__BIN__LATEX_COMPILER__ARGS__FILEPATHS[@]}" -gt 1 ]; then
    for file in "${__BU__BIN__LATEX_COMPILER__ARGS__FILEPATHS[@]}"; do
        BU.DevBin.LatexCompiler.Functions.CompileLatexToPDF "${file}" || exit 1;
    done

# Else, if no file path was passed as argument.
else
    find . -name '*.tex' -execdir latexmk -pdf {} \;
fi

exit 0;
