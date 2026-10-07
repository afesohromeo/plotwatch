@echo off
rem Exports the brand SVGs in assets\brand to the PNGs that
rem flutter_launcher_icons and flutter_native_splash need (doc/04b, E2-7).
rem The SVGs are the source; rerun this after changing one.
rem Run from plotwatch_flutter:  tool\export_brand_pngs.cmd
setlocal
set CHROME="C:\Program Files\Google\Chrome\Application\chrome.exe"
pushd "%~dp0..\assets\brand"
set BRAND=%CD%
popd

call :png icon_launcher 1024
call :png mark_launcher_foreground 1024
call :png mark_monochrome 1024
call :png mark_tiny 64
call :png splash_mark 576
call :png splash_android12 1152
echo Done: PNGs written to %BRAND%
exit /b 0

rem :png <name> <size>  -  renders <name>.svg at <size> x <size>, transparent.
:png
set URL=file:///%BRAND:\=/%/%1.svg
%CHROME% --headless=new --disable-gpu --hide-scrollbars --default-background-color=00000000 --window-size=%2,%2 --screenshot="%BRAND%\%1.png" "%URL%"
exit /b
