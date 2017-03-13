#!/bin/bash

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  echo Work like my whitch from windows
  echo dimastark. 2014
fi

IFS=:
fl=1

for x in $PATH; do
  if [[ -x $x/$1 && ! -d $x/$1 ]]; then
    echo "$x/$1"
    fl=0
  fi
done

help $1 2>/dev/null | egrep "^$1:"&>/dev/null

if [ "$?" == "0" ]; then
  echo 'This is internal command'
  fl=0
fi

if [ $fl == 1 ]; then
  echo "Not valid command"
fi

