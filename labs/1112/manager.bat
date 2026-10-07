@echo off
chcp 65001 >nul
setlocal
rem Менеджер лабораторної теки. Параметр 1 - прізвище латиницею
if "%~1"=="" (
  echo Використання: manager.bat прізвище
  exit /b 1
)
set "who=%~1"
set "here=%~dp0"
call "%here%check_env.bat" "%who%" || (
  echo Спершу створіть дерево: prep1112.bat ваше_прізвище
  exit /b 2
)
:menu
cls
echo ==========================================
echo   Менеджер: %who%
echo ==========================================
echo   1 - Статистика дерева
echo   2 - Резервна копія та аналіз коду robocopy
echo   3 - Журнал з ротацією (демонстрація)
echo   4 - Видалити робоче дерево (з підтвердженням)
echo   Q - Вихід
echo.
choice /c 1234Q /n /m "Ваш вибір: "
if errorlevel 5 goto quit
if errorlevel 4 goto clean
if errorlevel 3 goto logs
if errorlevel 2 goto backup
if errorlevel 1 goto stat
goto menu
:stat
call "%here%stats.bat" "%who%"
goto again
:backup
call "%here%rc.bat" "%who%"
goto again
:logs
call "%here%rotate_log.bat"
goto again
:clean
echo УВАГА: буде видалено теку %USERPROFILE%\lab1112_%who%
choice /c YN /n /m "Підтвердити видалення? (Y/N): "
if errorlevel 2 goto cancel
rd /s /q "%USERPROFILE%\lab1112_%who%"
echo Теку видалено. Менеджер завершує роботу.
goto quit
:cancel
echo Скасовано.
goto again
:again
echo.
pause
goto menu
:quit
exit /b 0
