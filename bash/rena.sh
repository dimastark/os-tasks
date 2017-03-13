#!/bin/bash

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  echo Rename
  echo It renames
  echo DimaS. 2014
else
  if test -d $1; then
    cd $1

    AllDir() {
      for x in `ls`; do
        if test -d $x; then
          cd $x
          AllDir
          cd ..
        else
          st=`echo $x | grep -Eo ".elf"`
          st2=`echo $x | grep -Eo ".sh"`
          if [[ $st == $st2 ]]; then
            echo there
            a=`file $x | grep -Eo 'shell script'`
            b=`file $x | grep -Eo 'ELF'`
            if [[ $a == "shell script" ]]; then
              mv $x "$x.sh"
            else
              if [[ $b == "ELF" ]]; then
                mv $x "$x.elf"
              fi
            fi
          fi
        fi
      done
    }

    AllDir
  fi
fi

