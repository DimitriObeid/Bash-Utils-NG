#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : latex-create-file-arch-lang.sh
# Author(s)     : Dimitri OBEID
# Version       : 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# This script creates the same file architecture for every wanted languages in their "Bash-utils/docs/${lang}/" folder.

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### SOURCING PROJECT'S DEPENDENCIES ###########################################

#### BASH DEPENDENCIES

## BASH UTILS

# Including the "Bash-utils/lib/functions/main/Text.lib" file in order to use the "BU.Main.Text.ReplaceLettersInString()" function.

# shellcheck disable=SC1091
source "$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path")/lib/functions/main/Text.lib" || {
    echo "Unable to include the \"Bash-utils/lib/functions/main/Text.lib\" file into this script";

    exit 1;
};

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

## LANGUAGE

# ARG TYPE : Array
# REQUIRED
# DEFAULT VAL : NULL

# DESC : Array containing the list of ISO 639-1 languages code to create the same existing LaTeX files in the "devtools" and "modules" folders,
# which are both located into each of the folders, named after the ISO 639-1 languages codes, to process by this script.
__BU__BIN__LCFAL__ARGS__LANG_ARRAY=( "${@}" );

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################## PROJECT'S GLOBAL VARIABLES DEFINITIONS #######################################

#### VARIABLES DEFINITIONS

## ERRORS MANAGER

# Storing a string which warns that an error occured in the main program's loop.
declare -g __BU__BIN__LCFAL__GLOBVARS__ERR__LOOP_ERROR;

## ==============================================

## PATHS

# Path to the "Bash-utils" directory.
declare -g      __BU__BIN__LCFAL__GLOBVARS__PATHS__BASH_UTILS__DIR;
                __BU__BIN__LCFAL__GLOBVARS__PATHS__BASH_UTILS__DIR="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path" || echo "Unable to get the path to the \"Bash-utils\" folder" >&2; exit 1)";
    readonly    __BU__BIN__LCFAL__GLOBVARS__PATHS__BASH_UTILS__DIR;

# Path to the "Bash-utils/docs" directory.
declare -gr __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_DIR="${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASH_UTILS__DIR}/docs";

# Path to the "Bash-utils/docs/en" directory.
declare -gr __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DIR="${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_DIR}/en";

# Path to the "Bash-utils/docs/en/devtools" directory.
declare -gr __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR="${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DIR}/devtools";

# Path to the "Bash-utils/docs/en/modules" directory.
declare -gr __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_DIR="${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DIR}/modules";

# Path to the "Bash-utils/docs/en/modules/02) Config" directory.
declare -gr __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR="${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_DIR}/02) Config";

# Path to the "Bash-utils/docs/en/modules/03) InitModule" directory.
declare -gr __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_03INITMODULE_DIR="${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_DIR}/03) InitModule";

# Path to the "Bash-utils/docs/en/modules/04) Functions" directory.
declare -gr __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR="${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_DIR}/04) Functions";

# Path to the "Bash-utils/docs/00 DATA/txt/" directory
declare -gr __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_DATA_TXT_DIR="${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_DIR}/00 DATA/txt";

# Path to the "Bash-utils/docs/00 DATA/txt/${__lang}.tex" file (DO NOT PASS ANY VALUE HERE, it will be done in the main loop).
declare -g __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_00DATA_TXT_DIR__CURRLANG_FILE;

# Path to the "Bash-utils/docs/${__lang}" directory (DO NOT PASS ANY VALUE HERE, it will be done in the main loop).
declare -g __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR;

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### ARRAYS DEFINITIONS

## LATEX FILES LIST

# List of every English files to recreate into each language folder processed by the "${__BU_ARG_LANG_ARRAY}" argument.
declare -agr __BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH=(
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/256-color-palette.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/bin-generation.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/desktop.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/init-locale-file-mk.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/init-locale-file-rm.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/install-dev-env.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/latex-clean.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/latex-compiler.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/latex-convert-to-printable.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/latex-create-document.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/latex-create-file-arch-lang.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/latex-unite.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/lib-compiler-for-all-supported-versions.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/lib-compilerV3.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/lib-compilerV4.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/lib-generator.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/lib-install.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/lib-unite.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/module-add-file-by-OS.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/module-delete-file-by-OS.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/module-install.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/module-mk.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/module-pack.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/module-rm.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_DEVTOOLS_DIR}/mr-clean.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/Hardware/module-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/Aliases-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/ColorsBG-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/Colors-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/ColorsText-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/Exit-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/Filesystem-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/Locale-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/Module-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/Project-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/Status-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/Text-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/main/Time-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_02CONFIG_DIR}/Software/module-conf.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_03INITMODULE_DIR}/Hardware/Initializer.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_03INITMODULE_DIR}/main/Initializer.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_03INITMODULE_DIR}/Software/Initializer.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Args.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/BasicMaths.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Checkings.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/CMDS.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Decho.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/DevTools.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Directories.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Echo.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Errors.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Files.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Filesystem.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Headers.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Inputs.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Locale.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/OS.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/PosixTerm.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Status.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Text.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/TextFormat.tex"
    "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_EN_MODULES_04FUNCTIONS_DIR}/main/Time.tex"
)

