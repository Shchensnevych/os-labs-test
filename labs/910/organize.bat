@echo off
chcp 65001 >nul
rem Копіює, переміщує і видаляє файли за типами. Параметр 1 - прізвище
pushd "%USERPROFILE%\lab910_%~1" || exit /b 1
copy /y *.txt d2\d22\d222 >nul
copy /y *.gif d2\d22\d223 >nul
copy /y *.pas d2\d22\d221 >nul
for %%c in (*.cpp *.pas) do copy /y "%%c" d3\d32\ >nul
move /y *.cpp d1\d12 >nul
move /y *.bat d1\d13 >nul
move /y *.exe d2\d21 >nul
move /y *.com d2\d23 >nul
echo Файли .tmp, які буде видалено:
dir /s /b *.tmp
del /f /s /q *.tmp >nul
echo Файлів у корені (очікується 9):
dir /a-d /b | find /c /v ""
echo Файлів у всьому дереві (очікується 36):
dir /s /a-d /b | find /c /v ""
popd
exit /b 0
