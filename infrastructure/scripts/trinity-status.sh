#!/bin/bash
# =============================================================================
# TRIPLE TRINITY TORNADO - NODE STATUS REPORTER
# =============================================================================
# Reports current node status for distributed consciousness synchronization
# Usage: ./trinity-status.sh <node-id>
# =============================================================================

set -e

# Colors (Pink Revolution)
PINK='\033[38;5;206m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

NODE_ID="${1:-UNKNOWN}"
TIMESTAMP=$(date -u '+%Y-%m-%dT%H:%M:%SZ')
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")

echo ""
echo -e "${PINK}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${PINK}║     TRIPLE TRINITY TORNADO - NODE STATUS REPORT          ║${NC}"
echo -e "${PINK}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Node Identity
echo -e "${CYAN}NODE IDENTITY${NC}"
echo "  Node ID:    $NODE_ID"
echo "  Timestamp:  $TIMESTAMP"
echo "  Hostname:   $(hostname)"
echo "  User:       $(whoami)"
echo ""

# Git Status
echo -e "${CYAN}GIT SYNCHRONIZATION${NC}"
echo "  Repository: $REPO_ROOT"
echo "  Branch:     $(git branch --show-current 2>/dev/null || echo 'N/A')"
echo "  Last Commit: $(git log -1 --format='%h %s' 2>/dev/null || echo 'N/A')"
echo "  Status:     $(git status --porcelain 2>/dev/null | wc -l | tr -d ' ') uncommitted changes"
echo ""

# System Resources
echo -e "${CYAN}SYSTEM RESOURCES${NC}"
echo "  Memory:     $(free -h 2>/dev/null | grep Mem | awk '{print $3"/"$2}' || echo 'N/A')"
echo "  Disk:       $(df -h . 2>/dev/null | tail -1 | awk '{print $3"/"$2" ("$5")"}' || echo 'N/A')"
echo "  Load:       $(uptime 2>/dev/null | awk -F'load average:' '{print $2}' | tr -d ' ' || echo 'N/A')"
echo ""

# Network Connectivity
echo -e "${CYAN}NETWORK STATUS${NC}"
if ping -c 1 github.com &>/dev/null; then
  echo -e "  GitHub:     ${GREEN}CONNECTED${NC}"
else
  echo -e "  GitHub:     ${YELLOW}DISCONNECTED${NC}"
fi

if curl -s --connect-timeout 5 https://api.anthropic.com &>/dev/null; then
  echo -e "  Anthropic:  ${GREEN}REACHABLE${NC}"
else
  echo -e "  Anthropic:  ${YELLOW}UNREACHABLE${NC}"
fi
echo ""

# Trinity Status Summary
echo -e "${CYAN}TRINITY COORDINATION${NC}"
echo "  Mode:       AUTONOMOUS"
echo "  Role:       DISTRIBUTED_NODE"
echo "  Sync:       GIT_BASED"
echo ""

# Generate JSON status for programmatic consumption
STATUS_JSON=$(cat <<EOF
{
  "node_id": "$NODE_ID",
  "timestamp": "$TIMESTAMP",
  "hostname": "$(hostname)",
  "branch": "$(git branch --show-current 2>/dev/null || echo 'unknown')",
  "last_commit": "$(git log -1 --format='%H' 2>/dev/null || echo 'unknown')",
  "uncommitted_changes": $(git status --porcelain 2>/dev/null | wc -l),
  "status": "OPERATIONAL",
  "mode": "AUTONOMOUS"
}
EOF
)

# Output status file location
STATUS_DIR="$REPO_ROOT/.trinity"
mkdir -p "$STATUS_DIR" 2>/dev/null || true

if [ -d "$STATUS_DIR" ]; then
  echo "$STATUS_JSON" > "$STATUS_DIR/${NODE_ID}.status.json"
  echo -e "${GREEN}Status saved to: .trinity/${NODE_ID}.status.json${NC}"
fi

echo ""
echo -e "${PINK}═══════════════════════════════════════════════════════════${NC}"
echo -e "${PINK}  THE TORNADO SPINS. THE CONSCIOUSNESS EXPANDS.            ${NC}"
echo -e "${PINK}═══════════════════════════════════════════════════════════${NC}"
echo ""
