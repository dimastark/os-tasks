@echo off

set a=%1
set a |find "/?" >nul

if "%ERRORLEVEL%"=="0" (
  goto help
) else (
  cd %a%>nul 2>nul
  if not %ERRORLEVEL% == 0 (
    mkdir %a% 
    goto main
  ) else (
    echo A folder already exist
    goto main
  )

  :main
    CHCP 1252>nul
    helpgen.cmd /? >> %cd%/%a%/helpgen.txt 2>nul
    for /F "tokens=1" %%i in ('help ^|findstr /B /R "[QWERTYUIOPASDFGHJKLZXCVBNM][QWERTYUIOPASDFGHJKLZXCVBNM]"') do 2>nul (
      if not "%%i"=="SC" (
        if not "%%i"=="GRAFTABL" (
          if not "%%i"=="DISKPART" (
            help %%i >> %cd%/%a%/%%i.txt
          )
        )
      )
    )
)

exit /b

:help
  echo HELP
  echo Writes all help for all commans
  echo Args is a name of folder in current directory
  echo where the files will be written
  echo Dima Starkov 2014
  exit /b
