@echo off
pushd "%USERPROFILE%\lab910_%~1" || exit /b 1
for /r %%f in (*.tmp) do @echo del "%%f"
popd
