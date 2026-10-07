@echo off
chcp 65001 >nul
rem Сортує файли тестової теки inbox за розширеннями. Параметр 1 - прізвище
pushd "%USERPROFILE%\lab910_%~1" || exit /b 1
md inbox 2>nul
for %%e in (txt jpg pdf log) do for /l %%n in (1,1,3) do >inbox\doc%%n.%%e echo File %%n
echo Файлів у inbox до сортування (очікується 12):
dir /a-d /b inbox | find /c /v ""
for %%e in (txt jpg pdf log) do (
  md "inbox\%%e" 2>nul
  move /y "inbox\*.%%e" "inbox\%%e\" >nul
)
echo Файлів у inbox після сортування (очікується 0):
dir /a-d /b inbox | find /c /v ""
tree inbox /f /a
popd
exit /b 0
