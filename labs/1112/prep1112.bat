@echo off
chcp 65001 >nul
rem Створює тестове дерево lab1112_<прізвище>. Параметр 1 - прізвище латиницею
if "%~1"=="" (
  echo [ПОМИЛКА] Вкажіть прізвище: prep1112.bat prizvyshche
  exit /b 1
)
for /f "eol=a delims=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" %%a in ("%~1") do (
  echo [ПОМИЛКА] Прізвище має містити лише латинські літери.
  exit /b 3
)
rd /s /q "%USERPROFILE%\lab1112_%~1" 2>nul
md "%USERPROFILE%\lab1112_%~1"
pushd "%USERPROFILE%\lab1112_%~1" || exit /b 2
md d1 d2 d3
md d1\d11 d1\d12 d1\d13
md d2\d21 d2\d22 d2\d23
md d2\d22\d221 d2\d22\d222 d2\d22\d223
md d3\d31 d3\d32 d3\d33
md d3\d33\d331 d3\d33\d332 d3\d33\d333
for %%i in (1 2 3) do >f%%i.txt echo FILE%%i
for %%i in (4 5 6) do >f%%i.pas echo FILE%%i
for %%i in (7 8 9) do >f%%i.cpp echo FILE%%i
for %%i in (10 11 12) do >f%%i.bat echo FILE%%i
for %%i in (13 14 15) do >f%%i.exe echo FILE%%i
for %%i in (16 17 18) do >f%%i.gif echo FILE%%i
for %%i in (19 20 21) do >f%%i.com echo FILE%%i
for %%i in (22 23 24) do >f%%i.tmp echo FILE%%i
copy /y *.txt d2\d22\d222 >nul
copy /y *.gif d2\d22\d223 >nul
copy /y *.pas d2\d22\d221 >nul
for %%c in (*.cpp *.pas) do copy /y "%%c" d3\d32\ >nul
move /y *.cpp d1\d12 >nul
move /y *.bat d1\d13 >nul
move /y *.exe d2\d21 >nul
move /y *.com d2\d23 >nul
del /f /s /q *.tmp >nul
echo Файлів у корені (очікується 9):
dir /a-d /b | find /c /v ""
echo Файлів у всьому дереві (очікується 36):
dir /s /a-d /b | find /c /v ""
popd
exit /b 0
