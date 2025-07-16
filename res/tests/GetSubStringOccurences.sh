#!/usr/bin/env bash

# https://stackoverflow.com/a/26213117

CommandResult="Interface    Chipset     Driver     mon0    Unknown      iwlwifi - [phy0]wlan0       Unknown     iwlwifi - [phy0]
Interface    Chipset     Driver     mon12    Unknown      iwlwifi - [phy0]wlan0       Unknown     iwlwifi - [phy0]"

InstanceId="iwlwifi";
tmp="${CommandResult//${InstanceId}}";
count="$(((${#CommandResult} - ${#tmp}) / ${#InstanceId}))";

echo "${InstanceId} : ${count}";
