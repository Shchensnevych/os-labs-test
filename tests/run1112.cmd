@echo off
chcp 65001 >nul
set "L=%~dp0..\labs\1112"
cd /d "%USERPROFILE%"
echo ===== T1 SET
set | find /c /v ""
set USER
set city=Kyiv 
set "town=Kyiv"
echo [%city%] [%town%]
set "s=ABCDEFGH"
echo %s:~2,3%
echo %s:~-3%
echo %s:~0,-2%
echo %s:CD=xy%
echo ===== T2 SET /A
set /a a=7/2
echo 7/2=%a%
set /a a=-7/2
echo -7/2=%a%
set /a a=010+1
echo 010+1=%a%
set /a a=0x1F
echo 0x1F=%a%
set /a a=2147483647+1
echo overflow=%a%
set /a a=5%%3
echo 5%%3=%a%
set /a a=1/0
echo [exit %ERRORLEVEL%]
set /a a=08+1
echo [exit %ERRORLEVEL%]
echo ===== prep1112 bad/good
call "%L%\prep1112.bat"
echo [exit %ERRORLEVEL%]
call "%L%\prep1112.bat" iva1
echo [exit %ERRORLEVEL%]
call "%L%\prep1112.bat" ivanenko
echo [exit %ERRORLEVEL%]
echo ===== T3 greet (Anna, 20 / empty name, 17 / 70 / abc)
(echo Anna& echo 20)| call "%L%\greet.bat"
(echo.& echo 17)| call "%L%\greet.bat"
(echo Bob& echo 70)| call "%L%\greet.bat"
echo ===== T4 check_env
call "%L%\check_env.bat"
echo [exit %ERRORLEVEL% expect 1]
call "%L%\check_env.bat" ivanenko
echo [exit %ERRORLEVEL% expect 0]
call "%L%\check_env.bat" nobody
echo [exit %ERRORLEVEL% expect 2]
call "%L%\check_env.bat" iva1
echo [exit %ERRORLEVEL% expect 4]
echo --- order_demo (expect 4 lines code 2)
call "%L%\order_demo.bat"
echo ===== T5 isint
for %%v in (5 -5 0 08 123456789 1234567890 abc 1.5 "" 12a) do (
  set "x=%%~v"
  call "%L%\isint.bat" x && echo isint %%~v = YES || echo isint %%~v = NO
)
echo --- loop 5 / 12 / 13 / 20 / 21 / abc
call "%L%\loop.bat" 5
call "%L%\loop.bat" 12
call "%L%\loop.bat" 13
call "%L%\loop.bat" 20
call "%L%\loop.bat" 21
call "%L%\loop.bat" abc
echo ===== T6 rc
call "%L%\rc.bat" ivanenko
echo [exit %ERRORLEVEL%]
call "%L%\rc.bat" ivanenko
echo [exit %ERRORLEVEL%]
echo x> "%USERPROFILE%\lab1112_ivanenko_backup\extra.txt"
call "%L%\rc.bat" ivanenko
echo [exit %ERRORLEVEL%]
echo more>> "%USERPROFILE%\lab1112_ivanenko\f1.txt"
call "%L%\rc.bat" ivanenko
echo [exit %ERRORLEVEL%]
del "%USERPROFILE%\lab1112_ivanenko_backup\extra.txt"
call "%L%\rc.bat" ivanenko
echo [exit %ERRORLEVEL%]
echo ===== T7 sum
del "%USERPROFILE%\lab1112_sum_history.txt" "%USERPROFILE%\lab1112_sum_result.txt" 2>nul
call "%L%\sum.bat" 2 3
echo [exit %ERRORLEVEL%]
call "%L%\sum.bat" -10 4
echo [exit %ERRORLEVEL%]
call "%L%\sum.bat" a 3
echo [exit %ERRORLEVEL%]
call "%L%\sum.bat" "1&echo INJECTED" 3
echo [exit %ERRORLEVEL%]
call "%L%\sum.bat" 08 3
echo [exit %ERRORLEVEL%]
call "%L%\sum.bat" 1 < NUL
echo [exit %ERRORLEVEL%]
type "%USERPROFILE%\lab1112_sum_result.txt"
type "%USERPROFILE%\lab1112_sum_history.txt"
echo ===== T8 menu via choice (best effort)
(echo 3) | call "%L%\menu.bat" ivanenko
echo [menu exit %ERRORLEVEL%]
echo ===== T9 rotate_log
call "%L%\rotate_log.bat"
echo ===== T10 stats
call "%L%\stats.bat" ivanenko
echo [exit %ERRORLEVEL%]
echo ===== T10 manager (best effort: stats then quit)
(echo 1& echo.& echo Q) | call "%L%\manager.bat" ivanenko
echo [manager exit %ERRORLEVEL%]
exit /b 0
