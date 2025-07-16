#!/usr/bin/env bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : lib-debug.sh
# Author(s)     : Dimitri OBEID
# Version       : 1.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# This script comments and uncomments the lines where the "BU.Main.Echo.Debug()" and "BU.Main.Echo.DebugEnd()" functions are called
# in order to avoid always calling them for nothing if the script main script is not running with the framework's debugging features.

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### SOURCING PROJECT'S DEPENDENCIES ###########################################

#### BASH DEPENDENCIES

## BASH UTILS

# Including the "Bash-utils/lib/functions/main/Text.lib" file's code in order to use the "()" function.
source "$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path")/lib/functions/main/Text.lib" || exit 1;

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

############################################# GLOBAL RESOURCES DEFINITION #############################################

########################################### PROJECT'S ARGUMENTS DEFINITIONS ###########################################

#### POSITIONAL ARGUMENTS

## ARGUMENTS DEFINITION

# ARG TYPE : String
# REQUIRED
# DEFAULT VAL : NULL

# DESC : Stores the "comment" or "uncomment" string passed by the end user.
declare -gr __BU__BIN__LIB_DEBUG__ARGS__ACTION=${1:-$'\0'};

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### ARRAY OF ARGUMENTS

## EXECUTABLE FILES GENERATOR ARRAY OF ARGUMENTS

# Feel free to define an array of arguments here if needed.

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################## PROJECT'S GLOBAL VARIABLES DEFINITIONS #######################################

#### ARRAYS DEFINITIONS

## FILES PATH BY DIRECTORY

# Storing the paths to each files of a processed directory.
declare -ag __BU__BIN__LIB_DEBUG__GLOBARRAYS__PATHS__FILES_PATHS=();

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### VARIABLES DEFINITIONS

## ERRORS MANAGERS

#
declare -g __BU__BIN__LIB_DEBUG__GLOBVARS__ERROR;

## ==============================================

## MESSAGES

declare -gr __BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING="Terminating the ${0} script execution";

## ==============================================

## PATHS

# Path to the "Bash-utils" root folder.
declare -g 		__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_DIR;
				__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_DIR="$(cat "${HOME}/.Bash-utils/Bash-utils-root-val.path" || { echo "Missing path file"; exit 1; })";
	readonly	__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_DIR;

# Path to the "${HOME}/.Bash-utils/config/modules/" folder.
declare -gr __BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__HOME_DOTBASHUTILS_CONFIG_MODULES_DIR="${HOME}/.Bash-utils/config/modules";

# Path to the "Bash-utils/lib/functions" folder.
declare -gr __BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_LIB_FUNCTIONS_DIR="${__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_DIR}/lib/functions";

# Path to the "Bash-utils/res/devtools/dev-res/lib-debug" folder, which contains the strings to search (no regexes were finally used, since they are a real
# pain in the ass to correctly implement with these strings (look at the commits from Feb. 15/16 2024 to understand how much I sweated blood to implement them)).
declare -gr __BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_RES_DEVTOOLS_DEVRES_DIR="${__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_DIR}/res/dev-tools/dev-res/lib-debug";

# Path to the "Bash-utils/res/devtools/dev-res/lib-debug/${current_module}" folder (only used for specific modules).
declare -g __BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_RES_DEVTOOLS_DEVRES_CURRMODULE_DIR;

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

########################################### PROJECT'S FUNCTIONS DEFINITIONS ###########################################

#### FUNCTIONS DEFINITION

## ERRORS MANAGERS

# ·····················································································
# Checking if the script file which runs the Bash code is the "lib-debug" shell script.

# shellcheck disable=
function BU.DevBin.LibDebug.Function.IsShellScriptLibDebug()
{
	if [[ "${0##*/}" == lib-debug.?(ba)sh ]]; then return 0; else return 1; fi
}

# ···················································································
# Checking if the script file which runs the Bash code is one of the dev-bin scripts.

# This function simplifies these checkings by avoiding the creation of a new function for each dev-bin script.

# shellcheck disable=
function BU.DevBin.X.Function.IsShellScriptFromDevBin()
{
    if BU.DevBin.LibCompiler.Function.IsShellScriptLibDebug; then
        return 0;
    else
        return 1;
    fi
}

## ==============================================

## FILE EDITION

# ·············································································································
# Comment or uncomment the "BU.Main.Echo.Debug/End()" functions in the file currently processed by this script.

