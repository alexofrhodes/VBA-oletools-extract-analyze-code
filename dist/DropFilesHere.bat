@echo off
setlocal enabledelayedexpansion

rem Check if files are dropped
if "%~1"=="" (
    echo Drag and drop files onto this script to process them with olevba.exe.
    pause
    exit /b
)

rem Create output directory
set "output_dir=olevba_output"
if not exist "%output_dir%" (
    mkdir "%output_dir%"
)

rem Get the current directory of the batch script
set "script_dir=%~dp0"

rem Process each dropped file
for %%F in (%*) do (
    rem Get the filename without the path
    set "filename=%%~nF"
    set "extension=%%~xF"
    
    rem Construct output file name
    set "output_file=%output_dir%\!filename!!extension!.txt"
    
    rem Call olevba.exe on the file and redirect output
    echo Processing "%%~F" ...
    "%script_dir%olevba.exe" "%%~F" > "!output_file!" 2>&1
)

echo All files processed. Outputs are in the "%output_dir%" directory.
pause
