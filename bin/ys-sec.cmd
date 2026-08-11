@echo off
setlocal
set "ROOT=%~dp0.."
set "YS_SEC_CMD=%~1"
if "%YS_SEC_CMD%"=="" set "YS_SEC_CMD=help"
set "YS_SEC_A=%~2"
set "YS_SEC_B=%~3"
set "YS_SEC_C=%~4"
set "YS_SEC_SERVICE=0"
set "YS_SEC_JSON=0"
set "YS_SEC_OUT="

:parse
if "%~5"=="" goto run
if /I "%~5"=="--service" set "YS_SEC_SERVICE=1"
if /I "%~5"=="--json" set "YS_SEC_JSON=1"
if /I "%~5"=="-o" set "YS_SEC_OUT=%~6"
shift
goto parse

:run
ys "%ROOT%\ys-sec.y"
set "RC=%ERRORLEVEL%"
endlocal & exit /b %RC%
