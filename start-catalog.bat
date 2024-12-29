@echo off

REM Change to the directory where the script is located
cd %~dp0

REM Set the path to the PHP executable in the assets folder
set PHP_PATH=assets\php\php.exe

REM Check if PHP exists in the specified folder
if not exist "%PHP_PATH%" (
    echo PHP is not found in %PHP_PATH%.
    echo Please ensure PHP is located in the assets\php folder.
    pause
    exit /b
)

REM Start the PHP built-in server with the correct executable
echo Starting PHP server at http://localhost:8000
start "" "%PHP_PATH%" -S localhost:8000

REM Wait for the server to start
timeout /t 2 >nul

REM Attempt to open the URL in a new browser window

REM Check if Google Chrome is installed and use it to open a new window
for /f "tokens=*" %%A in ('where chrome') do (
    start "" "%%A" --new-window "http://localhost:8000/index.php"
    goto end
)

REM If Chrome is not found, try Microsoft Edge
for /f "tokens=*" %%A in ('where msedge') do (
    start "" "%%A" "http://localhost:8000/index.php"
    goto end
)

REM If Edge is not found, use the system default browser
start "" "http://localhost:8000/index.php"

:end
REM Prevent the window from closing immediately
echo Server is running. Press Ctrl+C to stop.
pause
