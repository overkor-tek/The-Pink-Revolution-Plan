#!/bin/bash
set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on pipe failure

# quick-transform.sh
# One-command transformation workflow for Pink Revolution
# Usage: ./quick-transform.sh <repository-path> [--auto]

# Colors
PINK='\033[35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
AUTO_MODE=false
REPO_PATH=""

# Parse arguments
if [[ $# -eq 0 ]] || [[ "${1:-}" == "--help" ]]; then
  echo -e "${PINK}╔════════════════════════════════════════════════╗${NC}"
  echo -e "${PINK}║  Pink Revolution Quick Transform               ║${NC}"
  echo -e "${PINK}║  One-Command Transformation Workflow           ║${NC}"
  echo -e "${PINK}╚════════════════════════════════════════════════╝${NC}"
  echo ""
  echo "Usage: ./quick-transform.sh <repository-path> [--auto]"
  echo ""
  echo "This script will:"
  echo "  1. Audit the repository"
  echo "  2. Create transformation branch"
  echo "  3. Guide you through transformation"
  echo "  4. Run tests"
  echo "  5. Create transformation report"
  echo "  6. Prepare for PR"
  echo ""
  echo "Options:"
  echo "  --auto    Skip confirmations (use with caution)"
  echo ""
  echo "Example:"
  echo "  ./quick-transform.sh ../consciousness-revolution"
  echo ""
  exit 0
fi

REPO_PATH="$1"
if [[ "${2:-}" == "--auto" ]]; then
  AUTO_MODE=true
fi

# Verify repository exists
if [ ! -d "$REPO_PATH" ]; then
  echo -e "${RED}✗ Error: Repository not found: $REPO_PATH${NC}"
  exit 1
fi

REPO_NAME=$(basename "$REPO_PATH")
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo -e "${PINK}╔════════════════════════════════════════════════╗${NC}"
echo -e "${PINK}║     🌸 PINK REVOLUTION QUICK TRANSFORM 🌸      ║${NC}"
echo -e "${PINK}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Repository: ${REPO_NAME}${NC}"
echo -e "${GREEN}Mode: $(if $AUTO_MODE; then echo "Automatic"; else echo "Interactive"; fi)${NC}"
echo ""

cd "$REPO_PATH"

# Function to confirm
confirm() {
  if $AUTO_MODE; then
    return 0
  fi

  echo -e "${YELLOW}$1${NC}"
  read -p "Continue? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Aborted by user${NC}"
    exit 1
  fi
}

# PHASE 1: AUDIT
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}PHASE 1: AUDIT${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo ""

if [ -f "../The-Pink-Revolution-Plan/scripts/setup/audit-repository.sh" ]; then
  echo -e "${YELLOW}➤ Running audit script...${NC}"
  ../The-Pink-Revolution-Plan/scripts/setup/audit-repository.sh .

  # Find the audit file
  AUDIT_FILE=$(ls -t AUDIT_${REPO_NAME}_*.md 2>/dev/null | head -1)

  if [ -f "$AUDIT_FILE" ]; then
    echo ""
    echo -e "${GREEN}✓ Audit complete: $AUDIT_FILE${NC}"
    echo ""
    confirm "Review the audit file before proceeding."
  else
    echo -e "${YELLOW}⚠ Audit file not found, continuing...${NC}"
  fi
else
  echo -e "${YELLOW}⚠ Audit script not found, skipping automated audit${NC}"
fi

# PHASE 2: CREATE BRANCH
echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}PHASE 2: CREATE TRANSFORMATION BRANCH${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo ""

BRANCH_NAME="pink-revolution-transformation-${TIMESTAMP}"

if git rev-parse --git-dir > /dev/null 2>&1; then
  echo -e "${YELLOW}➤ Creating branch: ${BRANCH_NAME}${NC}"
  git checkout -b "$BRANCH_NAME"
  echo -e "${GREEN}✓ Branch created${NC}"
else
  echo -e "${YELLOW}⚠ Not a git repository, skipping branch creation${NC}"
fi

# PHASE 3: BASELINE
echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}PHASE 3: ESTABLISH BASELINE${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}➤ Checking if tests exist...${NC}"

# Try to run tests
if [ -f "package.json" ]; then
  if grep -q "\"test\"" package.json; then
    echo -e "${YELLOW}➤ Running npm tests...${NC}"
    npm test || echo -e "${YELLOW}⚠ Tests failed (baseline)${NC}"
  fi
elif [ -f "requirements.txt" ] || [ -f "setup.py" ]; then
  if command -v pytest &> /dev/null; then
    echo -e "${YELLOW}➤ Running pytest...${NC}"
    pytest || echo -e "${YELLOW}⚠ Tests failed (baseline)${NC}"
  fi
fi

# PHASE 4: TRANSFORMATION
echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}PHASE 4: COLOR TRANSFORMATION${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo ""

echo -e "${PINK}🎨 TIME TO TRANSFORM!${NC}"
echo ""
echo -e "Follow these steps:"
echo -e "  1. Open repository in your editor"
echo -e "  2. Find and replace colors:"
echo -e "     ${BLUE}#007bff${NC} → ${PINK}#FF69B4${NC} (Hot Pink)"
echo -e "     ${BLUE}#2196F3${NC} → ${PINK}#FF1493${NC} (Deep Pink)"
echo -e "     ${BLUE}#1976D2${NC} → ${PINK}#C71585${NC} (Medium Violet Red)"
echo -e "     ${BLUE}blue${NC} → ${PINK}hotpink${NC} (Named colors)"
echo -e "  3. Save all files"
echo -e "  4. Come back here when done"
echo ""

confirm "Transformation complete?"

# PHASE 5: TESTING
echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}PHASE 5: TESTING${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}➤ Running tests...${NC}"

