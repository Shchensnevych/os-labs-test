@echo off
setlocal
rem Writes WHO ran the task and with WHAT rights to the log.
rem Param 1 - surname (Latin letters), param 2 - task tag (for example T1)
if "%~1"=="" exit /b 1
set "dir=%PUBLIC%\lab1314_%~1"
set "log=%dir%\run.log"
set "tag=%~2"
if not defined tag set "tag=none"
md "%dir%" 2>nul
for /f "delims=" %%u in ('whoami') do set "who=%%u"
set "level=Medium"
whoami /groups | find "S-1-16-12288" >nul && set "level=High"
whoami /groups | find "S-1-16-16384" >nul && set "level=System"
>> "%log%" echo %DATE% %TIME% ^| %tag% ^| %who% ^| %level%
exit /b 0
