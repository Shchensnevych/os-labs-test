@echo off
chcp 65001 >nul
setlocal enableextensions
rem Додає два цілі числа. Виклик: sum.bat [A] [B]; без параметрів - запитує.
rem Результат останнього ВДАЛОГО розрахунку лежить у lab1112_sum_result.txt
set "log=%USERPROFILE%\lab1112_sum_result.txt"
set "hist=%USERPROFILE%\lab1112_sum_history.txt"
set "p1=%~1"
set "p2=%~2"
if not defined p1 set /p "p1=Enter value of variable 1: "
if not defined p2 set /p "p2=Enter value of variable 2: "
if not defined p1 goto missing
if not defined p2 goto missing
call "%~dp0isint.bat" p1 || goto notint
call "%~dp0isint.bat" p2 || goto notint
set /a sum=p1+p2
(echo %sum%& echo happy end)> "%log%"
echo Result: %sum%
echo happy end
>> "%hist%" echo %DATE% %TIME% sum=%sum%
exit /b 0
:missing
echo odna abo dekilka zminnykh vidsutni
>> "%hist%" echo %DATE% %TIME% input missing
exit /b 1
:notint
echo odin abo oba operandy ne ye cilymy chyslamy
>> "%hist%" echo %DATE% %TIME% not integer
exit /b 2
