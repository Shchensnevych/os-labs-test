@echo off
setlocal
rem Long task (60 s) for experiments. Param 1 - surname
if "%~1"=="" exit /b 1
set "dir=%PUBLIC%\lab1314_%~1"
md "%dir%" 2>nul
>> "%dir%\long.log" echo %TIME% START
ping -n 61 127.0.0.1 >nul
>> "%dir%\long.log" echo %TIME% END
exit /b 0
