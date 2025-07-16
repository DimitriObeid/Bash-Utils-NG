#!/usr/bin/env bash

debug="/usr/local/lib/Bash-utils/tmp/debug.log";

if [ -f "${debug}" ]; then
	true > "${debug}";
fi

sudo bash -x Linux-reinstall.sh sio >> "${debug}";
