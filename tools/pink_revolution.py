#!/usr/bin/env python3
"""
Pink Revolution - Blue to Pink Color Transformer
Scans codebases for blue colors and suggests pink replacements

Usage:
    python pink_revolution.py scan <directory>
    python pink_revolution.py transform <file> --dry-run
    python pink_revolution.py report <directory>
"""

import re
import os
import sys
import json
from pathlib import Path
from typing import Dict, List, Tuple
from collections import defaultdict

# Pink Revolution Color Mappings
COLOR_MAPPINGS = {
    # Hex Colors
    '#007bff': '#FF69B4',  # Bootstrap Blue → Hot Pink
    '#0d6efd': '#FF69B4',  # Bootstrap 5 Primary → Hot Pink
    '#2196F3': '#FF1493',  # Material Blue → Deep Pink
    '#1976D2': '#C71585',  # Material Blue Dark → Medium Violet Red
    '#42A5F5': '#FF69B4',  # Material Blue Light → Hot Pink
    '#1E88E5': '#FF1493',  # Material Blue → Deep Pink
    '#1565C0': '#C71585',  # Material Blue Dark → Medium Violet Red
    '#0288D1': '#FF1493',  # Material Light Blue → Deep Pink
    '#039BE5': '#FF1493',  # Material Light Blue → Deep Pink
    '#00BFFF': '#FF69B4',  # Deep Sky Blue → Hot Pink
    '#1E90FF': '#FF1493',  # Dodger Blue → Deep Pink
    '#4169E1': '#FF69B4',  # Royal Blue → Hot Pink
    '#0000FF': '#FF00FF',  # Pure Blue → Magenta
    '#0000CD': '#C71585',  # Medium Blue → Medium Violet Red

    # RGB Colors
    'rgb(0, 123, 255)': 'rgb(255, 105, 180)',  # Bootstrap Blue → Hot Pink
    'rgb(33, 150, 243)': 'rgb(255, 20, 147)',  # Material Blue → Deep Pink
    'rgb(25, 118, 210)': 'rgb(199, 21, 133)',  # Material Blue Dark → Medium Violet Red

    # Named Colors
    'blue': 'hotpink',
    'darkblue': 'deeppink',
    'mediumblue': 'mediumvioletred',
    'lightblue': 'lightpink',
    'royalblue': 'hotpink',
    'dodgerblue': 'deeppink',
    'skyblue': 'pink',
    'deepskyblue': 'hotpink',

    # Terminal Colors (ANSI)
    '\\x1b[34m': '\\x1b[35m',  # Blue → Magenta
    '\\033[34m': '\\033[35m',  # Blue → Magenta (alt format)
    '\\e[34m': '\\e[35m',  # Blue → Magenta (alt format)
}

# File extensions to scan
SCANNABLE_EXTENSIONS = {
    '.js', '.jsx', '.ts', '.tsx',  # JavaScript/TypeScript
    '.py',  # Python
    '.html', '.htm',  # HTML
    '.css', '.scss', '.sass', '.less',  # Stylesheets
    '.json',  # JSON
    '.md', '.markdown',  # Markdown
    '.yaml', '.yml',  # YAML
    '.xml',  # XML
    '.svg',  # SVG
    '.vue',  # Vue
    '.rb',  # Ruby
    '.php',  # PHP
    '.java',  # Java
    '.go',  # Go
    '.rs',  # Rust
    '.c', '.cpp', '.h', '.hpp',  # C/C++
}

# Directories to skip
SKIP_DIRS = {
    'node_modules', '.git', 'venv', 'env', '__pycache__',
    'dist', 'build', '.next', '.nuxt', 'vendor',
    'coverage', '.pytest_cache', '.mypy_cache',
}


class ColorFinder:
    """Find blue colors in files"""

    def __init__(self):
        self.hex_pattern = re.compile(r'#[0-9A-Fa-f]{6}')
        self.rgb_pattern = re.compile(r'rgb\(\s*\d+\s*,\s*\d+\s*,\s*\d+\s*\)')
        self.named_pattern = re.compile(r'\b(blue|darkblue|mediumblue|lightblue|royalblue|dodgerblue|skyblue|deepskyblue)\b', re.IGNORECASE)
        self.terminal_pattern = re.compile(r'\\x1b\[34m|\\033\[34m|\\e\[34m')

    def is_blue_hex(self, color: str) -> bool:
        """Check if hex color is blue"""
        color = color.upper()
        if color in [k.upper() for k in COLOR_MAPPINGS.keys()]:
            return True

        # Parse hex color
        r = int(color[1:3], 16)
        g = int(color[3:5], 16)
        b = int(color[5:7], 16)

        # Check if it's more blue than red/green
        return b > r and b > g and b > 150

    def is_blue_rgb(self, color: str) -> bool:
        """Check if RGB color is blue"""
        match = re.search(r'rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)', color)
        if not match:
            return False

        r, g, b = map(int, match.groups())
        return b > r and b > g and b > 150

    def find_colors(self, content: str, filename: str) -> List[Dict]:
        """Find all blue colors in content"""
        findings = []
        lines = content.split('\n')

        for line_num, line in enumerate(lines, 1):
            # Find hex colors
            for match in self.hex_pattern.finditer(line):
                color = match.group()
                if self.is_blue_hex(color):
                    suggested = COLOR_MAPPINGS.get(color.lower(), '#FF69B4')
                    findings.append({
                        'file': filename,
                        'line': line_num,
                        'column': match.start() + 1,
                        'type': 'hex',
                        'original': color,
                        'suggested': suggested,
                        'context': line.strip()
                    })

            # Find RGB colors
            for match in self.rgb_pattern.finditer(line):
                color = match.group()
                if self.is_blue_rgb(color):
                    suggested = COLOR_MAPPINGS.get(color.lower(), 'rgb(255, 105, 180)')
                    findings.append({
                        'file': filename,
                        'line': line_num,
                        'column': match.start() + 1,
                        'type': 'rgb',
                        'original': color,
                        'suggested': suggested,
                        'context': line.strip()
                    })

            # Find named colors
            for match in self.named_pattern.finditer(line):
                color = match.group()
                suggested = COLOR_MAPPINGS.get(color.lower(), 'hotpink')
                findings.append({
                    'file': filename,
                    'line': line_num,
                    'column': match.start() + 1,
                    'type': 'named',
                    'original': color,
                    'suggested': suggested,
                    'context': line.strip()
                })

            # Find terminal colors
            for match in self.terminal_pattern.finditer(line):
                color = match.group()
                suggested = COLOR_MAPPINGS.get(color, '\\x1b[35m')
                findings.append({
                    'file': filename,
                    'line': line_num,
                    'column': match.start() + 1,
                    'type': 'terminal',
                    'original': color,
                    'suggested': suggested,
                    'context': line.strip()
                })

        return findings


