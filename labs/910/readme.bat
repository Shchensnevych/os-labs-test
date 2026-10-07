@echo off
chcp 65001 >nul
rem Короткий опис призначення. Параметр 1 - прізвище латиницею
pushd "%USERPROFILE%\lab910_%~1" || exit /b 1
rem ... основні команди сценарію ...
popd
exit /b 0
