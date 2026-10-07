@echo off
setlocal
rem Scheduled backup with a log. Param 1 - surname
if "%~1"=="" exit /b 1
set "base=%PUBLIC%\lab1314_%~1"
set "src=%base%\source"
set "dst=%base%\backup"
set "log=%base%\backup.log"
if not exist "%src%\" exit /b 2
robocopy "%src%" "%dst%" /e /njh /njs /ndl /nfl /np >nul
set "rc=%ERRORLEVEL%"
set "msg=OK"
if %rc% GEQ 8 set "msg=ERROR"
>> "%log%" echo %DATE% %TIME% ^| rc=%rc% ^| %msg%
if %rc% GEQ 8 exit /b %rc%
exit /b 0
