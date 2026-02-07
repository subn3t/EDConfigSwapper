@echo off
setlocal enabledelayedexpansion

REM --- Resolve paths
set "SCRIPT_DIR=%~dp0"
set "PROFILE=%~1"

if "%PROFILE%"=="" (
  echo Usage: swap_controls.bat ^<ProfileName^>
  echo Example: swap_controls.bat hotas
  exit /b 1
)

REM Source profile folder: controls subfolder
set "SRC=%SCRIPT_DIR%controls\%PROFILE%"

REM Live ED bindings folder
set "LIVE=%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Bindings"

if not exist "%SRC%" (
  echo [ERROR] Controls profile folder not found: "%SRC%"
  exit /b 2
)

if not exist "%LIVE%" (
  echo [INFO] Live bindings folder not found, creating: "%LIVE%"
  mkdir "%LIVE%" 2>nul
)

echo.
echo === Elite Dangerous Controls Swap ===
echo Profile:  %PROFILE%
echo Source:   %SRC%
echo Live:     %LIVE%
echo.

REM --- Completely empty the LIVE folder (files and subfolders)
pushd "%LIVE%" || (echo [ERROR] Could not enter LIVE folder & exit /b 3)
  del /q /f *.* 2>nul
  for /d %%D in (*) do rd /s /q "%%D"
popd

REM --- Copy the contents of the profile folder into LIVE
robocopy "%SRC%" "%LIVE%" /E /NFL /NDL /NJH /NJS /NP >nul
set "RC=%ERRORLEVEL%"

if %RC% GEQ 8 (
  echo [ERROR] Robocopy failed with code %RC%.
  exit /b %RC%
)

echo [OK] Controls profile "%PROFILE%" applied.
exit /b 0
