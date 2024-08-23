#!/bin/bash

module=$1

upgradeversion=`curl https://api.github.com/repos/Icinga/icingaweb2-module-"$module"/releases 2>&1 | grep tag_name | cut -d v -f 2 | cut -d '"' -f 1 | head -n 1`
version=`icingacli module list 2>&1 | grep $module | cut -d '-' -f 1 |  tr -d -c 0-9.`

if [ -z "$version" ] ; then
  echo "CRITICAL - Site did not respond to version check"
  exit 2

elif [[ "$upgradeversion" =~ "$version" ]] ; then
  echo "OK - $module Icingaweb2 Module version is $version"
  exit 0

else
  echo "Warning - $module Icingaweb2 Module version $version, needs update to $upgradeversion"
  exit 1
fi
