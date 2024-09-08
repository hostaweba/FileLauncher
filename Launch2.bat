@echo off
setlocal enabledelayedexpansion

rem Check if running in Command Prompt and not in Windows Terminal
if defined WT_SESSION (
    echo Restarting in Command Prompt...
    start cmd /c "%~f0"
    exit
)


set console_title=Launcher
set console_color=e0

:main_menu
mode con: cols=65 lines=11
title %console_title%
color %console_color%

cls
echo ===============================================================
echo                       Main Menu - File Executor        
echo ===============================================================
echo 1: Python Files
echo 2: Executable Files
echo 3: Batch Files
echo 0: Exit
echo ===============================================================
set /p main_choice=Select an option:

if "%main_choice%"=="1" goto :python_files
if "%main_choice%"=="2" goto :exe_files
if "%main_choice%"=="3" goto :bat_files
if "%main_choice%"=="0" (
    echo Exiting...
    goto :end
)
echo Invalid choice. Please try again.
pause
goto :main_menu

:resize_console
set /a total_lines=%1 + 9
mode con: cols=65 lines=%total_lines%
goto :eof

:python_files
call :file_menu "Python File Executor Menu" "py" "python"
goto :main_menu

:exe_files
call :file_menu "Executable File Executor Menu" "exe" ""
goto :main_menu

:bat_files
call :file_menu "Batch File Executor Menu" "bat" "call"
goto :main_menu

:file_menu
cls
echo ===============================================================
echo                     %~1
echo ===============================================================

rem Count files of given type in the current directory
set /a count=0
for %%f in (*.%2) do (
    set /a count+=1
)
call :resize_console %count%
title %console_title%
color %console_color%

rem List all files of given type in the current directory
cls
echo ===============================================================
echo                     %~1
echo ===============================================================
set /a count=0
for %%f in (*.%2) do (
    set /a count+=1
    set "file[!count!]=%%f"
    echo !count!: %%f
)
echo ===============================================================
echo 0: Back to Main Menu
echo ===============================================================

rem Prompt the user to select a file
set /p choice=Select a file to execute (0 to !count!):

rem Check if the choice is to go back to the main menu
if "%choice%"=="0" goto :main_menu

rem Check if the choice is valid
if "!file[%choice%]!"=="" (
    echo Invalid choice. Please try again.
    pause
    goto :file_menu
)

rem Execute the selected file
echo Running "!file[%choice%]!"...
%3 "!file[%choice%]!"
echo ===============================================================
echo Execution finished.
pause
goto :file_menu

:end
endlocal
goto :eof
