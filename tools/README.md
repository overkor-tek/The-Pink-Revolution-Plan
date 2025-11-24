# 🛠️ Pink Revolution Tools

Tools and utilities for the Pink Revolution transformation.

## Available Tools

### pink_revolution.py

Python tool for scanning codebases and identifying blue colors that need to be transformed to pink.

#### Features

- **Automatic Blue Detection** - Finds hex, RGB, named, and terminal colors
- **Smart Suggestions** - Provides Pink Revolution standard color replacements
- **Multiple Formats** - Supports hex (#007bff), RGB (rgb(0,123,255)), named (blue), and ANSI terminal codes
- **Comprehensive Scanning** - Works with JS, TS, Python, CSS, HTML, and more
- **Detailed Reports** - Line-by-line findings with context

#### Installation

Requires Python 3.6+. No additional dependencies needed!

```bash
# Make executable (optional)
chmod +x tools/pink_revolution.py
```

#### Usage

**Scan a directory and get JSON output:**
```bash
python tools/pink_revolution.py scan /path/to/repository
```

**Generate a human-readable report:**
```bash
python tools/pink_revolution.py report /path/to/repository
```

**Scan current directory:**
```bash
python tools/pink_revolution.py report .
```

**Save report to file:**
```bash
python tools/pink_revolution.py report /path/to/repo > blue_colors_found.txt
```

#### Example Output

```
================================================================================
💖 PINK REVOLUTION - BLUE COLOR SCAN REPORT 💖
================================================================================

Files Scanned: 125
Files with Blue Colors: 8
Total Blue Colors Found: 23

Findings by Type:
  - hex: 15
  - named: 5
  - rgb: 3

================================================================================
DETAILED FINDINGS
================================================================================

📄 src/styles/theme.css
   Found 3 blue color(s)

   Line 12, Col 15
   Type: hex
   Original:  #007bff
   Suggested: #FF69B4
   Context: .button-primary { background: #007bff; }

   Line 24, Col 20
   Type: hex
   Original:  #2196F3
   Suggested: #FF1493
   Context: .gradient { background: linear-gradient(#2196F3, #1976...

📄 utils/logger.js
   Found 1 blue color(s)

   Line 45, Col 32
   Type: terminal
   Original:  \x1b[34m
   Suggested: \x1b[35m
   Context: console.log('\x1b[34mINFO:\x1b[0m', message);
```

#### Color Mappings

The tool uses Pink Revolution standard color mappings:

| Original (Blue) | Replacement (Pink) | Usage |
|----------------|-------------------|-------|
| #007bff | #FF69B4 | Hot Pink (Bootstrap buttons) |
| #2196F3 | #FF1493 | Deep Pink (Material UI) |
| #1976D2 | #C71585 | Medium Violet Red (Dark accents) |
| blue | hotpink | Named colors |
| \x1b[34m | \x1b[35m | Terminal colors |

#### Supported File Types

- JavaScript/TypeScript: .js, .jsx, .ts, .tsx
- Python: .py
- HTML: .html, .htm
- Stylesheets: .css, .scss, .sass, .less
- Config: .json, .yaml, .yml
- Markdown: .md, .markdown
- And more!

#### Skipped Directories

Automatically skips:
- node_modules
- .git
- venv/env
- dist/build
- __pycache__
- coverage

#### Workflow

1. **Scan** - Use the tool to find all blue colors
2. **Review** - Check the findings and confirm changes
3. **Transform** - Manually apply the suggested replacements
4. **Test** - Verify the changes work correctly
5. **Deploy** - Push the pink revolution!

#### Tips

**For large repositories:**
```bash
# Scan and save report
python tools/pink_revolution.py report /path/to/repo > findings.txt

# Review findings
less findings.txt

# Count total findings
python tools/pink_revolution.py scan /path/to/repo | jq '.total_findings'
```

**For specific directories:**
```bash
# Only scan src/
python tools/pink_revolution.py report src/

# Only scan styles
python tools/pink_revolution.py report src/styles/
```

**Before committing:**
```bash
# Verify no blue colors remain
python tools/pink_revolution.py report . | grep "Total Blue Colors Found: 0"
```

## Available Tools

### badge_generator.py

Python tool for generating Pink Revolution badges for README files.

#### Features

- **Pink Revolution Status** - Generate status badges (Complete, In Progress, etc.)
- **Standard Badges** - License, version, tests, documentation
- **Custom Colors** - All badges use Pink Revolution color palette
- **Multiple Formats** - Single badge or complete badge section

#### Installation

Requires Python 3.6+. No additional dependencies!

```bash
# Make executable (optional)
chmod +x tools/badge_generator.py
```

#### Usage

**Generate Pink Revolution badge:**
```bash
python tools/badge_generator.py --status complete
# Output: ![Pink Revolution](https://img.shields.io/badge/...)
```

**Generate all badges for a repository:**
```bash
python tools/badge_generator.py --all --repo philosopher-ai-backend \
  --status complete --colors 6 --version 1.2.0
```

**Generate single badge type:**
```bash
# License badge
python tools/badge_generator.py --single license --license MIT

# Version badge
python tools/badge_generator.py --single version --version 2.0.0

# Tests badge
python tools/badge_generator.py --single tests --tests passing

# Color transformation count
python tools/badge_generator.py --single colors --colors 15
```

#### Example Output

```markdown
# philosopher-ai-backend

![Pink Revolution](https://img.shields.io/badge/Pink%20Revolution-%E2%9C%93%20Complete-FF69B4?style=flat&logo=github) ![License: MIT](https://img.shields.io/badge/License-MIT-FF69B4?style=flat) ![Version](https://img.shields.io/badge/version-1.2.0-FF1493?style=flat) ![Status](https://img.shields.io/badge/status-active-FF69B4?style=flat) ![Tests](https://img.shields.io/badge/tests-passing-FF69B4?style=flat) ![Documentation](https://img.shields.io/badge/docs-90%25-FF69B4?style=flat) ![Colors Transformed](https://img.shields.io/badge/colors%20transformed-6-FF69B4?style=flat)
```

#### Badge Status Options

- `complete` - ✓ Complete (Hot Pink #FF69B4)
- `in_progress` - In Progress (Deep Pink #FF1493)
- `pending` - Pending (Light Pink #FFB6C1)
- `not_started` - Not Started (Medium Violet Red #C71585)

---

## Future Tools (Planned)

### pink_transform.py
- Automatically apply transformations
- Dry-run mode
- Backup originals
- Undo functionality

### pink_validate.py
- Validate Pink Revolution standards compliance
- Check color accessibility
- Verify consistent usage

### pink_badge.py
- Generate Pink Revolution badges
- Update README files
- Track transformation status

## Contributing

Have ideas for new tools? See [CONTRIBUTING.md](../CONTRIBUTING.md)!

## Support

Need help? See [SUPPORT.md](../SUPPORT.md) or open an issue.

---

**💖 The Pink Revolution continues with better tools! 💖**