# Replacement of the values of the previous arrays into another array which will store the same paths, but with each targeted ISO 639-1 languages codes in mind.

# DO NOT PASS ANY VALUE HERE, it will be done in the main loop.
declare -ag __BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH__LANG=();

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #



# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### CATEGORY NAME

## CHECKINGS

# ··········································································································
# Checking if the script file which runs the Bash code is the "latex-create-file-arch-lang.sh" shell script.

# shellcheck disable=
function BU.DevBin.LCFAL.Function.IsShellScriptLCFAL()
{
    if [[ "${0##*/}" == latex-create-file-arch-lang.?(ba)sh ]]; then return 0; else return 1; fi
}

# ···················································································
# Checking if the script file which runs the Bash code is one of the dev-bin scripts.

# This function simplifies these checkings by avoiding the creation of a new function for each dev-bin script.

# shellcheck disable=
function BU.DevBin.X.Function.IsShellScriptFromDevBin()
{
    if BU.DevBin.LibCompiler.Function.IsShellScriptLCFAL; then
        return 0;
    else
        return 1;
    fi
}

## ==============================================

## FILES

# ···················································································
# Writing the "Bash-utils/docs/00 DATA/txt/${__lang}.tex" content into an empty file.

# shellcheck disable=
function BU.DevBin.LCFAL.Function.WriteData()
{
    #**** Parameters ****
    local p_lang=${1:-$'\0'};   # ARG TYPE : String     # REQUIRED | DEFAULT VAL : NULL     - DESC : ISO 639-1 language code of the data file to process.
    local p_file=${2:-$'\0'};   # ARG TYPE : String     # REQUIRED | DEFAULT VAL : NULL     - DESC : LaTeX source file where the data is to be written.

    #**** Code ****
    # If the file is empty, the basic LaTeX code designed for the targeted language is written inside.
    if [ ! -s "${file}" ]; then
        printf \
            "    -> Empty file, the basic LaTeX code designed for its targeted language (%s%s%s) will be written... " \
            "$(tput setaf 51)" \
            "${__lang}" \
            "$(tput sgr0)";

        __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_00DATA_TXT_DIR__CURRLANG_FILE="${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_DATA_TXT_DIR}/${__lang}.tex";

        if [ -s "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_00DATA_TXT_DIR__CURRLANG_FILE}" ]; then
            if cat "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_00DATA_TXT_DIR__CURRLANG_FILE}" > "${file}"; then
                printf "Success %s✓%s\n" "$(tput setaf 2)" "$(tput sgr0)";
                printf "\n";
            else
                printf "Failed %s❌%s\n" "$(tput setaf 9)" "$(tput sgr0)";

                __BU__BIN__LCFAL__GLOBVARS__ERR__LOOP_ERROR="ERROR";

                break;
            fi
        else
            printf "Empty file %s❌%s\n" "$(tput setaf 9)" "$(tput sgr0)";

            printf "    ";
            printf \
                "    -> The following file will remain empty until the code of the basic LaTeX source file is written : %s%s%s\n\n" \
                "$(tput setaf 51)" \
                "${p_file}" \
                "$(tput sgr0)";
        fi
    fi

    return 0;
}

## ==============================================

## FOLDERS

# ······································
# Creation of the "${__lang}" directory.

# shellcheck disable=
function BU.DevBin.LCFAL.Function.CreateLangDirectory()
{
    #**** Parameters ****
    p_lang=${1:-$'\0'};    # ARG TYPE : String  # REQUIRED | DEFAULT VAL : NULL     - DESC : ISO 639-1 language code of the folder to create.

    #**** Code ****
    if [ ! -d "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}" ]; then
        echo "CREATION OF THE \"${p_lang}\" DIRECTORY";

        echo -en "\nThe \"${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}\" directory does not exists. ";

        read -r -p "Do you want to create it (type 'Y' ONLY if you are sure that you didn't made a typo error) ? (Y/N) " __read_val;
        echo "${__read_val}" >> /dev/null;

        case "${__read_val}" in
            'Y'|'y')
                echo;

                mkdir -p "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}" || {
                    echo "Unable to create the \"${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}\" folder" >&2;
                    echo "End of the exection" >&2;

                    return 1;
                }

                printf "%s✓%s The following folder was successfully created : %s\n" "$(tput setaf 2)" "$(tput sgr0)" "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}";
                ;;
            'N'|'n'|*)
                false;;
        esac

        return 0;
    else
        return 0;
    fi
}

# ···········································
# Sub-folders checking and creation function.

