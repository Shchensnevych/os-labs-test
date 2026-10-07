@echo off
chcp 65001 >nul
rem Показує, що if errorlevel N перевіряє "код >= N"
call "%~dp0check_env.bat" nobody >nul
echo Код завершення check_env: %ERRORLEVEL%
if errorlevel 1 echo Умова 1: код не менший за 1
if errorlevel 2 echo Умова 2: код не менший за 2
if errorlevel 3 echo Умова 3: код не менший за 3
if %ERRORLEVEL% EQU 2 echo Умова EQU: код дорівнює саме 2
exit /b 0
