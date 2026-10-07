@echo off
setlocal enabledelayedexpansion
rem Чи містить змінна, ІМ'Я якої передано параметром, ціле число?
rem Код 0 - так (мінус дозволено, без ведучих нулів, не довше 9 цифр); 1 - ні
set "t=!%~1!"
if not defined t exit /b 1
if "!t:~0,1!"=="-" set "t=!t:~1!"
if not defined t exit /b 1
if not "!t:~9,1!"=="" exit /b 1
if "!t:~0,1!"=="0" if not "!t:~1,1!"=="" exit /b 1
for /f "eol=0 delims=0123456789" %%a in ("!t!") do exit /b 1
exit /b 0
