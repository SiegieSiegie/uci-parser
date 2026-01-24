@echo off
title UCI Parser
setlocal
cd /d "%~dp0"
echo ################################
echo #          UCI Parser          #
echo ################################
echo.

if exist ".venv\Scripts\activate.bat" (
    call .venv\Scripts\activate.bat
) else (
    echo Setting up for the first use...
    python -m venv .venv
    call .venv\Scripts\activate.bat
    pip install -r requirements.txt
)

:main_section
set /p url="URL: "
if "%url%"=="" (
    echo URL is required!
    pause
    goto main_section
)

echo.
set /p include_tb="Include TB? (Y/N): "
set tb_flag=
if /i "%include_tb%"=="Y" set tb_flag=--tb

echo.
set /p max_contestants="Maximum Contestants: "
set max_flag=
if not "%max_contestants%"=="" set max_flag=--max %max_contestants%

echo.
set /p tournament_name="Tournament Name (FF, TT, TOT): "
set prizes_flag=
if not "%tournament_name%"=="" set prizes_flag=--prizes "%tournament_name%"

echo.
echo Building Markdown Table...
echo.

python main.py --url "%url%" %tb_flag% %max_flag% %prizes_flag%

echo.
set /p choice="Continue? (Y/N): "
if /i "%choice%"=="Y" (
    set url=
    set include_tb=
    set tb_flag=
    set max_contestants=
    set max_flag=
    set tournament=
    set prizes_flag=
    goto main_section
) else (
    exit /b 0
)