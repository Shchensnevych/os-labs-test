@echo off
chcp 65001 >nul
rem Створює дерево тек. Параметр 1 - прізвище латиницею
md "%USERPROFILE%\lab910_%~1" 2>nul
pushd "%USERPROFILE%\lab910_%~1" || exit /b 1
md d1 d2 d3 2>nul
md d1\d11 d1\d12 d1\d13 2>nul
md d2\d21 d2\d22 d2\d23 2>nul
md d2\d22\d221 d2\d22\d222 d2\d22\d223 2>nul
md d3\d31 d3\d32 d3\d33 2>nul
md d3\d33\d331 d3\d33\d332 d3\d33\d333 2>nul
echo Тек у дереві (очікується 18):
dir /s /b /ad | find /c /v ""
popd
exit /b 0
