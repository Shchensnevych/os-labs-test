@echo off
chcp 65001 >nul
setlocal
rem Сума 1..N та факторіал N! циклом на мітках. Параметр 1 - N (1..20)
set "n=%~1"
if not defined n set /p "n=N (від 1 до 20): "
if not defined n (
  echo N не задано.
  exit /b 1
)
call "%~dp0isint.bat" n || (
  echo N має бути цілим числом без ведучих нулів.
  exit /b 2
)
if %n% LSS 1 goto range
if %n% GTR 20 goto range
set /a i=0, sum=0, fact=1
:loop
set /a i+=1
if %i% GTR %n% goto done
set /a sum+=i
set /a fact*=i
goto loop
:done
echo Сума 1..%n% = %sum%
echo Факторіал %n%! = %fact%
if %n% GTR 12 echo УВАГА: при N більше 12 факторіал не вміщується у 32 біти, результат хибний.
exit /b 0
:range
echo N має бути в межах від 1 до 20.
exit /b 3
