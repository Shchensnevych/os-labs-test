@echo off
chcp 65001 >nul
title Підсумкова автоматизація
rem Параметр 1 - прізвище латиницею (лише літери!)
echo Початок: %TIME%
rd /s /q "%USERPROFILE%\lab910_%~1" 2>nul
rd /s /q "%USERPROFILE%\lab910_%~1_backup" 2>nul
call "%~dp0run_all.bat" %1
call "%~dp0report.bat" %1
robocopy "%USERPROFILE%\lab910_%~1" "%USERPROFILE%\lab910_%~1_backup" /e /njh /ndl /nfl /np /r:1 /w:1
echo Код завершення robocopy (очікується 1): %ERRORLEVEL%
tar -a -c -f "%USERPROFILE%\lab910_%~1.zip" -C "%USERPROFILE%" "lab910_%~1_backup" 2>nul && echo Архів створено: %USERPROFILE%\lab910_%~1.zip || echo [УВАГА] Архів не створено: tar недоступний - у Windows 7 створіть його вручну в Провіднику.
echo Кінець: %TIME%
exit /b 0
