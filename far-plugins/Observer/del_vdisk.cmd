@echo off
echo Cleaning 'vdisk.so'
cd /d "%~dp0"
if exist "modules\vdisk.so" (
if exist "modules\vdisk.-so" del "modules\vdisk.-so"
ren "modules\vdisk.so" "vdisk.-so"
)
copy observer.ini observer_orig.ini > nul
copy observer_my.ini observer.ini > nul
