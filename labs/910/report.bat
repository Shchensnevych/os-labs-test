@echo off
chcp 65001 >nul
rem Формує текстовий звіт про дерево. Параметр 1 - прізвище
pushd "%USERPROFILE%\lab910_%~1" || exit /b 1
(
echo ===== Звіт пакетного файлу =====
echo Дата: %DATE%   Час: %TIME%
echo Користувач: %USERNAME%, комп'ютер: %COMPUTERNAME%
echo.
echo --- Дерево каталогів ---
tree /f /a
echo.
echo Файлів у дереві:
dir /s /a-d /b | find /c /v ""
) > "%USERPROFILE%\report910_%~1.txt"
echo %DATE% %TIME% - звіт створено>> "%USERPROFILE%\log910_%~1.txt"
dir C:\no_such_folder_910 2>> "%USERPROFILE%\errors910_%~1.log"
echo Звіт збережено: %USERPROFILE%\report910_%~1.txt
popd
exit /b 0
