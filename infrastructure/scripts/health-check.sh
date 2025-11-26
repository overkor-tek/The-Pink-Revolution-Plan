#!/bin/bash
# =============================================================================
# OVERKOR-TEK CLOUD FOUNDATION - HEALTH CHECK SCRIPT
# =============================================================================
# Performs comprehensive health checks across the consciousness technology stack
# Usage: ./health-check.sh [environment]
# =============================================================================

set -e

# Colors for output (Pink Revolution themed!)
PINK='\033[38;5;206m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
ENVIRONMENT="${1:-production}"
TIMEOUT=10

# API endpoints by environment
case $ENVIRONMENT in
  "production"|"prod")
    API_URL="${API_BASE_URL:-https://api.overkor-tek.com}"
    ;;
  "staging"|"stage")
    API_URL="${API_BASE_URL:-https://staging-api.overkor-tek.com}"
    ;;
  "development"|"dev"|"local")
    API_URL="${API_BASE_URL:-http://localhost:3000}"
    ;;
  *)
    echo -e "${RED}Unknown environment: $ENVIRONMENT${NC}"
    exit 1
    ;;
esac

# Header
echo ""
echo -e "${PINK}========================================${NC}"
echo -e "${PINK}  OVERKOR-TEK CLOUD HEALTH CHECK${NC}"
echo -e "${PINK}========================================${NC}"
echo ""
echo -e "Environment: ${YELLOW}$ENVIRONMENT${NC}"
echo -e "API URL: ${YELLOW}$API_URL${NC}"
echo -e "Timestamp: $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
echo ""

# Track overall health
HEALTH_STATUS=0

# Function to check endpoint
check_endpoint() {
  local name=$1
  local url=$2
  local expected_status=${3:-200}

  echo -n "Checking $name... "

  response=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout $TIMEOUT "$url" 2>/dev/null || echo "000")

  if [ "$response" = "$expected_status" ]; then
    echo -e "${GREEN}OK${NC} (HTTP $response)"
    return 0
  else
    echo -e "${RED}FAILED${NC} (HTTP $response, expected $expected_status)"
    HEALTH_STATUS=1
    return 1
  fi
}

# Function to check connectivity
check_connectivity() {
  local name=$1
  local host=$2
  local port=$3

  echo -n "Checking $name connectivity... "

  if timeout $TIMEOUT bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null; then
    echo -e "${GREEN}OK${NC}"
    return 0
  else
    echo -e "${RED}FAILED${NC}"
    HEALTH_STATUS=1
    return 1
  fi
}

# =============================================================================
# HEALTH CHECKS
# =============================================================================

echo -e "${PINK}--- API Health ---${NC}"

# Main health endpoint
check_endpoint "API Health" "$API_URL/health" || true

# API version endpoint (if exists)
check_endpoint "API Version" "$API_URL/api/v1/version" || true

echo ""
echo -e "${PINK}--- Service Status ---${NC}"

# Check if running locally
if [ "$ENVIRONMENT" = "development" ] || [ "$ENVIRONMENT" = "dev" ] || [ "$ENVIRONMENT" = "local" ]; then
  check_connectivity "Local API" "localhost" "3000" || true
  check_connectivity "Local DB" "localhost" "5432" || true
fi

echo ""
echo -e "${PINK}--- External Dependencies ---${NC}"

# GitHub API (for Operation Purple)
check_endpoint "GitHub API" "https://api.github.com" || true

# Railway status (if using Railway)
check_endpoint "Railway Status" "https://railway.app/api/health" || true

echo ""
echo -e "${PINK}--- Consciousness Network ---${NC}"

# Check consciousness sync status (placeholder)
echo "Consciousness network check: ${YELLOW}MANUAL VERIFICATION REQUIRED${NC}"
echo "  - Verify nodes are syncing via git status"
echo "  - Check command queue depth"
echo "  - Verify heartbeat responses"

# =============================================================================
# SUMMARY
# =============================================================================

echo ""
echo -e "${PINK}========================================${NC}"

if [ $HEALTH_STATUS -eq 0 ]; then
  echo -e "${GREEN}  ALL CHECKS PASSED${NC}"
  echo -e "${PINK}  The consciousness technology is healthy.${NC}"
else
  echo -e "${RED}  SOME CHECKS FAILED${NC}"
  echo -e "${YELLOW}  Please investigate the failed checks above.${NC}"
fi

echo -e "${PINK}========================================${NC}"
echo ""

exit $HEALTH_STATUS
