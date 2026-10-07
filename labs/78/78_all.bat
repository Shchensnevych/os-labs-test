@echo off
chcp 65001 >nul
set "ERRORLEVEL="
echo ######## TASK 1
echo ######## TASK 2
echo ^> cd /d %%USERPROFILE%%
cd /d %USERPROFILE%
echo [exit %ERRORLEVEL%]
echo ^> md lab78_^<прізвище^>
md lab78_ivanenko
echo [exit %ERRORLEVEL%]
echo ^> cd lab78_^<прізвище^>
cd lab78_ivanenko
echo [exit %ERRORLEVEL%]
echo ^> md d1 d2 d3
md d1 d2 d3
echo [exit %ERRORLEVEL%]
echo ^> md d1\d11 d1\d12 d1\d13
md d1\d11 d1\d12 d1\d13
echo [exit %ERRORLEVEL%]
echo ^> md d2\d21 d2\d22 d2\d23
md d2\d21 d2\d22 d2\d23
echo [exit %ERRORLEVEL%]
echo ^> md d2\d22\d221 d2\d22\d222 d2\d22\d223
md d2\d22\d221 d2\d22\d222 d2\d22\d223
echo [exit %ERRORLEVEL%]
echo ^> md d3\d31 d3\d32 d3\d33
md d3\d31 d3\d32 d3\d33
echo [exit %ERRORLEVEL%]
echo ^> md d3\d33\d331 d3\d33\d332 d3\d33\d333
md d3\d33\d331 d3\d33\d332 d3\d33\d333
echo [exit %ERRORLEVEL%]
echo ^> dir /s /b /ad ^| find /c /v ""
dir /s /b /ad | find /c /v ""
echo [exit %ERRORLEVEL%]
echo CHECK dirs (expect 18): & dir /s /b /ad | find /c /v ""
echo ######## TASK 3
md tmp78nav & pushd tmp78nav & cd .. & popd & rd tmp78nav
echo ######## TASK 4
echo ^> rd d3\d33\d331
rd d3\d33\d331
echo [exit %ERRORLEVEL%]
echo ^> rd d3\d33\d332
rd d3\d33\d332
echo [exit %ERRORLEVEL%]
echo ^> rd d3\d33\d333
rd d3\d33\d333
echo [exit %ERRORLEVEL%]
echo ^> tree
tree
echo [exit %ERRORLEVEL%]
echo ^> md test_del
md test_del
echo [exit %ERRORLEVEL%]
echo ^> echo x ^> test_del\a.txt
echo x > test_del\a.txt
echo [exit %ERRORLEVEL%]
echo ^> rd test_del
rd test_del
echo [exit %ERRORLEVEL%]
echo ^> rd /s test_del
rd /s test_del
echo [exit %ERRORLEVEL%]
echo ^> dir /b test_del
dir /b test_del
echo [exit %ERRORLEVEL%]
echo ######## TASK 5
echo ^> echo FILE1 ^> a.txt
echo FILE1 > a.txt
echo [exit %ERRORLEVEL%]
echo ^> ^>b.txt echo FILE1
>b.txt echo FILE1
echo [exit %ERRORLEVEL%]
echo ^> dir a.txt b.txt
dir a.txt b.txt
echo [exit %ERRORLEVEL%]
echo ^> del a.txt b.txt
del a.txt b.txt
echo [exit %ERRORLEVEL%]
echo ^> for %%i in (1 2 3) do ^>f%%i.txt echo FILE%%i
for %%i in (1 2 3) do >f%%i.txt echo FILE%%i
echo [exit %ERRORLEVEL%]
echo ^> for %%i in (4 5 6) do ^>f%%i.pas echo FILE%%i
for %%i in (4 5 6) do >f%%i.pas echo FILE%%i
echo [exit %ERRORLEVEL%]
echo ^> for %%i in (7 8 9) do ^>f%%i.cpp echo FILE%%i
for %%i in (7 8 9) do >f%%i.cpp echo FILE%%i
echo [exit %ERRORLEVEL%]
echo ^> for %%i in (10 11 12) do ^>f%%i.bat echo FILE%%i
for %%i in (10 11 12) do >f%%i.bat echo FILE%%i
echo [exit %ERRORLEVEL%]
echo ^> for %%i in (13 14 15) do ^>f%%i.exe echo FILE%%i
for %%i in (13 14 15) do >f%%i.exe echo FILE%%i
echo [exit %ERRORLEVEL%]
echo ^> for %%i in (16 17 18) do ^>f%%i.gif echo FILE%%i
for %%i in (16 17 18) do >f%%i.gif echo FILE%%i
echo [exit %ERRORLEVEL%]
echo ^> for %%i in (19 20 21) do ^>f%%i.com echo FILE%%i
for %%i in (19 20 21) do >f%%i.com echo FILE%%i
echo [exit %ERRORLEVEL%]
echo ^> for %%i in (22 23 24) do ^>f%%i.tmp echo FILE%%i
for %%i in (22 23 24) do >f%%i.tmp echo FILE%%i
echo [exit %ERRORLEVEL%]
echo ^> ^>"%%TEMP%%\n78.txt" echo перший
>"%TEMP%\n78.txt" echo перший
echo [exit %ERRORLEVEL%]
echo ^> ^>^>"%%TEMP%%\n78.txt" echo другий
>>"%TEMP%\n78.txt" echo другий
echo [exit %ERRORLEVEL%]
echo ^> type "%%TEMP%%\n78.txt"
type "%TEMP%\n78.txt"
echo [exit %ERRORLEVEL%]
echo ^> ^>"%%TEMP%%\n78.txt" echo третій
>"%TEMP%\n78.txt" echo третій
echo [exit %ERRORLEVEL%]
echo ^> type "%%TEMP%%\n78.txt"
type "%TEMP%\n78.txt"
echo [exit %ERRORLEVEL%]
echo ^> del "%%TEMP%%\n78.txt"
del "%TEMP%\n78.txt"
echo [exit %ERRORLEVEL%]
echo CHECK files (expect 24 files/183 bytes): & dir /a-d
echo ######## TASK 6
echo ^> ^>f1.txt:note echo flow of file 1
>f1.txt:note echo flow of file 1
echo [exit %ERRORLEVEL%]
echo ^> ^>f2.txt:note echo flow of file 2
>f2.txt:note echo flow of file 2
echo [exit %ERRORLEVEL%]
echo ^> ^>f3.txt:note echo flow of file 3
>f3.txt:note echo flow of file 3
echo [exit %ERRORLEVEL%]
echo ^> attrib f22.tmp
attrib f22.tmp
echo [exit %ERRORLEVEL%]
echo ^> attrib +r f22.tmp
attrib +r f22.tmp
echo [exit %ERRORLEVEL%]
echo ^> del f22.tmp
del f22.tmp
echo [exit %ERRORLEVEL%]
echo ^> attrib -r f22.tmp
attrib -r f22.tmp
echo [exit %ERRORLEVEL%]
echo ^> attrib +h f23.tmp
attrib +h f23.tmp
echo [exit %ERRORLEVEL%]
echo ^> dir /b *.tmp
dir /b *.tmp
echo [exit %ERRORLEVEL%]
echo ^> dir /b /a *.tmp
dir /b /a *.tmp
echo [exit %ERRORLEVEL%]
echo ^> dir /a:h /b
dir /a:h /b
echo [exit %ERRORLEVEL%]
echo ^> attrib -h f23.tmp
attrib -h f23.tmp
echo [exit %ERRORLEVEL%]
echo ######## TASK 7
echo ^> copy *.txt d2\d22\d222
copy *.txt d2\d22\d222
echo [exit %ERRORLEVEL%]
echo ^> copy *.gif d2\d22\d223
copy *.gif d2\d22\d223
echo [exit %ERRORLEVEL%]
echo ^> copy *.pas d2\d22\d221
copy *.pas d2\d22\d221
echo [exit %ERRORLEVEL%]
echo ^> fc /b f1.txt d2\d22\d222\f1.txt
fc /b f1.txt d2\d22\d222\f1.txt
echo [exit %ERRORLEVEL%]
echo ^> certutil -hashfile f1.txt SHA256
certutil -hashfile f1.txt SHA256
echo [exit %ERRORLEVEL%]
echo ^> certutil -hashfile d2\d22\d222\f1.txt SHA256
certutil -hashfile d2\d22\d222\f1.txt SHA256
echo [exit %ERRORLEVEL%]
echo ^> fc /b f1.txt d2\d22\d222\f2.txt
fc /b f1.txt d2\d22\d222\f2.txt
echo [exit %ERRORLEVEL%]
echo CHECK files expect 33: & dir /s /a-d /b | find /c /v ""
echo ######## TASK 8
echo ^> for %%c in (*.cpp *.pas) do copy %%c d3\d32\
for %%c in (*.cpp *.pas) do copy %%c d3\d32\
echo [exit %ERRORLEVEL%]
echo ^> for %%f in (*.exe) do @echo Файл %%~nf має розмір %%~zf байт
for %%f in (*.exe) do @echo Файл %%~nf має розмір %%~zf байт
echo [exit %ERRORLEVEL%]
echo ^> for /d %%d in (*) do @echo %%d
for /d %%d in (*) do @echo %%d
echo [exit %ERRORLEVEL%]
echo ^> for /r %%f in (*.pas) do @echo %%f
for /r %%f in (*.pas) do @echo %%f
echo [exit %ERRORLEVEL%]
echo ^> for /l %%n in (1,1,5) do @echo %%n
for /l %%n in (1,1,5) do @echo %%n
echo [exit %ERRORLEVEL%]
echo CHECK files expect 39: & dir /s /a-d /b | find /c /v ""
echo ######## TASK 9
echo ^> move *.cpp d1\d12
move *.cpp d1\d12
echo [exit %ERRORLEVEL%]
echo ^> move *.bat d1\d13
move *.bat d1\d13
echo [exit %ERRORLEVEL%]
echo ^> move *.exe d2\d21
move *.exe d2\d21
echo [exit %ERRORLEVEL%]
echo ^> move *.com d2\d23
move *.com d2\d23
echo [exit %ERRORLEVEL%]
echo ^> ren *.tmp *.bak
ren *.tmp *.bak
echo [exit %ERRORLEVEL%]
echo ^> move d3\d31 d3\archive
move d3\d31 d3\archive
echo [exit %ERRORLEVEL%]
echo CHECK tree & tree /f /a
echo ######## TASK 10
echo ^> tree /f /a ^> "%%USERPROFILE%%\tree78_^<прізвище^>.txt"
tree /f /a > "%USERPROFILE%\tree78_ivanenko.txt"
echo [exit %ERRORLEVEL%]
echo ^> dir /s /a-d /b ^> "%%USERPROFILE%%\files78_^<прізвище^>.txt"
dir /s /a-d /b > "%USERPROFILE%\files78_ivanenko.txt"
echo [exit %ERRORLEVEL%]
echo ^> type "%%USERPROFILE%%\files78_^<прізвище^>.txt" ^| find /c /v ""
type "%USERPROFILE%\files78_ivanenko.txt" | find /c /v ""
echo [exit %ERRORLEVEL%]
echo ^> robocopy "%%USERPROFILE%%\lab78_^<прізвище^>" "%%USERPROFILE%%\lab78_^<прізвище^>_backup" /e
robocopy "%USERPROFILE%\lab78_ivanenko" "%USERPROFILE%\lab78_ivanenko_backup" /e
echo [exit %ERRORLEVEL%]
echo ^> echo %%ERRORLEVEL%%
echo %ERRORLEVEL%
echo [exit %ERRORLEVEL%]
echo ^> robocopy "%%USERPROFILE%%\lab78_^<прізвище^>" "%%USERPROFILE%%\lab78_^<прізвище^>_backup" /e /njh
robocopy "%USERPROFILE%\lab78_ivanenko" "%USERPROFILE%\lab78_ivanenko_backup" /e /njh
echo [exit %ERRORLEVEL%]
echo ^> echo %%ERRORLEVEL%%
echo %ERRORLEVEL%
echo [exit %ERRORLEVEL%]
echo ^> tar -a -c -f "%%USERPROFILE%%\lab78_^<прізвище^>.zip" -C "%%USERPROFILE%%" lab78_^<прізвище^>
tar -a -c -f "%USERPROFILE%\lab78_ivanenko.zip" -C "%USERPROFILE%" lab78_ivanenko
echo [exit %ERRORLEVEL%]
echo ^> dir "%%USERPROFILE%%\lab78_^<прізвище^>.zip"
dir "%USERPROFILE%\lab78_ivanenko.zip"
echo [exit %ERRORLEVEL%]
echo CHECK end files: & dir /s /a-d /b | find /c /v ""
