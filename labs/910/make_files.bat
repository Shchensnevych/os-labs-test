@echo off
chcp 65001 >nul
rem Створює 24 файли. Параметр 1 - прізвище латиницею
pushd "%USERPROFILE%\lab910_%~1" || exit /b 1
for %%i in (1 2 3) do >f%%i.txt echo FILE%%i
for %%i in (4 5 6) do >f%%i.pas echo FILE%%i
for %%i in (7 8 9) do >f%%i.cpp echo FILE%%i
for %%i in (10 11 12) do >f%%i.bat echo FILE%%i
for %%i in (13 14 15) do >f%%i.exe echo FILE%%i
for %%i in (16 17 18) do >f%%i.gif echo FILE%%i
for %%i in (19 20 21) do >f%%i.com echo FILE%%i
for %%i in (22 23 24) do >f%%i.tmp echo FILE%%i
echo Файлів у корені (очікується 24):
dir /a-d /b | find /c /v ""
popd
exit /b 0
