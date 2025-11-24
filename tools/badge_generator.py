#!/usr/bin/env python3
"""
Pink Revolution Badge Generator
Generates markdown badges for Pink Revolution status and repository stats

Usage:
    python badge_generator.py --repo philosopher-ai-backend --status complete
    python badge_generator.py --all
"""

import argparse
import sys
from urllib.parse import quote

# Badge styles
BADGE_STYLE = "flat"

# Pink Revolution colors
PINK_COLORS = {
    "complete": "FF69B4",      # Hot Pink
    "in_progress": "FF1493",   # Deep Pink
    "pending": "FFB6C1",       # Light Pink
    "not_started": "C71585",   # Medium Violet Red
}

# Status labels
STATUS_LABELS = {
    "complete": "✓ Complete",
    "in_progress": "In Progress",
    "pending": "Pending",
    "not_started": "Not Started",
}


def generate_pink_revolution_badge(status="complete"):
    """Generate Pink Revolution status badge"""
    label = "Pink Revolution"
    message = STATUS_LABELS.get(status, "Unknown")
    color = PINK_COLORS.get(status, "lightgrey")

    badge_url = f"https://img.shields.io/badge/{quote(label)}-{quote(message)}-{color}?style={BADGE_STYLE}&logo=github"

    return f"![Pink Revolution]({badge_url})"


def generate_license_badge(license_type="MIT"):
    """Generate license badge in pink"""
    label = "License"
    message = license_type
    color = PINK_COLORS["complete"]

    badge_url = f"https://img.shields.io/badge/{quote(label)}-{quote(message)}-{color}?style={BADGE_STYLE}"

    return f"![License: {license_type}]({badge_url})"


def generate_version_badge(version="1.0.0"):
    """Generate version badge in pink"""
    label = "version"
    message = version
    color = PINK_COLORS["in_progress"]

    badge_url = f"https://img.shields.io/badge/{quote(label)}-{quote(message)}-{color}?style={BADGE_STYLE}"

    return f"![Version]({badge_url})"


def generate_status_badge(status="active"):
    """Generate project status badge"""
    label = "status"
    message = status
    color = PINK_COLORS["complete"] if status == "active" else PINK_COLORS["pending"]

    badge_url = f"https://img.shields.io/badge/{quote(label)}-{quote(message)}-{color}?style={BADGE_STYLE}"

    return f"![Status]({badge_url})"


def generate_documentation_badge(coverage="90%"):
    """Generate documentation coverage badge"""
    label = "docs"
    message = coverage
    color = PINK_COLORS["complete"]

    badge_url = f"https://img.shields.io/badge/{quote(label)}-{quote(message)}-{color}?style={BADGE_STYLE}"

    return f"![Documentation]({badge_url})"


def generate_tests_badge(status="passing"):
    """Generate tests status badge"""
    label = "tests"
    message = status
    color = PINK_COLORS["complete"] if status == "passing" else "red"

    badge_url = f"https://img.shields.io/badge/{quote(label)}-{quote(message)}-{color}?style={BADGE_STYLE}"

    return f"![Tests]({badge_url})"


def generate_color_transformation_badge(count=0):
    """Generate color transformation count badge"""
    label = "colors transformed"
    message = str(count)
    color = PINK_COLORS["complete"]

    badge_url = f"https://img.shields.io/badge/{quote(label)}-{quote(message)}-{color}?style={BADGE_STYLE}"

    return f"![Colors Transformed]({badge_url})"


def generate_all_badges(repo_name="repository", **kwargs):
    """Generate all common badges for a repository"""
    badges = []

    # Pink Revolution status
    pr_status = kwargs.get("pink_revolution_status", "complete")
    badges.append(generate_pink_revolution_badge(pr_status))

    # License
    license_type = kwargs.get("license", "MIT")
    badges.append(generate_license_badge(license_type))

    # Version
    version = kwargs.get("version", "1.0.0")
    badges.append(generate_version_badge(version))

    # Status
    status = kwargs.get("status", "active")
    badges.append(generate_status_badge(status))

    # Tests
    tests = kwargs.get("tests", "passing")
    badges.append(generate_tests_badge(tests))

    # Documentation
    docs = kwargs.get("docs", "90%")
    badges.append(generate_documentation_badge(docs))

    # Color transformations
    colors = kwargs.get("colors_transformed", 0)
    if colors > 0:
        badges.append(generate_color_transformation_badge(colors))

    return badges


def generate_readme_section(repo_name, **kwargs):
    """Generate complete README badge section"""
    badges = generate_all_badges(repo_name, **kwargs)

    output = []
    output.append(f"# {repo_name}\n")
    output.append(" ".join(badges))
    output.append("\n")

    return "\n".join(output)


def main():
    parser = argparse.ArgumentParser(description="Generate Pink Revolution badges")

    parser.add_argument("--repo", help="Repository name", default="repository")
    parser.add_argument(
        "--status",
        choices=["complete", "in_progress", "pending", "not_started"],
        default="complete",
        help="Pink Revolution status",
    )
    parser.add_argument("--license", default="MIT", help="License type")
    parser.add_argument("--version", default="1.0.0", help="Version number")
    parser.add_argument("--tests", default="passing", help="Test status")
    parser.add_argument("--docs", default="90%", help="Documentation coverage")
    parser.add_argument("--colors", type=int, default=0, help="Colors transformed count")
    parser.add_argument("--all", action="store_true", help="Generate all badges")
    parser.add_argument("--single", help="Generate single badge type")

    args = parser.parse_args()

    if args.single:
        # Generate single badge
        if args.single == "pink":
            print(generate_pink_revolution_badge(args.status))
        elif args.single == "license":
            print(generate_license_badge(args.license))
        elif args.single == "version":
            print(generate_version_badge(args.version))
        elif args.single == "status":
            print(generate_status_badge(args.status))
        elif args.single == "tests":
            print(generate_tests_badge(args.tests))
        elif args.single == "docs":
            print(generate_documentation_badge(args.docs))
        elif args.single == "colors":
            print(generate_color_transformation_badge(args.colors))
        else:
            print(f"Unknown badge type: {args.single}", file=sys.stderr)
            sys.exit(1)
    elif args.all:
        # Generate all badges
        section = generate_readme_section(
            args.repo,
            pink_revolution_status=args.status,
            license=args.license,
            version=args.version,
            tests=args.tests,
            docs=args.docs,
            colors_transformed=args.colors,
        )
        print(section)
    else:
        # Default: generate Pink Revolution badge
        print(generate_pink_revolution_badge(args.status))


if __name__ == "__main__":
    main()
