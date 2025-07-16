#!/usr/bin/env bash

filename="$(basename "${BASH_SOURCE[0]}")";

echo "Current file name with extension : ${filename}";
echo;

echo "Current file name without extension: ${filename%%.sh*}";

exit 0;
