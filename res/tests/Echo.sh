#!/bin/bash

FILE_LOG_NAME="LOG.log";
FILE_LOG_PATH="${FILE_LOG_NAME}";
MAIN_SCRIPT_LOG="";

ROOTPATH="/home/dimob/Projets/Linux-reinstall";

source "${ROOTPATH}/lib/variables/colors.var" && echo true 2>&1 | tee -a "${FILE_LOG_PATH}";
source "${ROOTPATH}/lib/variables/text.var";

source "${ROOTPATH}/lib/functions/Echo.lib";

BU.Main.Echo.Error "Erreur";
BU.Main.Echo.Newline;

MAIN_SCRIPT_LOG="log";
BU.Main.Echo.Newstep "Nouvelle étape" "3";
BU.Main.Echo.Newline;

MAIN_SCRIPT_LOG="tee";
BU.Main.Echo.Success "Succès";
BU.Main.Echo.Newline;

MAIN_SCRIPT_LOG="random";
BU.Main.Echo.Error "Random";
BU.Main.Echo.Newline;

echo test;
