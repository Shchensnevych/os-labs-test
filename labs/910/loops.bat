@echo off
chcp 65001 >nul
rem Демонстрація циклів FOR. Параметр 1 - прізвище
pushd "%USERPROFILE%\lab910_%~1" || exit /b 1
md loops 2>nul
echo --- for /l: створення 10 файлів ---
for /l %%n in (1,1,10) do >loops\log_%%n.txt echo Запис %%n
dir /b loops\log_*.txt | find /c /v ""
echo --- for /d: теки верхнього рівня ---
for /d %%d in (*) do echo Тека: %%d
echo --- for /f: теки зі списку імен ---
(echo alpha& echo beta& echo gamma)> loops\names.txt
for /f %%a in (loops\names.txt) do md "loops\dir_%%a" 2>nul
dir /ad /b loops
echo --- for /r: усі файли .pas у дереві ---
for /r %%f in (*.pas) do echo %%f
echo --- очищення ---
for /l %%n in (1,1,10) do del /q loops\log_%%n.txt
rd /s /q loops
popd
exit /b 0
