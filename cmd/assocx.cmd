@echo off
setlocal enableDelayedExpansion

set arg=%1
set arg=%arg:.=%
set arg=%arg: =%
set arg|find "/?">nul
if %ERRORLEVEL%==0 goto help

reg query HKCR\.%arg% /ve >nul 2>nul

if %ERRORLEVEL%==1 (
  echo NO
  exit /b
)

for /f "tokens=2 delims=:" %%i in ('chcp') do (
  set code=%%i
)

chcp 862 1>nul

for /f "tokens=2,*" %%h in ('reg query HKCR\.%arg% /ve') do (
  if "%%i" == "(value not set)" (
    echo Nothing
  ) else (
    for /f "delims=" %%a in ('reg query HKCR\%%i /s ^| findstr /R "HKEY_CLASSES_ROOT[\\]%%i[\\][Ss]hell[\\][a-zA-Z ]*[\\][Cc]ommand"') do (
      for /f "tokens=2,* skip=2" %%k in ('reg query "%%a" /ve') do (
        set a=%%a
        set a=!a:HKEY_CLASSES_ROOT=!
        set a=!a:%%i=!
        set a=!a:shell=!
        set a=!a:Shell=!
        set a=!a:\=!
        set a=!a:command=!
        set a=!a:Command=!
        echo !a!:   %%l
      )
    )
  )
)

chcp %code% >nul

exit /b

:help
  echo Assocx
  echo What can you do with file .[arg] extention?
  echo This program will show
  echo Dima Starkov 2014
  exit /b