# shellcheck disable=
function BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders()
{
    #**** Parameters ****
    local p_dirpath=${1:-$'\0'};    # ARG TYPE : Dirpath    # REQUIRED | DEFAULT VAL : NULL     - DESC : Path to the sub-folder to check its existence and / or to create.

    #**** Code ****
    if [ -z "${p_dirpath}" ]; then
        echo "No directory path provided to the ${FUNCNAME[0]} function" >&2;

        return 1;
    else
        if [ ! -d "${p_dirpath}" ]; then
            mkdir -p "${p_dirpath}" || {
                echo "Unable to create the \"${p_dirpath}\" folder" >&2;

                return 1;
            };

            printf "%s✓%s The following folder was successfully created : %s\n" "$(tput setaf 2)" "$(tput sgr0)" "${p_dirpath}";
        else
            printf "%s✓%s The following folder already exists : %s\n" "$(tput setaf 2)" "$(tput sgr0)" "${p_dirpath}";

            return 0;
        fi
    fi
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

# Processing each ISO 639-1 codes passed as arguments.
for __lang in "${__BU__BIN__LCFAL__ARGS__LANG_ARRAY[@]}"; do
    #**** Variables ****
    declare -g __BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR="${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_DIR}/${__lang}";

    #**** Code ****

    # Verifying if the language folder exists in the "Bash-utils/docs" directory.
    BU.DevBin.LCFAL.Function.CreateLangDirectory "${__lang}" || exit 1;

    # Assigning the the "${__BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH[@]}" array's indexes to the "${__BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH__LANG[@]}" array.
    __BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH__LANG+=("${__BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH[@]}");

    # Replacing every "Bash-utils/docs/en/" occurences by "Bash-utils/docs/${__lang}/".
    for ((i=0; i<"${#__BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH__LANG[@]}"; i++)); do

        __BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH__LANG["${i}"]="$(BU.Main.Text.ReplaceLettersInString \
                                                                                "${__BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH__LANG[${i}]}" \
                                                                                "Bash-utils/docs/en/" \
                                                                                "all" \
                                                                                "Bash-utils/docs/${__lang}/" \
                                                                            )";
    done

    echo -e "\n";

    # Verifying if every required sub-folder exists in the "Bash-utils/docs/${__lang}" directory.

    # shellcheck disable=SC1003
    echo '\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\';
    echo "CHECKING THE EXISTENCE OF THE REQUIRED SUB-FOLDERS, OR CREATING THEM IF THEY DO NOT EXIST";
    echo;


    # Since the "$(mkdir -p)" command is used in the "BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders()" function, it is possible to directly create the last sub-directories.
    BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}/devtools"                         || exit 1;
    BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}/modules/01) InitScript"           || exit 1;
    BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}/modules/02) Config/Hardware"      || exit 1;
    BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}/modules/02) Config/main"          || exit 1;
    BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}/modules/02) Config/Software"      || exit 1;
    BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}/modules/03) InitModule/Hardware"  || exit 1;
    BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}/modules/03) InitModule/main"      || exit 1;
    BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}/modules/03) InitModule/Software"  || exit 1;
    BU.DevBin.LCFAL.Function.CheckOrCreateSubFolders "${__BU__BIN__LCFAL__GLOBVARS__PATHS__BASHUTILS_DOCS_CURRLANG_DIR}/modules/04) Functions/main"       || exit 1;

    # Creating each LaTeX file into their right sub-folder.
    echo -e "\n";

    # shellcheck disable=SC1003
    echo '\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\';
    echo "CHECKING THE EXISTENCE OF THE LATEX FILES, OR CREATING THEM IF THEY DO NOT EXIST";

    for file in "${__BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH__LANG[@]}"; do
        if [ ! -f "${file}" ]; then
            touch "${file}" || {
                echo "Unable to create the \"${file}\" file" >&2;
                echo "End of the exection" >&2;

                exit 1;
            }

            printf \
                "%s✓%s The following file was successfully created : %s%s%s\n" \
                "$(tput setaf 2)" \
                "$(tput sgr0)" \
                "$(tput setaf 51)" \
                "${file}" \
                "$(tput sgr0)";

            BU.DevBin.LCFAL.Function.WriteData "${__lang}" "${file}";
        else
            printf \
                "%s✓%s The following path and its content already exists : %s%s%s\n" \
                "$(tput setaf 2)" \
                "$(tput sgr0)" \
                "$(tput setaf 51)" \
                "${file}" \
                "$(tput sgr0)";

            BU.DevBin.LCFAL.Function.WriteData "${__lang}" "${file}";
        fi
    done

    if [ -n "${__BU__BIN__LCFAL__GLOBVARS__ERR__LOOP_ERROR}" ] && [ "${__BU__BIN__LCFAL__GLOBVARS__ERR__LOOP_ERROR^^}" == 'ERROR' ]; then
        exit 1;
    fi


    # Emptying the "${__BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH__LANG[@]}" array in case the loop has to be iterated another time.
    unset __BU__BIN__LCFAL__GLOBVARS__PATHS__LATEX_FILES_ARCH__LANG;
done

exit 0;
