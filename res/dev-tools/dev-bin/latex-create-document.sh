#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : latex-create-document.sh
# Author(s)     : Dimitri OBEID
# Version       : Beta 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# This script creates a ".tex" file.

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### SOURCING PROJECT'S DEPENDENCIES ###########################################

#### BASH DEPENDENCIES

## BASH UTILS

# shellcheck disable=SC1090,SC1091
if ! source "${HOME}/Bash-utils-init.sh"; then
    echo >&2; echo -e "In $(basename "${0}"), line $(( LINENO - 1 )) --> Error : unable to source the modules initializer file." >&2; echo >&2; exit 1;
fi

# Calling the "BashUtils_InitModules()" function.
if ! BashUtils_InitModules \
    "module --log-display --mode-log-partial" \
    "main --stat-debug=false stat-error=fatal --stat-log=true --stat-log-r=tee --stat-time-txt=1 --stat-txt-fmt=true" \

    then
	    echo >&2; echo "In $(basename "${0}"), line $(( LINENO - 1 )) --> Error : something went wrong while calling the « BashUtils_InitModules() » function" >&2; echo >&2; exit 1;
fi

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

############################################# GLOBAL RESOURCES DEFINITION #############################################

########################################### PROJECT'S ARGUMENTS DEFINITIONS ###########################################

#### POSITIONAL ARGUMENTS

## LANGUAGE

# ARG TYPE : ISO 639-1 Code
# REQUIRED
# DEFAULT VAL : NULL
# DESC : Targeted language
__ARG_LANG=${1:-$'\0'};

## ==============================================

## DOCUMENT TYPE

# ARG TYPE : String
# REQUIRED
# DEFAULT VAL : NULL
# DESC : Type of document (master documentation, configurations, module initializer resources or library functions).
__ARG_TYPE=${2:-$'\0'};

## ==============================================

## FILE NAME

# ARG TYPE : String
# REQUIRED
# DEFAULT VAL : NULL
# DESC : Name of the file to create.
__ARG_FILENAME=${3:-$'\0'};

## ==============================================

## AUTHOR'S NAME

# ARG TYPE : String
# REQUIRED
# DEFAULT VAL : NULL
# DESC : Author's name
__ARG_AUTHOR=${4:-$'\0'};

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

## LANGUAGES ARRAYS

# Supported languages array.
__LATEX_CREATE_DOC__SUPPORTED_LANGUAGES=('en (English)' 'fr (French | Français)');

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### VARIABLES DEFINITIONS

## PATHS

# Script's resources directory.
__LATEX_CREATE_DOC__RES_DIR="${__BU_MAIN_MODULE_DEVTOOLS_SRC}/${__BU_MAIN_PROJECT_NAME}";

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### FUNCTIONS DEFINITIONS

## LANGUAGES PROCESSING

# ································
# Listing the supported languages.

# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# Featured function(s) and file(s) by module(s) and from the "functions" folder :
#   - BU.Main.Echo.Newstep()            -> Main -> Echo.lib

