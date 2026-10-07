@echo off
chcp 65001 >nul
cd /d "%~dp0..\labs\78"
call 78_all.bat < NUL
exit /b 0
