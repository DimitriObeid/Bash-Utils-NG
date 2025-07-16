#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : latex-convert-to-printable.sh
# Author(s)     : Dimitri OBEID
# Version       : 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# This script creates a printable version of every LaTeX source files.

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

## ISO 639-1 CODES

# List of LaTeX files to modify into the sub-folders located inside the "Bash-utils/docs/01 PRINTABLE" directory.
declare -ag __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBARRAYS=();

# Array of ISO 639-1 codes.
declare -agr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBARRAYS__LANG_ARRAY=('ab' 'aa' 'af' 'ak' 'sq' 'am' 'ar' 'an' 'hy' 'as' 'av' 'ae' \
                                                                            'ay' 'az' 'bm' 'ba' 'eu' 'be' 'bn' 'bi' 'bs' 'br' 'bg' 'my' \
                                                                            'ca' 'ch' 'ce' 'ny' 'zh' 'cu' 'cv' 'kw' 'co' 'cr' 'hr' 'cs' \
                                                                            'da' 'dv' 'nl' 'dz' 'en' 'eo' 'et' 'ee' 'fo' 'fj' 'fi' 'fr' \
                                                                            'fy' 'ff' 'gd' 'gl' 'lg' 'ka' 'de' 'el' 'kl' 'gn' 'gu' 'ht' \
                                                                            'ha' 'he' 'hz' 'hi' 'ho' 'hu' 'is' 'io' 'ig' 'id' 'ia' 'ie' \
                                                                            'iu' 'ik' 'ga' 'it' 'ja' 'jv' 'kn' 'kr' 'ks' 'kk' 'km' 'ki' \
                                                                            'rw' 'ky' 'kv' 'kg' 'ko' 'kj' 'ku' 'lo' 'la' 'lv' 'li' 'ln' \
                                                                            'lt' 'lu' 'lb' 'mk' 'mg' 'ms' 'ml' 'mt' 'gv' 'mi' 'mr' 'mh' \
                                                                            'mn' 'na' 'nv' 'nd' 'nr' 'ng' 'ne' 'no' 'nb' 'nn' 'ii' 'oc' \
                                                                            'oj' 'or' 'om' 'os' 'pi' 'ps' 'fa' 'pl' 'pt' 'pa' 'qu' 'ro' \
                                                                            'rm' 'rn' 'ru' 'se' 'sm' 'sg' 'sa' 'sc' 'sr' 'sn' 'sd' 'si' \
                                                                            'sk' 'sl' 'so' 'st' 'es' 'su' 'sw' 'ss' 'sv' 'tl' 'ty' 'tg' \
                                                                            'ta' 'tt' 'te' 'th' 'bo' 'ti' 'to' 'ts' 'tn' 'tr' 'tk' 'tw' \
                                                                            'ug' 'uk' 'ur' 'uz' 've' 'vi' 'vo' 'wa' 'cy' 'wo' 'xh' 'yi' \
                                                                            'yo' 'za' 'zu');

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### VARIABLES DEFINITIONS

## COUNTERS

# Counting the total number of folders copied into the "Bash-utils/docs/01 PRINTABLE" directory.
declare -gi __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__COUNTERS__COPIED_FOLDERS_INTO_PRINTABLE_DIR=0;

# Counting the total number of files found into the sub-folders located inside the "Bash-utils/docs/01 PRINTABLE" directory.
declare -gi __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__COUNTERS__FOUND_FILES_INTO_PRINTABLE_SUB_FOLDERS_DIR=0;

## ==============================================

## PATHS

# Path to the "Bash-utils/" directory.
declare -g      __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__BASH_UTILS_DIR;
                __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__BASH_UTILS_DIR="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path" || echo "Unable to get the path to the \"Bash-utils\" folder" >&2; exit 1)";
    readonly    __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__BASH_UTILS_DIR;

# Path to the "Bash-utils/docs/" folder.
declare -gr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__BASH_UTILS_DOCS_DIR="${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__BASH_UTILS_DIR}/docs";

# Path to the destination folder, located in "Bash-utils/docs/".
declare -gr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__DEST_DIR="${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__BASH_UTILS_DOCS_DIR}/01 PRINTABLE";

## ==============================================

## RANDOM DATA PROCESSING

# Storing the name of the currently processed folder.
declare -g __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__DATA__CURRENT_FOLDER_NAME;

# Authorization to copy the currently processed folder into the "01 PRINTABLE" directory.
declare -g __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__DATA__CURRENT_FOLDER_AUTH;

## ==============================================

