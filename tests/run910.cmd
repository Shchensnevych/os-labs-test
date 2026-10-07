@echo off
chcp 65001 >nul
set "L=%~dp0..\labs\910"
cd /d "%USERPROFILE%"
echo ===== T1 hello.bat
call "%L%\hello.bat" < NUL
echo ===== T2 info.bat
call "%L%\info.bat" < NUL
echo ===== T3 params.bat
call "%L%\params.bat" ivanenko "My Folder" C:\Windows\win.ini < NUL
echo ===== T4 build_tree (expect 18)
call "%L%\build_tree.bat" ivanenko
echo ===== T5 make_files (expect 24)
call "%L%\make_files.bat" ivanenko
echo ===== T6 organize (expect 9 and 36)
call "%L%\organize.bat" ivanenko
echo ===== T6b dry_tmp
call "%L%\dry_tmp.bat" ivanenko
echo ===== T7 run_all (fresh)
rd /s /q "%USERPROFILE%\lab910_ivanenko" 2>nul
call "%L%\run_all.bat" ivanenko
echo ===== T8 report
call "%L%\report.bat" ivanenko
echo --- report head
more +0 "%USERPROFILE%\report910_ivanenko.txt" | findstr /n "." | findstr /b "1: 2: 3: 4: 5: 6: 7: 8: 9: 10:"
echo --- errors log
type "%USERPROFILE%\errors910_ivanenko.log"
echo ===== T9 loops
call "%L%\loops.bat" ivanenko
echo ===== T9 sort_by_ext (expect 12 then 0)
call "%L%\sort_by_ext.bat" ivanenko
echo ===== T10 final (expect rc 1, zip)
call "%L%\final.bat" ivanenko
dir "%USERPROFILE%\lab910_ivanenko.zip"
echo ===== second final run
call "%L%\final.bat" ivanenko
exit /b 0
