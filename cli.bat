@echo off
title UCI Parser
echo ################################
echo #          UCI Parser          #
echo ################################
echo.

set /p url="URL: "
if "%url%"=="" (
    echo URL is required!
    pause
    exit /b 1
)

echo.
set /p include_tb="Include tiebreak points? (Y/N): "
set tb_flag=
if /i "%include_tb%"=="Y" set tb_flag=--tb

echo.
set /p max_contestants="Maximum contestants to include (press Enter for no limit): "
set max_flag=
if not "%max_contestants%"=="" set max_flag=--max %max_contestants%

echo.
set /p tournament_name="Tournament name for prizes (press Enter to skip): "
set prizes_flag=
if not "%tournament_name%"=="" set prizes_flag=--prizes "%tournament_name%"

echo.
echo Building markdown table...
echo.

if exist ".venv\Scripts\activate.bat" (
    call .venv\Scripts\activate.bat
)

python main.py --url "%url%" %tb_flag% %max_flag% %prizes_flag%
pause