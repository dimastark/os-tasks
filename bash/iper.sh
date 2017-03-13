#!/bin/bash

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  echo Display your IPs
  echo It all, that this programm does
  echo dimastark. 2014
else
  ifconfig \
    | grep -Eo 'inet addr:([0-9]*\.){3}[0-9]*' \
    | grep -Eo '([0-9]*\.){3}[0-9]*' \
    | grep -v '127.0.0.1' || echo no ip adresses
fi