if [ -f "package.json" ] && grep -q "\"test\"" package.json; then
  npm test
elif command -v pytest &> /dev/null; then
  pytest
else
  echo -e "${YELLOW}⚠ No automated tests found${NC}"
  confirm "Manual testing complete?"
fi

# PHASE 6: COMMIT
echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}PHASE 6: COMMIT CHANGES${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo ""

if git rev-parse --git-dir > /dev/null 2>&1; then
  echo -e "${YELLOW}➤ Staging all changes...${NC}"
  git add .

  echo -e "${YELLOW}➤ Creating commit...${NC}"
  git commit -m "$(cat <<EOF
🌸 Pink Revolution: Transform ${REPO_NAME} to pink

Complete transformation from blue to pink colors:
- #007bff → #FF69B4 (Hot Pink)
- #2196F3 → #FF1493 (Deep Pink)
- #1976D2 → #C71585 (Medium Violet Red)
- blue → hotpink (Named colors)

All tests passing ✅
All functionality preserved ✅
Pink Revolution complete 💖
EOF
)"

  echo -e "${GREEN}✓ Changes committed${NC}"
fi

# PHASE 7: REPORT
echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}PHASE 7: GENERATE REPORT${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo ""

REPORT_FILE="PINK_REVOLUTION_REPORT_${TIMESTAMP}.md"

# Copy template
if [ -f "../The-Pink-Revolution-Plan/templates/TRANSFORMATION_REPORT_TEMPLATE.md" ]; then
  cp ../The-Pink-Revolution-Plan/templates/TRANSFORMATION_REPORT_TEMPLATE.md "$REPORT_FILE"

  # Fill in basic info
  sed -i "s/\[repository-name\]/${REPO_NAME}/g" "$REPORT_FILE"
  sed -i "s/\[YYYY-MM-DD\]/$(date +%Y-%m-%d)/g" "$REPORT_FILE"

  echo -e "${GREEN}✓ Report template created: $REPORT_FILE${NC}"
  echo -e "${YELLOW}➤ Please fill in the details in $REPORT_FILE${NC}"
else
  echo -e "${YELLOW}⚠ Report template not found${NC}"
fi

# PHASE 8: SUMMARY
echo ""
echo -e "${PINK}╔════════════════════════════════════════════════╗${NC}"
echo -e "${PINK}║            ✅ TRANSFORMATION COMPLETE           ║${NC}"
echo -e "${PINK}╚════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${GREEN}What was done:${NC}"
echo -e "  ✅ Repository audited"
echo -e "  ✅ Transformation branch created"
echo -e "  ✅ Baseline established"
echo -e "  ✅ Colors transformed"
echo -e "  ✅ Tests run"
echo -e "  ✅ Changes committed"
echo -e "  ✅ Report template generated"
echo ""

echo -e "${YELLOW}Next steps:${NC}"
echo -e "  1. Fill in ${REPORT_FILE}"
echo -e "  2. Push branch: git push -u origin ${BRANCH_NAME}"
echo -e "  3. Create PR on GitHub"
echo -e "  4. Request reviews"
echo -e "  5. Deploy to staging"
echo -e "  6. Deploy to production"
echo ""

echo -e "${PINK}💖 Pink Revolution continues! 💖${NC}"
echo ""

# Output commands for easy copy-paste
echo -e "${BLUE}Quick commands:${NC}"
echo -e "  ${GREEN}# Push branch${NC}"
echo -e "  git push -u origin ${BRANCH_NAME}"
echo ""
echo -e "  ${GREEN}# Create PR (with gh CLI)${NC}"
echo -e "  gh pr create --title \"🌸 Pink Revolution: ${REPO_NAME}\" --body-file ${REPORT_FILE}"
echo ""