# shellcheck disable=
function BU.DevBin.LibDebug.Function.CommentOrUncomment()
({
	#**** Parameters ****
	local p_file=${1:-$'\0'};   		# ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : This variable stores the path to the file to process.
	local p_action=${2:-$'\0'};   		# ARG TYPE : String     - REQUIRED | DEFAULT VAL : NULL     - DESC : This variable stores the name of the action to do.

	#**** Variables ****
	local v_4_commented_spaces;			# VAR TYPE : String		- DESC : The commented 4 spaced call of the "BU.Main.Echo.Debug()" function.
	local v_8_commented_spaces;			# VAR TYPE : String		- DESC : The commented 8 spaced call of the "BU.Main.Echo.Debug()" function.
	local v_4_uncommented_spaces;		# VAR TYPE : String		- DESC : The uncommented 4 spaced call of the "BU.Main.Echo.Debug()" function.
	local v_8_uncommented_spaces;		# VAR TYPE : String		- DESC : The uncommented 8 spaced call of the "BU.Main.Echo.Debug()" function.

	local v_has_4_commented_spaces;		# VAR TYPE : String		- DESC :
	local v_has_8_commented_spaces;		# VAR TYPE : String		- DESC :
	local v_has_4_uncommented_spaces;	# VAR TYPE : String		- DESC :
	local v_has_8_uncommented_spaces;	# VAR TYPE : String		- DESC :

	local v_has_4_commented_spaces_oc;	# VAR TYPE : String		- DESC : Number of occurences of the call of a commented "BU.Main.Echo.Debug()" function.
	local v_has_8_commented_spaces_oc;	# VAR TYPE : String		- DESC : Number of occurences of the call of a commented "BU.Main.Echo.Debug()" function.
	local v_has_4_uncommented_spaces_oc;# VAR TYPE : String		- DESC : Number of occurences of the call of an uncommented "BU.Main.Echo.Debug()" function.
	local v_has_8_uncommented_spaces_oc;# VAR TYPE : String		- DESC : Number of occurences of the call of an uncommented "BU.Main.Echo.Debug()" function.

	#**** Code ****
	v_4_commented_spaces="$(cat "${__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_RES_DEVTOOLS_DEVRES_DIR}/commented/4.txt")";
	v_8_commented_spaces="$(cat "${__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_RES_DEVTOOLS_DEVRES_DIR}/commented/8.txt")";
	v_4_uncommented_spaces="$(cat "${__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_RES_DEVTOOLS_DEVRES_DIR}/uncommented/4.txt")";
	v_8_uncommented_spaces="$(cat "${__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_RES_DEVTOOLS_DEVRES_DIR}/uncommented/8.txt")";

	# Helping the user by writing the regexes' debugging code in a single function which must be commented if no regex are being tested.
	function TestRegex()
	{
		echo "${v_4_commented_spaces}";
		echo "${v_4_commented_spaces}";
		echo "${v_8_uncommented_spaces}";
		echo "${v_8_uncommented_spaces}";
	}

	# Writing the [[:space:]] pattern a certain number of times in a regex's raw string.
	function S() { local p_i=${1:-0}; for ((i=0; i<p_i;i++)); do printf "[[:space:]]"; done; }

	# Separating the file parsing code in an other function in order to help with the regex debugging procedure by avoiding commenting the following lines.
	function BU.DevBin.LibDebug.Function.CommentOrUncomment.ParseAndEditFile()
	{
		#**** Code ****
 		if		[ "${p_action,,}" == 'comment' ]; then
 			if grep -F "${v_4_uncommented_spaces}" "${p_file}" > /dev/null; then
				v_has_4_uncommented_spaces='true';

				# Getting the number of occurences of
				v_has_4_commented_spaces_oc="$(grep -c '^[[:space:]][[:space:]][[:space:]][[:space:]]BU\.Main\.Echo\.Debug[[:space:]]*\\' "${p_file}" | wc -l)";
				echo "${v_has_4_commented_spaces_oc}";
			fi

#  			if grep -Eo "${v_8_uncommented_spaces}" "${p_file}" | wc -l; then
# 				v_has_8_uncommented_spaces='true';
#  			fi

 		elif	[ "${p_action,,}" == 'uncomment' ]; then
			if grep -Fo "${v_4_commented_spaces}" "${p_file}" | wc -l; then
				v_has_4_commented_spaces='true';
 			fi

 			if grep -Fo "${v_4_commented_spaces}" "${p_file}" | wc -l; then
				v_has_4_commented_spaces='true';
 			fi
 		fi

		return 0;
	}

	if [ -z "${p_file}" ]; then
		echo "ERROR : Missing file path for the ${FUNCNAME[0]}() function's first argument" >&2;
		echo >&2;

		echo "${__BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING}" >&2;
		echo >&2;

		return 1;
	else
		if [ ! -f "${p_file}" ]; then
			echo "ERROR : Unexistent file path passed to the ${FUNCNAME[0]}() function as first argument" >&2;
			echo >&2;

			echo "${__BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING}" >&2;
			echo >&2;

			return 1;
		else
			if [ -z "${p_action}" ]; then
				echo "ERROR : No action passed to the ${FUNCNAME[0]}() function as second argument" >&2;
				echo >&2;

				echo "${__BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING}" >&2;
				echo >&2;

				return 1;
			else
				if [ "${p_action,,}" != 'comment' ] && [ "${p_action,,}" != 'uncomment' ]; then
					echo "ERROR : Bad action passed to the ${FUNCNAME[0]}() function as second argument" >&2;
					echo >&2;

					echo "${__BU__BIN__BIN_GENERATION__GLOBVARS__MSG_E__TERMINATING}" >&2;
					echo >&2;

					return 1;
				else
					if		[ "${p_action,,}" == 'comment' ]; then
						# TestRegex;

						BU.DevBin.LibDebug.Function.CommentOrUncomment.ParseAndEditFile || return 1;

						# sed -i -E "/${v_unc_pattern}/ s/^[[:space:]]/#^[[:space:]]/" "${p_file}";

					elif	[ "${p_action,,}" == 'uncomment' ]; then
						echo "Hello from \"${FUNCNAME[0]}()\" uncomment";
					fi

					return 0;
				fi
			fi
		fi
	fi
})

