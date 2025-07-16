#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : lib-unite.sh
# Author(s)     : Dimitri OBEID
# Version       : Beta 1.0


# -----------------
# FILE DESCRIPTION :

# This script unites every Bash source files of the framework in a single file, in order to get the total size of the whole project in bytes,
# number of characters, of words, of columns and lines.

# This script is different from the "lib-compilerV3/-bu.sh" script, because it compiles every translation files, instead of the needed ones in a localized file,
# plus this script is older than the compiler. Actually, the new compiler was builded with many bits from this script.

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

## DELETION AUTHORIZATIONS

# ARG TYPE : String
# OPTIONAL
# DEFAULT VAL : NULL

# DESC : Authorization to delete the generated file.
declare -gr __BU__BIN__LIB_UNITE__ARGS__STABLE_FILES_HOME_DIR_ARG_RM="${1:-$'\0'}";

# ARG TYPE : String
# OPTIONAL
# DEFAULT VAL : NULL

# DESC : Delete empty lines.
declare -gr __BU__BIN__LIB_UNITE__ARGS__DEL_EMPTY_LINES="${2:-$'\0'}";

# ARG TYPE : String
# OPTIONAL
# DEFAULT VAL : NULL

# DESC : Delete comments that are not on the same line as a piece of code.
declare -gr __BU__BIN__LIB_UNITE__ARGS__BU_ARG_DEL_LINE_COMMENTS="${3:-$'\0'}";

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

# Getting the path of the library's root path from the path file.
if [ -d '/usr/local/lib/Bash-utils' ]; then 
    declare -gr __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR='/usr/local/lib/Bash-utils';

elif [ -d "${HOME}/.Bash-utils/Bash-utils" ]; then 
    declare -gr __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR="${HOME}/.Bash-utils/Bash-utils";

else 
    declare -g      __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR;
                    __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path")";
        readonly    __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR;

    if [ ! -d "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}" ]; then
        # shellcheck disable=SC2059
        printf "ERROR : THE %s FOLDER DOESN'T EXISTS !!!\n" "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}" >&2;
        echo "Please check the existence of the root directory of the Bash Utils library." >&2;
        echo >&2;

        exit 1;
    fi
fi

# Path of the modules initializer file.
declare -gr __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE="${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/Bash-utils.sh";

declare -gr __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES="${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/Bash-utils-nolines.sh";

declare -gr __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE="${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/Bash-utils-no-line-comments--base.sh";

declare -gr __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES="${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/Bash-utils-no-line-comments--no-lines.sh";

# Path of the modules initialization script's translations files.
declare -gr __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__CONFIGS_PATH="${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/install/.Bash-utils/config/initializer";

# Path of the modules initialization script's translations files.
declare -gr __BU__BIN__LIB_UNITE__GLOBVARS__PATHS__TRANSLATIONS_PATH="${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__CONFIGS_PATH}/locale";

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### WRITING TEXT

## WRITING LINES

# ···························································
# Printing a line according to the terminal's columns number.

