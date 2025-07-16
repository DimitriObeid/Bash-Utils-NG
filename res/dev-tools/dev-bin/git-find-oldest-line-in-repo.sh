#!/bin/bash

# Github source                 : https://gist.github.com/tclavier/b2991b7836fffbfdb99aa2946c2c5817
# Wayback machine snapshot link : https://web.archive.org/web/20240302231652/https://gist.github.com/tclavier/b2991b7836fffbfdb99aa2946c2c5817

for file in $(find . -type f); do
  git blame --date=format:%Y%m%d $file
done | sed -e 's/.*\s\([0-9]\{8\}\)\s.*/\1/' | sort -r | tail;
