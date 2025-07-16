#!/usr/bin/env bash

source "${HOME}/.bash_profile";

__ROOT_DIR="${HOME}/Projets/Bash-utils";

source "${__ROOT_DIR}/lib/functions/main/Checkings.lib" || { echo "Fail Checkings.lib"; exit 1; }
source "${__BU_MAIN_CONF_FILE_TEXT}" # || { echo "Fail text.conf"; exit 1; }
source "${__BU_MAIN_CONF_FILE_COLORS}" || { echo "Fail colors.conf"; exit 1; }

# shellcheck disable=
function D_Array()
{
	#**** Parameters ****
	local p_string=${1:-$'\0'};
	local p_newcolor=${2:-$'\0'};
	shift 2;

	local pa_formatting;

	#**** Code ****
    pa_formatting=$("${@}");

	for val in "${pa_formatting[@]^^}"; do
		case "${val}" in
			'Blink')
				echo -ne "";
				;;
			'Bold')
				echo -ne "${__BU_MAIN_TXT_FMT_BOLD}";
				;;
			'D')
				;;
			'I')
				;;
			'S')
				;;
			'U')
				;;
			*)
				echo "Invalid value"; exit 1;
				;;
		esac
	done

	echo "${p_string}${p_newcolor}${__BU_MAIN_TXT_RESET}";
}

D_Array 'Test' '166' 'Blink' 'Bold' 'C';
