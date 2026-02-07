@echo off
setlocal enabledelayedexpansion

REM --- Resolve paths
set "SCRIPT_DIR=%~dp0"
set "PROFILE=%~1"

if "%PROFILE%"=="" (
  echo Usage: swap_display.bat ^<ProfileName^>
  echo Example: swap_display.bat vr
  exit /b 1
)

REM Source profile folder: display subfolder
set "SRC=%SCRIPT_DIR%display\%PROFILE%"

REM Live ED graphics folder
set "LIVE=%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Graphics"

if not exist "%SRC%" (
  echo [ERROR] Display profile folder not found: "%SRC%"
  exit /b 2
)

if not exist "%LIVE%" (
  echo [INFO] Live graphics folder not found, creating: "%LIVE%"
  mkdir "%LIVE%" 2>nul
)

echo.
echo === Elite Dangerous Display Swap ===
echo Profile:  %PROFILE%
echo Source:   %SRC%
echo Live:     %LIVE%
echo.

REM --- Copy graphics settings (overwrite existing)
copy /Y "%SRC%\*.*" "%LIVE%\" >nul
if errorlevel 1 (
  echo [ERROR] Failed to copy display settings
  exit /b 3
)

echo [OK] Display profile "%PROFILE%" applied.
exit /b 0
