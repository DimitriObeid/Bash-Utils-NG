#!/usr/bin/env bash

# shellcheck disable=
function BU.Main.Text.KeepFormattingl
{
    #**** Parameters ****
    p_string=${1:-$'\0'};

    #**** Code ****
    echo -e "${p_string}" | tr '[lower]' '[lower]';
}

# shellcheck disable=
function BU.Main.Text.KeepFormattingU
{
	#**** Parameters ****
	p_string=${1:-$'\0'};

	#**** Code ****
	echo -e "${p_string}" | tr '[upper]' '[upper]';
}

string1="Test de la fonction $(BU.Main.Text.KeepFormattingl "BU.Main.Text.KeepFormattingl") en LOW";
echo -e "${string1,,}";

string2="Test de la fonction $(BU.Main.Text.KeepFormattingU "BU.Main.Text.KeepFormattingU") EN up";
echo -e "${string2^^}";