# shellcheck disable=
function PrintLine()
{
    __cols="$(tput cols)"

	for _ in $(eval echo -e "{1..${__cols}}"); do
            printf '-';
    done; printf "\n";
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### MATHS

## RAW BYTE SIZE TO HUMAN-READABLE BYTE SIZE

# Converts a byte count to a human readable format in IEC binary notation (base-1024 (eg : GiB)), rounded to two decimal places for anything larger than a byte. Switchable to padded format and base-1000 (eg : MB) if desired.

# Initial source of this AWK script (since it's not mine and I added more informations as comments) :
# https://unix.stackexchange.com/questions/44040/a-standard-tool-to-convert-a-byte-count-into-human-kib-mib-etc-like-du-ls1/98790#98790
function BytesToHuman()
{
    #**** Parameters ****
    local L_BYTES="${1:-0}";    # Int       - Default : 0       - Raw size in bytes.
    local L_PAD="${2:-no}";     # String    - Default : "no"    - Allow result display padding.
    local L_BASE="${3:-1024}";  # Int       - Default : 1024    - Base (1000 (metric) or 1024 (binary notation))

    #**** Code ****
    # Creating a command substitution to calculate the byte count according to the values passed as arguments, with an AWK script.
    local BYTESTOHUMAN_RESULT; BYTESTOHUMAN_RESULT=$(awk -v bytes="${L_BYTES}" -v pad="${L_PAD}" -v base="${L_BASE}" 'function human(x, pad, base) {

        # If the desired base format is not the binary prefix, then the base format used will be the metric one.
         if(base!=1024)base=1000

        # Ternary condition : if the base format uses the binary prefix, then the "iB" ([prefix]bibyte) unit is displayed after the value. Else the "[prefix]byte" unit is displayed after the value.
         basesuf=(base==1024)?"iB":"B"

        # Setting the prefixes list (K = kilo, M = mega, G = giga, T = tera, P = peta, E = exa, Z = zeta, Y = yotta), and corrected the inversion of the Exa with Peta, and Zeta with Yotta.
         s="BKMGTPEZY"

        # While the "x" ("human" function first parameter value) is superior or equal to the "base" (human function third parameter value) AND
         while (x>=base && length(s)>1)
               {x/=base; s=substr(s,2)}
         s=substr(s,1,1)

         xf=(pad=="yes") ? ((s=="B")?"%5d   ":"%8.2f") : ((s=="B")?"%d":"%.2f")
         s=(s!="B") ? (s basesuf) : ((pad=="no") ? s : ((basesuf=="iB")?(s "  "):(s " ")))

         return sprintf( (xf " %s\n"), x, s)
      }
      BEGIN{print human(bytes, pad, base)}')

    printf "%s" "${BYTESTOHUMAN_RESULT}";

    return 0;
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### FILES PROCESSING

## PRINTING FILE'S CONTENT

# function BU.Main.Echo.Newline { local iterations="${1}"; for ((i=0; i<iterations; i++)); do echo -e "" | tee -a "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}"; done; }
function CatBU { cat "${1}" | tee -a "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" || { echo "UNABLE TO DISPLAY THE ${1} FILE'S CONTENT ! Please check its path and if it exists."; exit 1; }; }
function EchoBU { echo -e "# ${1}" | tee -a "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" || { echo "UNABLE TO WRITE THE ${1} FILE'S CONTENT ! Please check its path and if it exists."; exit 1; }; }



# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

# Checking if the "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" file exists or not. The file is created if not.
if [ ! -f "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" ]; then
	touch "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}";
fi

# Checking if the "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" file is empty or not. The file is emptied if not.
if [ -s "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" ]; then
	true > "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}";
fi

# Path of the modules initialization script's configuration files.
for i in "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__CONFIGS_PATH}/"*.conf; do
    # BU.Main.Echo.Newline '2';
    EchoBU "${i^^}";

    #BU.Main.Echo.Newline "1"';
    CatBU "${i}";
done

# Path of the modules initialization script's translations files.
for i in "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__TRANSLATIONS_PATH}/"*.locale; do
    # BU.Main.Echo.Newline '2';
    EchoBU "${i^^}";

    #BU.Main.Echo.Newline "1"';
    CatBU "${i}";
done

# Processing the modules initializer file.
EchoBU "${HOME}/Bash-utils-init.sh"; # BU.Main.Echo.Newline '1';
CatBU "${HOME}/Bash-utils-init.sh";

# Processing the function files.
for i in "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__BASH_UTILS_ROOT_DIR}/lib/functions/main/"*.lib; do
	# BU.Main.Echo.Newline '2';
    EchoBU "${i^^}";

    #BU.Main.Echo.Newline "1"';
    CatBU "${i}";
done

# Processing the modules configuration files.
for i in "${HOME}/.Bash-utils/config/modules/main/"*.conf; do
	# BU.Main.Echo.Newline '2';
    EchoBU "${i^^}";

    # BU.Main.Echo.Newline "1"';
    CatBU "${i}";
done

# Processing the modules files.
for i in "${HOME}/.Bash-utils/modules/main/"*; do
	# BU.Main.Echo.Newline '2';
    EchoBU "${i^^}";

    # BU.Main.Echo.Newline "1"';
    CatBU "${i}";
done

# Processing the remaining files.
# Nothing to process for now.

PrintLine;

echo "Library statistics :"; echo;

echo "Size in bytes           : $(BytesToHuman "$(wc -c < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}")" '' 1000)";
echo "Number of characters    : $(wc -m < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}") characters";
echo "Number of lines         : $(wc -l < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}") lines";
echo "Maximum display width   : $(wc -L < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}") columns";
echo "Number of words         : $(wc -w < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}") words";

