@echo off
echo Setting up UCI Parser

python -m venv .venv

call .venv\Scripts\activate.bat

pip install -r requirements.txt

pause