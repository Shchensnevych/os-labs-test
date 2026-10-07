@echo off
chcp 65001 >nul
title Повний цикл
echo === Крок 1: структура тек ===
call "%~dp0build_tree.bat" %1
echo === Крок 2: створення файлів ===
call "%~dp0make_files.bat" %1
echo === Крок 3: упорядкування файлів ===
call "%~dp0organize.bat" %1
echo === Усі кроки виконано ===
exit /b 0
