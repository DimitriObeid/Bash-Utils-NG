#!/usr/bin/env bash

mkfifo fifo

cat /dev/null < fifo | fifo > source ../../lib/variables/text.var

rm fifo
