@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
rem Статистика дерева lab1112_<прізвище>. Параметр 1 - прізвище
call "%~dp0check_env.bat" %1 || exit /b 1
pushd "%USERPROFILE%\lab1112_%~1" || exit /b 1
set /a cnt=0, total=0, max=0
set "maxfile="
for /r %%f in (*) do (
  set /a cnt+=1
  set /a total+=%%~zf
  if %%~zf GTR !max! (
    set /a max=%%~zf
    set "maxfile=%%~nxf"
  )
)
if %cnt% EQU 0 (
  echo Файлів не знайдено.
  popd
  exit /b 2
)
set /a avg=total/cnt
for /f %%n in ('dir /a-d /b ^| find /c /v ""') do set /a root=%%n
set /a pct=root*100/cnt
echo Файлів у дереві        : %cnt%
echo Загальний розмір, байт : %total%
echo Середній розмір, байт  : %avg%
echo Найбільший файл        : %max% байт, %maxfile%
echo Файлів у корені       : %root% (%pct%%% від усіх)
popd
exit /b 0
