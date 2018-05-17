#!/bin/bash

branch_name=$1
branch_name=${branch_name:4}

mypath="/data/api/releases/${branch_name}"

if [ ! -d "$mypath" ] ; then
  mkdir -p  "$mypath"
fi

chown -R deploy:deploy $mypath

