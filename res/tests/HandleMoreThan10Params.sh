#!/usr/bin/env bash

# shellcheck disable=
function BU.Main.Locale.PrintLanguageName.Optimize()
{
	#**** Parameters ****
	local p_code=${1:-NULL};    # ARG TYPE : ISO 639-1 code			- REQUIRED | DEFAULT VAL : NULL		- DESC : ISO 639-1 code of the language in which the file must be translated.
    local p_print_code=${2:-yes};   	# ARG TYPE : Bool			- REQUIRED | DEFAULT VAL : yes     	- DESC : Authorization to print the ISO 639-1 code before the language name.

    local p_langNameUser=${3:-NULL};	# ARG TYPE : String			- REQUIRED | DEFAULT VAL : NULL		- DESC : Name of the targeted langauge in the user's system language.
	local p_langNameEngl=${4:-NULL};	# ARG TYPE : String			- REQUIRED | DEFAULT VAL : NULL		- DESC : Name of the targeted langauge in English.
	local p_langNameOrig=${5:-NULL};	# ARG TYPE : String			- REQUIRED | DEFAULT VAL : NULL		- DESC : Name of the targeted langauge in its own language.

	local p_dispOrder=${6:-NULL};		# ARG TYPE : String			- OPTIONAL | DEFAULT VAL : NULL		- DESC : Display order of the language's name in its own language, in English or in the user's system language.
    local p_print_code=${7:-yes};   	# ARG TYPE : Bool			- OPTIONAL | DEFAULT VAL : yes     	- DESC : Authorization to print the ISO 639-1 code before the language name.

    local p_disable_fromYourLang=${8:-false};	# ARG TYPE : Bool	- OPTIONAL | DEFAULT VAL : false	- DESC : Enabling or disabling the displaying of the language's name in the user's language.
    local p_disable_englishNamed=${9:-false};	# ARG TYPE : Bool	- OPTIONAL | DEFAULT VAL : false	- DESC : Enabling or disabling the displaying of the language's name in English.
    local p_disable_originalName=${10:-false};	# ARG TYPE : Bool	- OPTIONAL | DEFAULT VAL : false	- DESC : Enabling or disabling the displaying of the language's name in its own language.

    #**** Variables ****
    # local i;

	#**** Code ****
    echo "ARG VAL 1  : ${p_code}";
    echo "ARG VAL 2  : ${p_print_code}";
    echo "ARG VAL 3  : ${p_langNameUser}";
    echo "ARG VAL 4  : ${p_langNameEngl}";
    echo "ARG VAL 5  : ${p_langNameOrig}";
    echo "ARG VAL 6  : ${p_dispOrder}";
    echo "ARG VAL 7  : ${p_print_code}";
    echo "ARG VAL 8  : ${p_disable_fromYourLang}";
    echo "ARG VAL 9  : ${p_disable_englishNamed}";
    echo "ARG VAL 10 : ${p_disable_originalName}";

	return 0;
}

BU.Main.Locale.PrintLanguageName.Optimize;
