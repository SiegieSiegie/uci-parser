# UCI Parser

Scrape and parse Chess.com or other websites using this UCI (Universal Chess Info) parser

## Installation

### Bash

```
git clone https://github.com/SiegieSiegie/uci-parser
cd uci-parser
python -m venv .venv
cd .venv/Scripts
activate.bat
cd..
cd..
pip install -r requirements.txt
```

## Usage

```
python main.py --url <URL> --tb --max <NUMBER> --prizes <TOURNAMENT>
```

### Arguments

_You can write them in any order_

- **--url** -> URL of the page with contestants table
- **--tb** -> Add this flag if you want to include tiebreak points into the markdown table
- **--max** -> Maximum amount of contestants to include into the markdown table
- **--prizes** -> Name of the tournament to add prizes from

### --prizes Tournaments

| --prizes |    Full Name     |
| -------- | :--------------: |
| FF       | Freestyle Friday |
| TT       |  Titled Tuesday  |
| TOT      |   3 0 Thursday   |
