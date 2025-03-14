@echo off
setlocal enabledelayedexpansion

rem Check if files are provided either by drag-and-drop or via command-line arguments
if "%~1"=="" (
    echo Drag and drop files onto this script OR run it from the command line with file paths.
    echo Usage: olevba.bat file1.doc file2.docx
    pause
    exit /b
)

rem Get the current directory of the batch script
set "script_dir=%~dp0"

rem Process each provided file
for %%F in (%*) do (
    rem Get the filename without extension
    set "filename=%%~nF"
    
    rem Replace spaces with hyphens
    set "output_dir=!filename!"
    set "output_dir=!output_dir: =-!"
    
    rem Create the output directory at the same location as the file
    set "file_path=%%~dpF"
    set "output_path=!file_path!oleVba_output_!output_dir!"
    
    if not exist "!output_path!" (
        mkdir "!output_path!"
    )

    rem Construct output file name
    set "output_file=!output_path!\olevba_output.txt"
    
    rem Call olevba.exe on the file and redirect output
    echo Processing "%%~F" ...
    "%script_dir%olevba.exe" "%%~F" > "!output_file!" 2>&1
)

echo All files processed. Outputs are in their respective directories.
pause
