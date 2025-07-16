#!/usr/bin/env bash

__INPUT="original.txt";
__OUTPUT="FileToProcess.txt";

# shellcheck disable=
function RMNewline()
{
    echo;

    echo "Input file :";
    echo;

    cat "${__INPUT}" > "${__OUTPUT}";

    tr --delete '\n' < "${__OUTPUT}";

    tr -d '\n' < "${__OUTPUT}";

    cat "${__INPUT}" > "${__OUTPUT}";

    echo; echo; echo;

    echo "Output file :";
    echo;

    cat "${__OUTPUT}"
}

RMNewline;
