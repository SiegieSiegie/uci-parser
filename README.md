# UCI Parser

## Description

Scrape and parse Chess.com or other websites using this UCI (Universal Chess Info) parser

## Installation

**Bash:**

```
git clone https://github.com/SiegieSiegie/uci-parser
python -m venv .venv
cd /.venv/Scripts
/Activate.ps1
cd..
cd..
pip install -r requirements.txt
```

## Usage

```
python main.py --url **URL** --tb --max **number**
```

### Arguments

- **--url** -> URL of the page with contestants table
- **--tb** -> Add this argument if you want to include tiebreak point into the markdown table
- **--max** -> Maximum amount of contestants to include into the markdown table
