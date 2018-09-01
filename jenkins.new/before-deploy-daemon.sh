#!/bin/bash

branch_name=$1
branch_name=${branch_name:7}

mypath="/data/daemon/releases/${branch_name}"

if [ ! -d "$mypath" ] ; then
  mkdir -p  "$mypath"
fi

chown -R deploy:deploy $mypath

