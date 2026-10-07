@echo off
chcp 65001 >nul
setlocal
rem Резервне копіювання з розбором коду robocopy. Параметр 1 - прізвище
call "%~dp0check_env.bat" %1 || exit /b 1
robocopy "%USERPROFILE%\lab1112_%~1" "%USERPROFILE%\lab1112_%~1_backup" /e /njh /njs /ndl /nfl /np /r:1 /w:1
set "rc=%ERRORLEVEL%"
echo Код robocopy: %rc%
if %rc% GEQ 16 (
  echo Критична помилка robocopy.
  exit /b 16
)
if %rc% GEQ 8 (
  echo Є файли, які не вдалось скопіювати.
  exit /b 8
)
if %rc% EQU 0 echo Нічого копіювати: копія актуальна.
if %rc% EQU 1 echo Файли скопійовано.
if %rc% EQU 2 echo У копії є зайві файли, нових файлів немає.
if %rc% EQU 3 echo Файли скопійовано, у копії є зайві файли.
if %rc% GEQ 4 echo Є невідповідності між джерелом і копією.
exit /b 0
