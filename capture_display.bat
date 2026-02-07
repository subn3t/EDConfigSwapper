@echo off
setlocal enabledelayedexpansion

REM --- Resolve paths
set "SCRIPT_DIR=%~dp0"
set "PROFILE=%~1"

if "%PROFILE%"=="" (
  echo Usage: capture_display.bat ^<ProfileName^>
  echo Example: capture_display.bat vr
  exit /b 1
)

REM Target profile folder
set "DEST=%SCRIPT_DIR%display\%PROFILE%"

REM Graphics folder source location
set "GRAPHICS_LIVE=%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Graphics"

REM Create display profile folder if it doesn't exist
if not exist "%DEST%" (
  mkdir "%DEST%"
  echo [INFO] Created display profile folder: %PROFILE%
)

echo.
echo === Capture Elite Dangerous Display Settings ===
echo Profile:     %PROFILE%
echo Destination: %DEST%
echo.

REM --- Copy all files from Graphics folder
if exist "%GRAPHICS_LIVE%" (
  copy /Y "%GRAPHICS_LIVE%\*.*" "%DEST%\" >nul
  if errorlevel 1 (
    echo [ERROR] Failed to copy graphics files
    exit /b 3
  )
  echo [OK] Captured display settings to "%PROFILE%" profile.
) else (
  echo [ERROR] Graphics folder not found at: "%GRAPHICS_LIVE%"
  exit /b 4
)

exit /b 0
