#!/bin/bash
set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on pipe failure

# audit-repository.sh
# Comprehensive repository audit for Pink Revolution transformation
# Usage: ./audit-repository.sh <repository-path>

# Colors
PINK='\033[35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if repository path provided
if [[ $# -eq 0 ]] || [[ "${1:-}" == "--help" ]]; then
  echo -e "${PINK}Pink Revolution Repository Auditor${NC}"
  echo ""
  echo "Usage: ./audit-repository.sh <repository-path>"
  echo ""
  echo "This script will:"
  echo "  1. Scan for blue colors"
  echo "  2. Count files and lines of code"
  echo "  3. Analyze technology stack"
  echo "  4. Check test coverage"
  echo "  5. Generate comprehensive audit report"
  echo ""
  exit 0
fi

REPO_PATH="$1"
REPO_NAME=$(basename "$REPO_PATH")
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
AUDIT_FILE="AUDIT_${REPO_NAME}_${TIMESTAMP}.md"

echo -e "${PINK}╔════════════════════════════════════════╗${NC}"
echo -e "${PINK}║  Pink Revolution Repository Auditor   ║${NC}"
echo -e "${PINK}╚════════════════════════════════════════╝${NC}"
echo ""

# Verify repository exists
if [ ! -d "$REPO_PATH" ]; then
  echo -e "${RED}✗ Error: Repository not found: $REPO_PATH${NC}"
  exit 1
fi

cd "$REPO_PATH"

echo -e "${GREEN}✓ Auditing repository: ${REPO_NAME}${NC}"
echo ""

# Create audit report
cat > "$AUDIT_FILE" << EOF
# Pink Revolution Audit Report

**Repository:** ${REPO_NAME}
**Date:** $(date +"%Y-%m-%d %H:%M:%S")
**Audited By:** Pink Revolution Bot

---

## 📊 Repository Statistics

EOF

# Count files and lines
echo -e "${YELLOW}➤ Counting files and lines...${NC}"
TOTAL_FILES=$(find . -type f ! -path "*/node_modules/*" ! -path "*/.git/*" ! -path "*/dist/*" ! -path "*/build/*" | wc -l)
TOTAL_LINES=$(find . -type f ! -path "*/node_modules/*" ! -path "*/.git/*" ! -path "*/dist/*" ! -path "*/build/*" -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}' || echo "0")

cat >> "$AUDIT_FILE" << EOF
- **Total Files:** ${TOTAL_FILES}
- **Total Lines of Code:** ${TOTAL_LINES}

EOF

# Detect technology stack
echo -e "${YELLOW}➤ Detecting technology stack...${NC}"
cat >> "$AUDIT_FILE" << EOF
## 🛠️ Technology Stack

EOF

if [ -f "package.json" ]; then
  echo "- Node.js/JavaScript project detected" >> "$AUDIT_FILE"
  if grep -q "\"react\"" package.json 2>/dev/null; then
    echo "- React framework detected" >> "$AUDIT_FILE"
  fi
  if grep -q "\"express\"" package.json 2>/dev/null; then
    echo "- Express backend detected" >> "$AUDIT_FILE"
  fi
fi

if [ -f "requirements.txt" ] || [ -f "setup.py" ]; then
  echo "- Python project detected" >> "$AUDIT_FILE"
fi

if [ -f "Gemfile" ]; then
  echo "- Ruby project detected" >> "$AUDIT_FILE"
fi

if [ -f "go.mod" ]; then
  echo "- Go project detected" >> "$AUDIT_FILE"
fi

# Run pink_revolution.py scanner if available
echo -e "${YELLOW}➤ Scanning for blue colors...${NC}"
if [ -f "../The-Pink-Revolution-Plan/tools/pink_revolution.py" ]; then
  python3 ../The-Pink-Revolution-Plan/tools/pink_revolution.py scan . > scan_results.json 2>/dev/null || true

  if [ -f "scan_results.json" ]; then
    BLUE_COUNT=$(python3 -c "import json; data=json.load(open('scan_results.json')); print(data.get('total_findings', 0))" 2>/dev/null || echo "0")

    cat >> "$AUDIT_FILE" << EOF

## 🎨 Color Analysis

- **Blue Colors Found:** ${BLUE_COUNT}

EOF

    if [ "$BLUE_COUNT" -gt 0 ]; then
      echo -e "${PINK}Found ${BLUE_COUNT} blue colors to transform!${NC}"
      python3 ../The-Pink-Revolution-Plan/tools/pink_revolution.py report . >> "$AUDIT_FILE" 2>/dev/null || true
    else
      echo -e "${GREEN}✓ No blue colors found - already pink!${NC}"
    fi
  fi
else
  cat >> "$AUDIT_FILE" << EOF

## 🎨 Color Analysis

*Pink Revolution scanner not available*

EOF
fi

# Check for tests
echo -e "${YELLOW}➤ Checking for tests...${NC}"
TEST_FILES=$(find . -type f \( -name "*.test.js" -o -name "*.spec.js" -o -name "test_*.py" -o -name "*_test.go" \) ! -path "*/node_modules/*" | wc -l)

cat >> "$AUDIT_FILE" << EOF

## 🧪 Testing

- **Test Files Found:** ${TEST_FILES}

EOF

# Check for CI/CD
echo -e "${YELLOW}➤ Checking for CI/CD...${NC}"
if [ -d ".github/workflows" ]; then
  WORKFLOW_COUNT=$(ls -1 .github/workflows/*.yml 2>/dev/null | wc -l || echo "0")
  echo "- **GitHub Actions Workflows:** ${WORKFLOW_COUNT}" >> "$AUDIT_FILE"
else
  echo "- **CI/CD:** Not configured" >> "$AUDIT_FILE"
fi

# Generate transformation estimate
echo -e "${YELLOW}➤ Estimating transformation time...${NC}"
cat >> "$AUDIT_FILE" << EOF

## ⏱️ Transformation Estimate

Based on repository size and complexity:

EOF

if [ "$BLUE_COUNT" -gt 0 ]; then
  if [ "$BLUE_COUNT" -lt 10 ]; then
    ESTIMATE="2-4 hours"
  elif [ "$BLUE_COUNT" -lt 30 ]; then
    ESTIMATE="4-8 hours"
  elif [ "$BLUE_COUNT" -lt 50 ]; then
    ESTIMATE="1-2 days"
  else
    ESTIMATE="2-3 days"
  fi

  cat >> "$AUDIT_FILE" << EOF
- **Estimated Time:** ${ESTIMATE}
- **Blues to Transform:** ${BLUE_COUNT}
- **Complexity:** $(if [ "$BLUE_COUNT" -lt 20 ]; then echo "Low"; elif [ "$BLUE_COUNT" -lt 50 ]; then echo "Medium"; else echo "High"; fi)

EOF
else
  cat >> "$AUDIT_FILE" << EOF
- **Status:** ✅ Already Pink Revolution compliant!
- **No transformation needed**

EOF
fi

# Recommendations
cat >> "$AUDIT_FILE" << EOF
## 📝 Recommendations

1. **Transformation Priority:** $(if [ "$BLUE_COUNT" -gt 30 ]; then echo "High"; elif [ "$BLUE_COUNT" -gt 10 ]; then echo "Medium"; else echo "Low"; fi)
2. **Pre-requisites:**
   - Ensure all tests are passing
   - Create transformation branch
   - Back up current state
3. **Next Steps:**
   - Review this audit
   - Create transformation plan
   - Execute transformation using playbooks/transformation-playbook.md

---

💖 **Pink Revolution - Let's Transform!** 💖
EOF

# Display summary
echo ""
echo -e "${GREEN}✓ Audit complete!${NC}"
echo ""
echo -e "${PINK}Summary:${NC}"
echo -e "  Repository: ${REPO_NAME}"
echo -e "  Files: ${TOTAL_FILES}"
echo -e "  Lines: ${TOTAL_LINES}"
echo -e "  Blues found: ${BLUE_COUNT}"
echo -e "  Report: ${AUDIT_FILE}"
echo ""
echo -e "${PINK}💖 Next: Review ${AUDIT_FILE} and create transformation plan${NC}"