## ==============================================

## FILES PATH

# ········································································································
# Processing the listing of every directories, then their modules-specific subfolders and their own files.

# shellcheck disable=
function BU.DevBin.LibDebug.Function.GetDirectoriesPaths()
{
	#**** Parameters ****
	local p_dirpath=${1:-$'\0'};	# ARG TYPE : Dirpath	- REQUIRED | DEFAULT VAL : NULL     - DESC : This variable stores the path to the directories containing module folders.

	#**** Code ****
	find "${p_dirpath}" -mindepth 1 -maxdepth 1 -type d | while read -r subfolder; do

		[ -z "${__BU__BIN__LIB_DEBUG__GLOBARRAYS__PATHS__FILES_PATHS[*]}" ] && declare -ga __BU__BIN__LIB_DEBUG__GLOBARRAYS__PATHS__FILES_PATHS;

		__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_RES_DEVTOOLS_DEVRES_CURRMODULE_DIR="${__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_RES_DEVTOOLS_DEVRES_DIR}/$(BU.Main.Text.GetLastFieldAfterDelim "${subfolder}" '/')";

		while IFS= read -r file; do
			__BU__BIN__LIB_DEBUG__GLOBARRAYS__PATHS__FILES_PATHS+=("${subfolder}/${file}");
		done < <(ls -p "${subfolder}" | grep -v '/');

		for file in "${__BU__BIN__LIB_DEBUG__GLOBARRAYS__PATHS__FILES_PATHS[@]}"; do
			BU.DevBin.LibDebug.Function.CommentOrUncomment "${file}" "${__BU__BIN__LIB_DEBUG__ARGS__ACTION}" || { __BU__BIN__LIB_DEBUG__GLOBVARS__ERROR='error'; break 2; };
		done

		unset __BU__BIN__LIB_DEBUG__GLOBARRAYS__PATHS__FILES_PATHS;
	done

	if [ -n "${__BU__BIN__LIB_DEBUG__GLOBVARS__ERROR}" ]; then return 1; fi

	return 0;
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

# TESTING PURPOSES ONLY !! Please leave this line commented if you are not planning to add and test new features in the "BU.DevBin.LibDebug.Function.CommentOrUncomment()" function.
BU.DevBin.LibDebug.Function.GetDirectoriesPaths "${__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_DIR}/res/tests/lib-debug" || shift && exit 1; exit 0;


# Comment or uncomment the "BU.Main.Echo.Debug/End()" functions in the "${HOME}/.Bash-utils/config/modules/" folder.
BU.DevBin.LibDebug.Function.GetDirectoriesPaths "${__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__HOME_DOTBASHUTILS_CONFIG_MODULES_DIR}" || shift && exit 1;

# Comment or uncomment the "BU.Main.Echo.Debug/End()" functions in the "Bash-utils/lib/functions/${module_name}" folder.
BU.DevBin.LibDebug.Function.GetDirectoriesPaths "${__BU__BIN__LIB_DEBUG__GLOBVARS__PATHS__BASHUTILS_LIB_FUNCTIONS_DIR}" || shift && exit 1;

exit 0;


















# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

################################################ ARCHIVING LEGACY CODE ################################################

# ARCHIVING OLD / LEGACY CODE, WHICH MAY HELP IN THE FUTURE FOR A DIFFERENT APPROACH IN THIS FILE OR IN OTHER FILES, PLEASE DO NOT DELETE THE ABOVE "exit 0" INSTRUCTION !

debug_tmp_f="tmp/debug.tmp";
debug_log="tmp/final_debug_file.dbg";

if [ -f "${debug_tmp_f}" ]; then
	true > "${debug_tmp_f}";
else
	if [ ! -d "tmp" ]; then
		mkdir -p "tmp";
	fi

	touch "${debug_tmp_f}";
fi

bash -x LibTest.sh 2>&1 | tee -a "${debug_tmp_f}";

# shellcheck disable=
function BU.EchoDbg()
{
	echo -e "${1}" >> "${debug_log}";
}

if [ -s "${debug_tmp_f}" ]; then
	if [ ! -f "${debug_log}" ]; then
		touch "${debug_log}";
	else
		true > "${debug_log}";
	fi

	i=0

    # shellcheck disable=SC2002
	cat "${debug_tmp_f}" | while read -r line; do

        # shellcheck disable=SC2016
		if line='++++ for _ in $(eval echo -e "{1..${__BU_MAIN_TXT_COLS}}")\n++++ echo -n -'; then
			for _ in ${#line}; do
				line="$(echo -e "${line}\b")";
				BU.EchoDbg "${line}";
			done; BU.EchoDbg "\b";
		fi

		echo "${line}" >> "${debug_log}";
	done
fi
