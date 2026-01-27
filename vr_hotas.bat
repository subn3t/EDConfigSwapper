@echo off
setlocal
REM Derive profile name from this file's name (without extension)
set "PROFILE=%~n0"
call "%~dp0swap_binds.bat" "%PROFILE%"
endlocal
