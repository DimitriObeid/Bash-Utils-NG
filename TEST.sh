#!/bin/bash

__msg="Message initial"

trap 'echo "Trap dit : $__msg"' EXIT

__msg="Message modifié"

echo "Script en cours..."

exit 0
