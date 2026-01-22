# UCI Parser

## Description

Scrape and parse Chess.com or other websites using this UCI (Universal Chess Info) parser

## Installation

**Bash:**

```
git clone https://github.com/SiegieSiegie/uci-parser
pip install -r requirements.txt
```

## Usage

**Write:**

```
python main.py --url **URL** --tb --max **number**
```

**Wait for the ready-to-use table!**

### Arguments

- **--url** -> URL of the page with contestants table
- **--tb** -> Add this argument if you want to include tiebreak point into the markdown table
- **--max** -> Maximum amount of contestants to include into the markdown table
