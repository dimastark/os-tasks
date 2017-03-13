#!/bin/bash

if [[ "$1" == "--help" || "$1" == "-h" || "$1" == "" ]]; then
  echo Work like xxd
  echo dimastark. 2014
else
  exec 3<"$1"
  IFS=""
  LANG=C
  simb=0
  instr=0

  printf "%0.7x: " $simb

  while read -u 3 -d  '' -r -n 1 char; do
    ((simb++))
    ((instr++))

    printf -v value "%02x" "'$char"
    echo -n "$value"
    echo -n ""

    if [[ "$value" < 20 || "$value" > 7e ]]; then
      string+="."
    else
      string+=$char
    fi

    if (( simb % 2 == 0 )); then
      echo -n " "
    fi

    if (( simb % 16 == 0 )); then
      instr=0

      echo " $string"
      printf "%07x: " $simb

      string=''
    fi
  done

  if [[ instr != 0 ]]; then
    (( space=41-2*$instr-$instr/2 ))

    while [[ $space > 0 ]]; do
      ((space--))

      echo -n " "
    done

    echo $string
  fi
fi

