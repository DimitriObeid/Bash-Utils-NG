#!/usr/bin/env bash

source "/usr/local/lib/Bash-utils/src/Initializer.sh" || { echo -e "Unable" && exit 1; }

BU.Main.Directories.ProcessingDir "$(BU.Main.Directories.Make "~/Bureau" "Test")"
