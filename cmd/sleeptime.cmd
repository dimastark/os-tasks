@echo off

set arg=%*
set nowtime=%time%
set s=%nowtime:~6,2%
set arg| find "/?" >nul

if %ERRORLEVEL%==0 goto help

echo %arg%|findstr /R "[^0123456789]" >nul 2>&1

if not ERRORLEVEL 1 (
  echo Invalid argument
  exit /b
)

:start
  if %arg%==0 (
    echo  
    exit /b
  )
  if %s%==59 (
    set s=00 
  ) else (
    set /A s=%s%+1 2>nul
  )

:circle
  set ntime=%time%
  set nt=%ntime:~6,2%
  echo %nt%|findstr /R "0[1-9]" >nul 2>&1

  if not ERRORLEVEL 1 (
    set nt=%nt:0=%
  )
  if %s% LEQ %nt% (
    set /A arg=%arg%-1 2>nul
    goto start
  ) else goto circle

:help
  echo SLEEPer
  echo Sleep [arg] seconds
  echo if first number is zero, this sleep ZERO sec
  echo Dima Starkov 2014
  exit /b
