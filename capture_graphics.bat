@echo off
setlocal enabledelayedexpansion

REM --- Resolve paths
set "SCRIPT_DIR=%~dp0"
set "PROFILE=%~1"

if "%PROFILE%"=="" (
  echo Usage: capture_graphics.bat ^<ProfileName^>
  echo Example: capture_graphics.bat vr_hotas
  exit /b 1
)

REM Target profile folder - Graphics subfolder
set "DEST=%SCRIPT_DIR%%PROFILE%\Graphics"

REM Graphics folder source location
set "GRAPHICS_LIVE=%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Graphics"

REM Check if profile folder exists
set "PROFILE_DIR=%SCRIPT_DIR%%PROFILE%"
if not exist "%PROFILE_DIR%" (
  echo [ERROR] Profile folder not found: "%PROFILE_DIR%"
  exit /b 2
)

REM Create Graphics subfolder if it doesn't exist
if not exist "%DEST%" (
  mkdir "%DEST%"
  echo [INFO] Created Graphics subfolder
)

echo.
echo === Capture Elite Dangerous Graphics Settings ===
echo Profile:  %PROFILE%
echo Destination: %DEST%
echo.

REM --- Copy all files from Graphics folder
if exist "%GRAPHICS_LIVE%" (
  copy /Y "%GRAPHICS_LIVE%\*.*" "%DEST%\" >nul
  if errorlevel 1 (
    echo [ERROR] Failed to copy graphics files
    exit /b 3
  )
  echo [OK] Captured all graphics settings files
) else (
  echo [ERROR] Graphics folder not found at: "%GRAPHICS_LIVE%"
  exit /b 4
)

echo.
echo [OK] Graphics settings captured to "%PROFILE%" profile.
exit /b 0