# shellcheck disable=oc_ListLanguages()
{
    BU.Main.Echo.Newstep "Currently supported languages --> English (en), French (fr)";

    for i in "${__LATEX_CREATE_DOC__SUPPORTED_LANGUAGES[@]}"; do
        echo "  - ${i}";
    done
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

BU.Main.Echo.Newstep "In which language do you want to write your LaTeX document ?";
LatexCreateDoc_ListLanguages;
BU.Main.Echo.Newline;

read -rp "Please type the wanted language's code from one of the above parenthesis : " __read_lang;
BU.Main.Echo.Read "${__read_lang}";
BU.Main.Echo.Newline;

## ==============================================

## PROCESSING THE DOCUMENTATION'S LANGUAGE

if [[ "${__read_lang}" =~ ${__LATEX_CREATE_DOC__SUPPORTED_LANGUAGES[*]} ]]; then
	# shellcheck disable=SC2016
	BU.Main.Errors.HandleErrors "1" "THE $(BU.Main.Decho.Decho.Error '$__read_doc_name')'S VARIABLE'S VALUE $(DechoHighlightError "${__read_lang}") IS INCORRECT" \
        "$(LatexCreateDoc_ListLanguages)" "${__read_lang}" "$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}" "$(( LINENO - 1 ))";

elif [[ "${__ARG_LANG}" =~ ${__LATEX_CREATE_DOC__SUPPORTED_LANGUAGES[*]} ]]; then
# shellcheck disable=SC2016
	BU.Main.Errors.HandleErrors "1" "THE FIRST LANGUAGE'S ARGUMENT VALUE IS INCORRECT ($(BU.Main.Decho.Decho.Error "${__ARG_LANG}"))" \
        "$(LatexCreateDoc_ListLanguages)" "${__read_lang}" "$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}" "$(( LINENO - 1 ))";

else

    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ PROCESSING THE TARGET DIRECTORY
    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	#***** Target paths variables definition.
	__target_path_master="${__read_lang}";
	__target_path_module="${__target_path_master}/modules";

	__target_path_initscript="${__target_path_module}/01) ScriptInit";
	__target_path_config="${__target_path_module}/02) Config";
	__target_path_init="${__target_path_module}/03) Init";
	__target_path_main_functions="${__target_path_module}/04) Functions";

	__target_path_tutos="${__target_path_master}/tutos";

	# If no type of document is passed as second argument
    if [ -z "${__ARG_TYPE}" ]; then
        #***** Asking for the new document's path.
        BU.Main.Echo.Newstep "What kind of document do you want to write ?";
        BU.Main.Echo.Msg "1 - Master documentation                       $(BU.Main.Decho.Green "Targeted folder") --> $(BU.Main.Decho.Decho.Path "${__target_path_master}")";
        BU.Main.Echo.Msg "2 - Module general documentation               $(BU.Main.Decho.Green "Targeted folder") --> $(BU.Main.Decho.Decho.Path "${__target_path_module}")";
        BU.Main.Echo.Msg "3 - Module initializer script's documentation  $(BU.Main.Decho.Green "Targeted folder") --> $(BU.Main.Decho.Decho.Path "${__target_path_initscript}")";
        BU.Main.Echo.Msg "4 - Module configuration documentation         $(BU.Main.Decho.Green "Targeted folder") --> $(BU.Main.Decho.Decho.Path "${__target_path_config}")";
        BU.Main.Echo.Msg "5 - Module initializer documentation           $(BU.Main.Decho.Green "Targeted folder") --> $(BU.Main.Decho.Decho.Path "${__target_path_init}")";
        BU.Main.Echo.Msg "6 - Main functions documentation               $(BU.Main.Decho.Green "Targeted folder") --> $(BU.Main.Decho.Decho.Path "${__target_path_main_functions}")";
        BU.Main.Echo.Newline;

        BU.Main.Echo.Msg "7 - Tutorials documentation                    $(BU.Main.Decho.Green "Targeted folder") --> $(BU.Main.Decho.Decho.Path "${__target_path_tutos}")";

    	read -rp "Please type the number corresponding to the wanted document category : " __read_folder_code;
        BU.Main.Echo.Read "${__read_folder_code}";
        BU.Main.Echo.Newline;

    elif [ -n "${__ARG_TYPE}" ]; then
        __read_folder_code="${__ARG_TYPE}";
    fi

    # If the wanted folder doesn't exists yet.
    if [ ! -d "${__read_folder_code}" ]; then

        EchoMsg "[ INFO ] The chosen folder doesn't exists yet";
        EchoNewstep "Creating the $(BU.Main.Decho.Decho.Highlight "${__read_folder_code}") target folder";

        #***** Verifying if the given code is valid.
        lineno_case_read_folder_is_valid="${LINENO}"; case "${__read_folder_code}" in
            1) BU.Main.Directories.Make "${__BU_MAIN_MODULE_DOCS_DIR_PATH}" "${__target_path_master}" && __folder_path="${__BU_MAIN_MODULE_DOCS_DIR_PATH}/${__target_path_master}";;
            2) BU.Main.Directories.Make "${__BU_MAIN_MODULE_DOCS_DIR_PATH}" "${__target_path_master}" && __folder_path="${__BU_MAIN_MODULE_DOCS_DIR_PATH}/${__target_path_module}";;
            3) BU.Main.Directories.Make "${__BU_MAIN_MODULE_DOCS_DIR_PATH}" "${__target_path_initscript}" && __folder_path="${__BU_MAIN_MODULE_DOCS_DIR_PATH}/${__target_path_initscript}";;

            4) BU.Main.Directories.Make "${__BU_MAIN_MODULE_DOCS_DIR_PATH}" "${__target_path_config}" && __folder_path="${__BU_MAIN_MODULE_DOCS_DIR_PATH}/${__target_path_config}";;
            5) BU.Main.Directories.Make "${__BU_MAIN_MODULE_DOCS_DIR_PATH}" "${__target_path_init}" && __folder_path="${__BU_MAIN_MODULE_DOCS_DIR_PATH}/${__target_path_init}";;
            6) BU.Main.Directories.Make "${__BU_MAIN_MODULE_DOCS_DIR_PATH}" "${__target_path_main_functions}" && __folder_path="${__BU_MAIN_MODULE_DOCS_DIR_PATH}/${__target_path_main_functions}";;

            7) BU.Main.Directories.Make "${__BU_MAIN_MODULE_DOCS_DIR_PATH}" "${__target_path_tutos}" && __folder_path="${__BU_MAIN_MODULE_DOCS_DIR_PATH}/${__target_path_tutos}";;
            *)
                if [ -n "${__ARG_TYPE}" ]; then
                    BU.Main.Errors.HandleErrors "1" "THE SECOND ARGUMENT'S VALUE (${__ARG_TYPE}) IS INVALID" \
                        "Please type an integer value ranging from 1 to 7" "${__read_folder_code}" "$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}" "${lineno_case_read_folder_is_valid}";

                else
                    # shellcheck disable=SC2016
                    BU.Main.Errors.HandleErrors "1" "THE $(BU.Main.Decho.Decho.Error "${__read_doc_name}")'s ENTERED VALUE IS INVALID" \
                        "Please type an integer value ranging from 1 to 7" "${__read_folder_code}" "$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}" "${lineno_case_read_folder_is_valid}";
                fi
                ;;
        esac

        EchoSuccess "The $(DechoHighlightPath "${__read_folder_code}") folder was successfully created";
    fi

    #~ ~~~~~~~~~~~~~~~~~~~~~~~
    #~ PROCESSING THE NEW FILE
    #~ ~~~~~~~~~~~~~~~~~~~~~~~

	if [ -z "${__ARG_FILENAME}" ]; then
        BU.Main.Echo.Newstep "How do you want to name your document ?";
        read -rp "Enter the file's name (don't add a ''.tek'' extension, this script will complete it) : " __read_doc_name;

        BU.Main.Echo.Read "${__read_doc_name}";

        if [ -z "${__read_doc_name}" ]; then
            # shellcheck disable=SC2016
            BU.Main.Errors.HandleErrors "1" "THE $(BU.Main.Decho.E '$__read_doc_name')'s VARIABLE IS EMPTY" \
                "Please type a valid name according to your filesystem accepted values" "${__read_doc_name}" "$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}" "$(( LINENO - 3 ))";
        fi

        __tex_full_path="${__folder_path}/${__read_doc_name}";
    else
        __tex_full_path="${__folder_path}/${__ARG_FILENAME}";
    fi

    BU.Main.Echo.Newstep "Creating the $(BU.Main.Decho.Decho.Path "${__tex_full_path}") file";
    BU.Main.Echo.Newline;

    __

	# BU.Main.Files.Make "${__folder_path}" "${__read_doc_name}.tex" && BU.Main.Echo.Success "Your LaTeX file ($(BU.Main.Decho.Decho.Path "${__tex_full_path}")) was successfully created.";
    lineno_case_copy_file="${LINENO}"; case "${__read_folder_code}" in
        1) BU.Main.Files.MakePath "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/packages.txt" > "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/master.txt" >> "${__tex_full_path}";;
        2) BU.Main.Files.MakePath "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/packages.txt" > "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/module-general.txt" >> "${__tex_full_path}";;
        3) BU.Main.Files.MakePath "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/packages.txt" > "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/module-init-main.txt" >> "${__tex_full_path}";;

        4) BU.Main.Files.MakePath "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/packages.txt" > "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/module-config.txt" >> "${__tex_full_path}";;
        5) BU.Main.Files.MakePath "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/packages.txt" > "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/module-init-each.txt" >> "${__tex_full_path}";;
        6) BU.Main.Files.MakePath "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/packages.txt" > "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/module-functions.txt" >> "${__tex_full_path}";;

        7) BU.Main.Files.MakePath "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/packages.txt" > "${__tex_full_path}"; cat "${__LATEX_CREATE_DOC__RES_DIR}/${__read_lang}/tutorials-general.txt" >> "${__tex_full_path}";;
    esac

	## TODO : PUT THE USER'S KEYBOARD INPUTS AS DOCUMENT'S TITLE, AUTHOR'NAME AND SUBJECT. ALSO WRITE THE YEAR.

    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~ PROCESSING THE DOCUMENT'S TITLE
    #~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    if [ -z "${__ARG_AUTHOR}" ]; then
        read -rp "$(EchoNewstep Please enter your full name : )" __read_author_name;

        BU.Main.Echo.Read "${__read_author_name}";

        __tex_author="${__read_author_name}";
    else
        __tex_author="${__ARG_AUTHOR}";
    fi

    # Writing the author's name in the created file.



    #~ ~~~~~~~~~~~~~~
    #~ PROCESSING THE
    #~ ~~~~~~~~~~~~~~

	exit 0;
fi
