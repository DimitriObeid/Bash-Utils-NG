#!/usr/bin/env bash

while IFS=, read -r col1 col2;
do
    echo -e "${col1} | ${col2}";
done < "/home/dimob/Projets/Bash-utils/lib/lang/lang.csv";
