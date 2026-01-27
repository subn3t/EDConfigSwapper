@echo off
setlocal enabledelayedexpansion

REM --- Resolve paths
set "SCRIPT_DIR=%~dp0"
set "PROFILE=%~1"

if "%PROFILE%"=="" (
  echo Usage: swap_binds.bat ^<ProfileName^>
  echo Example: swap_binds.bat VR_hotas
  exit /b 1
)

REM Source profile folder: a sibling of this script, named exactly like the profile
set "SRC=%SCRIPT_DIR%%PROFILE%"

REM Live ED bindings folder (note: this is under LOCALAPPDATA, not roaming APPDATA)
set "LIVE=%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Bindings"

REM Graphics folder location
set "GRAPHICS_FOLDER=%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Graphics"

if not exist "%SRC%" (
  echo [ERROR] Profile folder not found: "%SRC%"
  exit /b 2
)

if not exist "%LIVE%" (
  echo [INFO] Live bindings folder not found, creating: "%LIVE%"
  mkdir "%LIVE%" 2>nul
)

echo.
echo === Elite Dangerous Bindings Swap ===
echo Profile:  %PROFILE%
echo Source:   %SRC%
echo Live:     %LIVE%
echo.

REM --- 1) Completely empty the LIVE folder (files and subfolders)
pushd "%LIVE%" || (echo [ERROR] Could not enter LIVE folder & exit /b 3)
  REM Delete files (quietly), ignore errors if none exist
  del /q /f *.* 2>nul
  REM Delete subdirectories
  for /d %%D in (*) do rd /s /q "%%D"
popd

REM --- 2) Copy the contents of the profile folder into LIVE (excluding Graphics subfolder)
REM Use ROBOCOPY for robust copy; treat return codes 0-7 as success
robocopy "%SRC%" "%LIVE%" /E /XD Graphics /NFL /NDL /NJH /NJS /NP >nul
set "RC=%ERRORLEVEL%"

if %RC% GEQ 8 (
  echo [ERROR] Robocopy failed with code %RC%.
  exit /b %RC%
)

echo [OK] Bindings applied.

REM --- 3) Copy graphics settings if they exist in the profile's Graphics subfolder
set "GRAPHICS_SRC=%SRC%\Graphics"

if exist "%GRAPHICS_SRC%" (
  if not exist "%GRAPHICS_FOLDER%" mkdir "%GRAPHICS_FOLDER%"

  REM Copy all graphics files from profile to live folder
  copy /Y "%GRAPHICS_SRC%\*.*" "%GRAPHICS_FOLDER%\" >nul
  if errorlevel 1 (
    echo [WARNING] Failed to copy graphics settings
  ) else (
    echo [OK] Graphics settings applied.
  )
) else (
  echo [INFO] No Graphics folder in profile - skipping graphics settings.
)

echo.
echo [OK] Profile "%PROFILE%" fully applied.
exit /b 0
