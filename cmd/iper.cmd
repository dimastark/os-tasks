@echo off

set a=%1
set a| find "/?" >nul
if %ERRORLEVEL%==0 goto help

for /F "tokens=2 delims=:" %%i in ('"ipconfig | findstr "IPv4""') do (
  set a=%%i
)

set a=%a: =%
set a| find "=" >nul

if %ERRORLEVEL%==0 (
  echo ip not exist
) else (
  echo %a%
)

exit /b

:help
  echo It write your ip
  echo Dima Starkov 2014
  exit /b
