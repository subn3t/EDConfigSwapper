@echo off
setlocal enabledelayedexpansion

REM --- Resolve paths
set "SCRIPT_DIR=%~dp0"
set "PROFILE=%~1"

if "%PROFILE%"=="" (
  echo Usage: capture_controls.bat ^<ProfileName^>
  echo Example: capture_controls.bat hotas
  exit /b 1
)

REM Target profile folder
set "DEST=%SCRIPT_DIR%controls\%PROFILE%"

REM Bindings folder source location
set "BINDINGS_LIVE=%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Bindings"

REM Create controls profile folder if it doesn't exist
if not exist "%DEST%" (
  mkdir "%DEST%"
  echo [INFO] Created controls profile folder: %PROFILE%
)

echo.
echo === Capture Elite Dangerous Control Bindings ===
echo Profile:     %PROFILE%
echo Destination: %DEST%
echo.

REM --- Copy all files from Bindings folder
if exist "%BINDINGS_LIVE%" (
  copy /Y "%BINDINGS_LIVE%\*.*" "%DEST%\" >nul
  if errorlevel 1 (
    echo [ERROR] Failed to copy bindings files
    exit /b 3
  )
  echo [OK] Captured control bindings to "%PROFILE%" profile.
) else (
  echo [ERROR] Bindings folder not found at: "%BINDINGS_LIVE%"
  exit /b 4
)

exit /b 0