class PinkRevolution:
    """Main Pink Revolution tool"""

    def __init__(self):
        self.finder = ColorFinder()

    def should_scan_file(self, filepath: Path) -> bool:
        """Check if file should be scanned"""
        if filepath.suffix not in SCANNABLE_EXTENSIONS:
            return False

        # Check if in skip directory
        for part in filepath.parts:
            if part in SKIP_DIRS:
                return False

        return True

    def scan_directory(self, directory: str) -> Dict:
        """Scan directory for blue colors"""
        results = {
            'files_scanned': 0,
            'files_with_blue': 0,
            'total_findings': 0,
            'findings_by_file': defaultdict(list),
            'findings_by_type': defaultdict(int)
        }

        directory_path = Path(directory)

        for filepath in directory_path.rglob('*'):
            if not filepath.is_file():
                continue

            if not self.should_scan_file(filepath):
                continue

            try:
                with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()

                findings = self.finder.find_colors(content, str(filepath.relative_to(directory_path)))

                results['files_scanned'] += 1

                if findings:
                    results['files_with_blue'] += 1
                    results['total_findings'] += len(findings)
                    results['findings_by_file'][str(filepath.relative_to(directory_path))] = findings

                    for finding in findings:
                        results['findings_by_type'][finding['type']] += 1

            except Exception as e:
                print(f"Error scanning {filepath}: {e}", file=sys.stderr)

        return results

    def generate_report(self, results: Dict) -> str:
        """Generate human-readable report"""
        report = []
        report.append("=" * 80)
        report.append("💖 PINK REVOLUTION - BLUE COLOR SCAN REPORT 💖")
        report.append("=" * 80)
        report.append("")

        report.append(f"Files Scanned: {results['files_scanned']}")
        report.append(f"Files with Blue Colors: {results['files_with_blue']}")
        report.append(f"Total Blue Colors Found: {results['total_findings']}")
        report.append("")

        if results['findings_by_type']:
            report.append("Findings by Type:")
            for color_type, count in sorted(results['findings_by_type'].items()):
                report.append(f"  - {color_type}: {count}")
            report.append("")

        if results['findings_by_file']:
            report.append("=" * 80)
            report.append("DETAILED FINDINGS")
            report.append("=" * 80)
            report.append("")

            for filename, findings in sorted(results['findings_by_file'].items()):
                report.append(f"📄 {filename}")
                report.append(f"   Found {len(findings)} blue color(s)")
                report.append("")

                for finding in findings:
                    report.append(f"   Line {finding['line']}, Col {finding['column']}")
                    report.append(f"   Type: {finding['type']}")
                    report.append(f"   Original:  {finding['original']}")
                    report.append(f"   Suggested: {finding['suggested']}")
                    report.append(f"   Context: {finding['context'][:60]}...")
                    report.append("")

        report.append("=" * 80)
        report.append("💖 PINK REVOLUTION CONTINUES! 💖")
        report.append("=" * 80)

        return "\n".join(report)


def main():
    """Main entry point"""
    if len(sys.argv) < 2:
        print("Usage: python pink_revolution.py scan <directory>")
        print("       python pink_revolution.py report <directory>")
        sys.exit(1)

    command = sys.argv[1]

    if command == "scan" or command == "report":
        if len(sys.argv) < 3:
            print(f"Usage: python pink_revolution.py {command} <directory>")
            sys.exit(1)

        directory = sys.argv[2]

        if not os.path.isdir(directory):
            print(f"Error: '{directory}' is not a directory")
            sys.exit(1)

        tool = PinkRevolution()
        print(f"🔍 Scanning {directory} for blue colors...")
        print()

        results = tool.scan_directory(directory)

        if command == "report":
            print(tool.generate_report(results))
        else:
            # JSON output for programmatic use
            print(json.dumps(results, indent=2, default=list))

    else:
        print(f"Unknown command: {command}")
        print("Available commands: scan, report")
        sys.exit(1)


if __name__ == "__main__":
    main()
