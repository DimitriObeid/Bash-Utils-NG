#!/usr/bin/env bash

lang="$(echo "${LANG}" | cut -d _ -f1)";

source "${lang}.txt";

echo "${__BU_TEST}";

exit 0;
