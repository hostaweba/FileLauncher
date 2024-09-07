@echo off
setlocal enabledelayedexpansion

rem Check if running in Command Prompt and not in Windows Terminal
if defined WT_SESSION (
    echo Restarting in Command Prompt...
    start cmd /c "%~f0"
    exit
)

title Launcher
set console_color=e0

:main_menu
mode con: cols=65 lines=11
color %console_color%

cls
echo ===============================================================
echo     		   Main Menu - File Executor        
echo ===============================================================
echo 1: Python Files
echo 2: Executable Files
echo 3: Batch Files
echo 0: Exit
echo ===============================================================
set /p main_choice=Select an option:

if "%main_choice%"=="1" (
    goto :python_files
)
if "%main_choice%"=="2" (
    goto :exe_files
)
if "%main_choice%"=="3" (
    goto :bat_files
)
if "%main_choice%"=="0" (
    echo Exiting...
    goto :end
)
echo Invalid choice. Please try again.
pause
goto :main_menu

:resize_console
set /a total_lines_raw=%1 + 9
set total_lines=%total_lines_raw%

echo Resizing console to %total_lines% lines
mode con: cols=65 lines=%total_lines%
goto :eof

:python_files
cls
echo ===============================================================
echo      		  Python File Executor Menu        
echo ===============================================================

rem Count .py files in the current directory
set /a count=0
for %%f in (*.py) do (
    set /a count+=1
)
call :resize_console %count%
color %console_color%

rem List all .py files in the current directory
cls
echo ===============================================================
echo      		  Python File Executor Menu        
echo ===============================================================
set /a count=0
for %%f in (*.py) do (
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
if "%choice%"=="0" (
    goto :main_menu
)

rem Check if the choice is valid
if "!file[%choice%]!"=="" (
    echo Invalid choice. Please try again.
    pause
    goto :python_files
)

rem Execute the selected file
echo Running "!file[%choice%]!"...
python "!file[%choice%]!"
echo ===============================================================
echo Execution finished.
pause
goto :python_files

:exe_files
cls
echo ===============================================================
echo                Executable File Executor Menu    
echo ===============================================================

rem Count .exe files in the current directory
set /a count=0
for %%f in (*.exe) do (
    set /a count+=1
)
call :resize_console %count%
color %console_color%

rem List all .exe files in the current directory
cls
echo ===============================================================
echo                Executable File Executor Menu    
echo ===============================================================
set /a count=0
for %%f in (*.exe) do (
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
if "%choice%"=="0" (
    goto :main_menu
)

rem Check if the choice is valid
if "!file[%choice%]!"=="" (
    echo Invalid choice. Please try again.
    pause
    goto :exe_files
)

rem Execute the selected file
echo Running "!file[%choice%]!"...
"!file[%choice%]!"
echo ===============================================================
echo Execution finished.
pause
goto :exe_files

:bat_files
cls
echo ===============================================================
echo                Batch File Executor Menu         
echo ===============================================================

rem Count .bat files in the current directory
set /a count=0
for %%f in (*.bat) do (
    set /a count+=1
)
call :resize_console %count%
color %console_color%

rem List all .bat files in the current directory
cls
echo ===============================================================
echo                Batch File Executor Menu         
echo ===============================================================
set /a count=0
for %%f in (*.bat) do (
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
if "%choice%"=="0" (
    goto :main_menu
)

rem Check if the choice is valid
if "!file[%choice%]!"=="" (
    echo Invalid choice. Please try again.
    pause
    goto :bat_files
)

rem Execute the selected file
echo Running "!file[%choice%]!"...
call "!file[%choice%]!"
echo ===============================================================
echo Execution finished.
pause
goto :bat_files

:end
endlocal
goto :eof