## STRINGS TO PROCESS IN THE PRINTABLE LATEX FILES

# Storing the original value of the "xcolor" LaTeX package's option.
declare -gr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__O_XCOLOR_OPT='\\usepackage\[usenames,svgnames\]{xcolor}                      %';

# Storing the original value of the document background color value.
declare -gr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__O_DOC_BKG_COL_VAL='\\definecolor{back}{HTML}{000000}';

# Storing the original value of the document text color value.
declare -gr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__O_DOC_TXT_COL_VAL='\\definecolor{text}{HTML}{ffffff}';

# Storing the original relative path to the "00 DATA" data directory.
declare -gr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__O_00DATA_PATH_VAL='\\includegraphics\[scale=\([0-9]\{1,\}\.[0-9]\{4\}\)\]{\.\./\.\./00 DATA/';

# Storing the new value of the "xcolor" LaTeX package's option.
declare -gr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__N_XCOLOR_OPT='\\usepackage[usenames,dvipsnames]{xcolor}                    %';

# Storing the new value of the document background color value.
declare -gr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__N_DOC_BKG_COL_VAL='\\definecolor{back}{HTML}{ffffff}';

# Storing the new value of the document text color value.
declare -gr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__N_DOC_TXT_COL_VAL='\\definecolor{text}{HTML}{000000}';

# Storing the new relative path to the "00 DATA" data directory.
declare -gr __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__N_00DATA_PATH_VAL='\\includegraphics[scale=\1]{../../../00 DATA/';

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

if [ ! -d "${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__DEST_DIR}" ]; then
    mkdir -p -v "${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__DEST_DIR}" || exit 1;
fi

# Copying every documentation folders by languages into the "01 PRINTABLE" folder.
for ISOFolder in "${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__BASH_UTILS_DOCS_DIR}"/*/; do
    __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__DATA__CURRENT_FOLDER_NAME="$(basename "${ISOFolder}")";

    __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__DATA__CURRENT_FOLDER_AUTH=false;

    # Checking if the currently processed directory has a valid ISO 639-1 code as a name.
    for validISOFolder in "${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBARRAYS__LANG_ARRAY[@]}"; do
        if [ "${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__DATA__CURRENT_FOLDER_NAME,,}" == "${validISOFolder,,}" ]; then
            __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__DATA__CURRENT_FOLDER_AUTH=true;

            break;
        fi
    done

    # Copying the currently processed directory into the "Bash-utils/docs/01 PRINTABLE" directory.
    if [ "${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__DATA__CURRENT_FOLDER_AUTH,,}" == true ]; then
        cp -r "${ISOFolder}" "${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__DEST_DIR}" || exit 1;

        # Incremeting the counter of copied folders by 1.
        (( __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__COUNTERS__COPIED_FOLDERS_INTO_PRINTABLE_DIR++ ));
    fi
done

mapfile -t __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBARRAYS < <(find "${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__PATHS__DEST_DIR}" -type f -name "*.tex")

# Rewriting every strings which have to be modified, like the RGB to CMYK, the defined colors for the document backgroud and the text, and the path to the "00 DATA" folder.
for filepath in "${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBARRAYS[@]}"; do
    # Incremeting the counter of files found into the sub-folders located inside the "Bash-utils/docs/01 PRINTABLE" directory by 1;
    (( __BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__COUNTERS__FOUND_FILES_INTO_PRINTABLE_SUB_FOLDERS_DIR++ ));

    # Modifying the line where the "xcolor" package is called, in order to use the CYMK model, which is better for the impression.
    sed -i \
        "s/${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__O_XCOLOR_OPT}/${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__N_XCOLOR_OPT}/g" \
        "${filepath}";

    # Modifying the "back" color code.
    sed -i \
        "s/${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__O_DOC_BKG_COL_VAL}/${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__N_DOC_BKG_COL_VAL}/g" \
        "${filepath}";

    # Modifying the "text" color code.
    sed -i \
        "s/${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__O_DOC_TXT_COL_VAL}/${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__N_DOC_TXT_COL_VAL}/g" \
        "${filepath}";

    # Modifying the relative path to the "00 DATA" folder.
    sed -i \
        "s|${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__O_00DATA_PATH_VAL}|${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__STRINGS__N_00DATA_PATH_VAL}|g" \
        "${filepath}";

done

echo "Total number of LaTeX files converted into a printable format : ${__BU__BIN__LATEX_CONVERT_TO_PRINTABLE__GLOBVARS__COUNTERS__FOUND_FILES_INTO_PRINTABLE_SUB_FOLDERS_DIR}";

exit 0;
