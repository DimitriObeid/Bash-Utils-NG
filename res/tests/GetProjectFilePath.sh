#!/usr/bin/env bash

v_p="${0}";

v_cut=${v_p##*./};
v_cut="$(echo "${v_p}" | cut -)";

llls="$(find "$(cd ..; pwd)" -name "${v_cut}")";

echo "${llls}";
