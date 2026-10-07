@echo off
chcp 65001 >nul
setlocal
rem Демонстрація журналу з ротацією: 20 записів, межа розміру - 50 байт
set "log=%USERPROFILE%\lab1112_demo.log"
set /a max=50, n=0, rot=0
del /q "%log%" "%log%.old" 2>nul
:next
set /a n+=1
if %n% GTR 20 goto finish
set /a size=0
if exist "%log%" for %%f in ("%log%") do set /a size=%%~zf
if %size% GTR %max% (
  move /y "%log%" "%log%.old" >nul
  set /a rot+=1
)
>> "%log%" echo Entry %n%
goto next
:finish
echo Записів: 20, ротацій: %rot%
for %%f in ("%log%") do echo Поточний журнал: %%~zf байт
for %%f in ("%log%.old") do echo Попередній журнал: %%~zf байт
exit /b 0
