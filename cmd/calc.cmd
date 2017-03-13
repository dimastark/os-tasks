@echo off

set res=
:loop
  if '%1'=='' goto end
  set a=%1
  set res=%res%%1
  shift
  goto loop
:end
  set res=%res: =%
  set /a res=%res%
  set a=%a:(=%
  set a=%a:)=%
  echo %res%
  echo %a%
  pause
  exit /b