# Deleting the empty lines if the awaited value is passed as script's second argument.
if [ "${__BU__BIN__LIB_UNITE__ARGS__DEL_EMPTY_LINES,,}" == 'rmlines' ]; then
    echo;

    cat "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" | sed '/^[[:space:]]*$/d' > "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}";

    PrintLine;

    echo "Library statistics (without newlines) :"; echo;

    echo "Size in bytes           : $(BytesToHuman "$(wc -c < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}")" '' 1000)";
    echo "Number of characters    : $(wc -m < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}") characters";
    echo "Number of lines         : $(wc -l < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}") lines";
    echo "Maximum display width   : $(wc -L < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}") columns";
    echo "Number of words         : $(wc -w < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}") words";
fi

# Deleting the comments in the "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" file that are not on the same line as a piece of code, if the awaited value is passed as script's third argument.
if [ "${__BU__BIN__LIB_UNITE__ARGS__BU_ARG_DEL_LINE_COMMENTS,,}" == 'rmcomments-base' ]; then
    echo;

    if [ -f "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" ]; then
        cat "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" | awk '!/^[[:blank:]]*#.*shellcheck/ && /^[[:blank:]]*#/ {next} {print}' "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" > "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE}";

        rm "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}";

        PrintLine;

        echo "Library statistics (with empty lines and without line comments) :"; echo;

        echo "Size in bytes           : $(BytesToHuman "$(wc -c < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE}")" '' 1000)";
        echo "Number of characters    : $(wc -m < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE}") characters";
        echo "Number of lines         : $(wc -l < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE}") lines";
        echo "Maximum display width   : $(wc -L < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE}") columns";
        echo "Number of words         : $(wc -w < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE}") words";
    fi
fi

# Deleting the comments in the "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}" file that are not on the same line as a piece of code, if the awaited value is passed as script's third argument.
if [ "${__BU__BIN__LIB_UNITE__ARGS__BU_ARG_DEL_LINE_COMMENTS,,}" == 'rmcomments-lines' ]; then
    echo;

    if [ -f "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}" ]; then
        cat "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}" | awk '!/^[[:blank:]]*#.*shellcheck/ && /^[[:blank:]]*#/ {next} {print}' "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}" > "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES}";

        rm "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}";

        PrintLine;

        echo "Library statistics (without empty lines and line comments) :"; echo;

        echo "Size in bytes           : $(BytesToHuman "$(wc -c < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES}")" '' 1000)";
        echo "Number of characters    : $(wc -m < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES}") characters";
        echo "Number of lines         : $(wc -l < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES}") lines";
        echo "Maximum display width   : $(wc -L < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES}") columns";
        echo "Number of words         : $(wc -w < "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES}") words";
    fi

fi

# Deleting the generated file if the awaited value is passed as script's first argument.
if [ "${__BU__BIN__LIB_UNITE__ARGS__STABLE_FILES_HOME_DIR_ARG_RM,,}" == 'rm' ]; then
    if rm "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE}"; then
        echo ; echo "The generated « ${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE} » file was successfully deleted";
    else
        echo >&2; echo "Unable to delete the generated « ${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE} » file" >&2; exit 1;
    fi

    if [ -f "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}" ]; then if rm "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES}"; then
        echo; echo "The generated « ${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES} » file was successfully deleted";
    else
        echo >&2; echo "Unable to delete the generated « ${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_EMPTYLINES} » file" >&2; exit 1;
    fi; fi

    if [ -f "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE}" ]; then if rm "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE}"; then
        echo; echo "The generated « ${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE} » file was successfully deleted";
    else
        echo >&2; echo "Unable to delete the generated « ${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__BASE} » file" >&2; exit 1;
    fi; fi

    if [ -f "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES}" ]; then if rm "${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES}"; then
        echo; echo "The generated « ${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES} » file was successfully deleted";
    else
        echo >&2; echo "Unable to delete the generated « ${__BU__BIN__LIB_UNITE__GLOBVARS__PATHS__FULL_LIB_FILE_NO_LINE_COMMENTS__NO_LINES} » file" >&2; exit 1;
    fi; fi
fi

exit 0;
