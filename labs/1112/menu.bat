@echo off
chcp 65001 >nul
setlocal
rem Меню лабораторної роботи. Параметр 1 - прізвище латиницею
if "%~1"=="" (
  echo Використання: menu.bat прізвище
  exit /b 1
)
call "%~dp0check_env.bat" "%~1" >nul || (
  echo Спершу створіть дерево: prep1112.bat ваше_прізвище
  exit /b 2
)
set "who=%~1"
set "here=%~dp0"
:menu
cls
echo ==========================================
echo   Меню лабораторної роботи 11-12 (%who%)
echo ==========================================
echo   1 - Сума двох чисел (sum.bat)
echo   2 - Сума та факторіал (loop.bat)
echo   3 - Перевірка середовища (check_env.bat)
echo   Q - Вихід
echo.
choice /c 123Q /n /m "Ваш вибір: "
if errorlevel 4 goto quit
if errorlevel 3 goto env
if errorlevel 2 goto loopn
if errorlevel 1 goto sumn
goto menu
:sumn
call "%here%sum.bat"
goto again
:loopn
call "%here%loop.bat"
goto again
:env
call "%here%check_env.bat" "%who%"
goto again
:again
echo.
pause
goto menu
:quit
echo До побачення!
exit /b 0
