@echo off
chcp 65001 >nul
rem Перевіряє середовище. Параметр 1 - прізвище латиницею.
rem Коди завершення: 0 - усе гаразд; 1 - немає параметра;
rem 2 - немає теки lab1112; 3 - у теці немає f1.txt; 4 - у прізвищі зайві символи
if "%~1"=="" (
  echo [ПОМИЛКА] Не задано прізвище.
  exit /b 1
)
for /f "eol=a delims=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" %%a in ("%~1") do (
  echo [ПОМИЛКА] Прізвище має містити лише латинські літери.
  exit /b 4
)
if not exist "%USERPROFILE%\lab1112_%~1\" (
  echo [ПОМИЛКА] Немає теки lab1112_%~1. Запустіть prep1112.bat %~1.
  exit /b 2
)
if not exist "%USERPROFILE%\lab1112_%~1\f1.txt" (
  echo [ПОМИЛКА] У теці немає файлу f1.txt: дерево неповне.
  exit /b 3
)
echo [OK] Середовище для %~1 готове.
exit /b 0
