#!/usr/bin/env bash

NB_ARGS=${1:-$'\0'};

p_string='Hello [|] world [|] from [|] Linux [|] Ubuntu';

p_delim=' [|] ';

for ((i=0; i<NB_ARGS; i++)); do
    p_string="${p_string#*"${p_delim}"}";
    tmp_str="${p_string}";

    cut -d : -f 1 <<< "${tmp_str}"

    p_string="${tmp_str}";
done;

echo "${p_string}";
