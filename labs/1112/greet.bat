@echo off
chcp 65001 >nul
setlocal
rem Запитує ім'я та вік, визначає категорію. Спеціально БЕЗ перевірки числа.
set "person="
set "age="
set /p "person=Як вас звати? (Enter - Student): "
if not defined person set "person=Student"
set /p "age=Ваш вік (років): "
if not defined age (
  echo Вік не введено.
  exit /b 1
)
echo Вітаю, %person%!
if %age% LSS 18 (
  echo Категорія: неповнолітній.
) else if %age% LSS 65 (
  echo Категорія: дорослий.
) else (
  echo Категорія: старший вік.
)
exit /b 0
