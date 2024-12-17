set TITLE=nistAutoSearch

TITLE %title%
@echo off

cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION   
echo              _      __                 __                                     __  
echo       ____  (_)____/ /_   ____ ___  __/ /_____     ________  ____ ___________/ /_ 
echo      / __ \/ / ___/ __/  / __ `/ / / / __/ __ \   / ___/ _ \/ __ `/ ___/ ___/ __ \
echo     / / / / (__  ) /_   / /_/ / /_/ / /_/ /_/ /  (__  )  __/ /_/ / /  / /__/ / / /
echo    /_/ /_/_/____/\__/   \__,_/\__,_/\__/\____/  /____/\___/\__,_/_/   \___/_/ /_/ 
echo.
                                                     
setlocal enabledelayedexpansion
echo Welcome to %title%

    echo Starting...
    set "rscript=%~dp0\nistAutoSearch.R" 
    echo. 

rem define if R.exe is installed and use its path to launch script.R
for /r "c:\Program Files" %%F in (*Rscript.exe*) do (
	"%%~fF" "%rscript%" %*

	rem msg * /time:4  "Succeeded"
    rem Echo x=msgbox^("finished running",64,""^)>"%temp%\msg.vbs"
	rem start %temp%\msg.vbs
	pause
    @echo off
    echo restarting...
    echo. 
	timeout 1 >nul
  	goto :start
)
echo ---%title% error---
echo.
echo Rscript.exe not found. 
echo You need to install R or you have to make sure it is installed in: 'C:\Program Files\'
echo Check for details on the webpage https://github.com/CreMoProduction/
echo.  
echo.
set /p choice="Do you want to download R? (Y/N): "
if /i "%choice%"=="Y" (
    start "R downloader" "%~dp0\res\R downloader.exe"
) else (
    echo Canceled.
    pause
    echo close in 2 seconds
    timeout 2 >nul
    goto :eof
)

    exit /b