@echo off
setlocal enableDelayedExpansion

set fl=0
set flag=0
set arg=%1

if "%arg%"=="" (
  echo Invalid argument
  exit /b 
)

set arg| find "/?" >nul

if %ERRORLEVEL%==0 goto help
for /f "tokens=1,2 delims=." %%i in ("%arg%") do (
  set ext=.%%j
  set newarg=%%i
)

if "%ext%"=="." (
  set "newpathext=!pathext!" 
) else (
  set "newpathext=!ext!"
)

set newpath=.\;!PATH!

for %%a in (%newpathext%) do 2>nul (
  for %%i in ("!newarg!%%a") do 2>nul (
    if not "%%~$newpath:i"=="" (
      set fl=1
      echo %%~$newpath%:i% 
    )     
  )
)

set path=empty

:NextName
  set Name=%random%
  if exist "%Name%" goto :NextName
  mkdir %Name%
  cd %Name%
  %1 /? 1>nul 2>nul

  if not ERRORLEVEL 9009 (
    echo Command is internal
    cd ..
    rmdir %Name%
    exit /b 
  )

  if "%arg%"=="graftabl" (
    echo Command is internal
    cd ..
    rmdir %Name%
    exit /b 
  )

  if not %fl%==1 echo Command not valid
  cd ..
  rmdir %Name%
  endlocal
  exit /b

:help
  echo Which
  echo Shows type of command 
  echo and path to it, sometime
  echo Dima Starkov 2014
  exit /b
