#!/bin/bash

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  echo Signal processing
  echo And show beautiful frame
  echo dimastark. 2014
else
  y=`tput lines`
  x=`tput cols`

  for up in `seq 1 $x`; do
    echo -en "\e[44m \e[0m"
  done

  echo ""

  for up in `seq 3 $y`; do
    echo -en "\e[44m \e[0m"
    for up in `seq 3 $x`; do
      echo -en " "
    done
    echo -e "\e[44m \e[0m"
  done

  for up in `seq 1 $x`; do
    echo -en "\e[44m \e[0m"
  done

  for i in `seq 1 64`; do
    trap "echo -en '\e[$(($y/2));$(($x/2))f\e[0m $i '" $i
  done

  read
fi

