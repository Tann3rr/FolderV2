@echo off
color 0a
title Random File Creator

setlocal enableDelayedExpansion
set "counter=0"
set "words=balls"

:main
set /p num_files="Enter the number of files to create: "
set /p folder_name="Enter the folder name: "

echo Creating folder %folder_name%...
echo.
mkdir "%folder_name%"

:loop
color 0b
timeout /t 3 /nobreak >nul
color 0a

for /l %%i in (1,1,%num_files%) do (
    set /a "file_name=!random!%%100000"
    set /a "random_number=!random!%%100000"
    set /a "random_index=!random! %% 7"
    set "random_word=!words:~%random_index%,7!"
    echo Creating file %folder_name%\file_!file_name!.txt...
    echo Random number: !random_number!^r^nRandom word: !random_word! > "%folder_name%\file_!file_name!.txt"
    set /a counter+=1
    call :progress_bar !counter! %num_files%
)

echo.
echo Folder and files created successfully.
set /p "another_folder=Do you want to create another folder? (Y/N)"
if /i "!another_folder!"=="Y" goto :main

pause
exit /b

:progress_bar
setlocal
set /a "percent=100 * %1 / %2"
set /a "filled=percent / 2"
set "spaces=                                                  "
set "fill=%spaces:~0,%filled%"
set "empty=%spaces:~0,%(50 - filled)%"
setlocal enableDelayedExpansion
echo.
echo Creating files: [!fill!!empty!] %percent%% complete
exit /b
