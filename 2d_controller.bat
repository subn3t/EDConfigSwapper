@echo off
setlocal
set "PROFILE=%~n0"
call "%~dp0swap_binds.bat" "%PROFILE%"
endlocal
