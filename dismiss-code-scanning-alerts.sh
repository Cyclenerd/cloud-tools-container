#!/usr/bin/env bash

# Dismiss all open code scanning alerts in the repository
# Usage: ./dismiss-code-scanning-alerts.sh

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "========================================"
echo "Code Scanning Alert Dismissal Script"
echo "========================================"
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
	echo -e "${RED}Error: GitHub CLI (gh) is not installed.${NC}"
	echo "Please install it from: https://cli.github.com/"
	exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null; then
	echo -e "${RED}Error: Not authenticated with GitHub CLI.${NC}"
	echo "Please run: gh auth login"
	exit 1
fi

# Get repository info
OWNER=$(gh repo view --json owner -q .owner.login)
REPO=$(gh repo view --json name -q .name)

echo -e "${YELLOW}Repository: $OWNER/$REPO${NC}"
echo ""

# Fetch all open alerts
echo "Fetching open code scanning alerts..."
TEMP_FILE=$(mktemp)
trap "rm -f $TEMP_FILE" EXIT

gh api repos/"$OWNER"/"$REPO"/code-scanning/alerts --paginate 2>/dev/null | \
  jq -r '.[] | select(.state == "open") | .number' > "$TEMP_FILE"

TOTAL=$(wc -l < "$TEMP_FILE" | tr -d ' ')

if [ "$TOTAL" -eq 0 ]; then
	echo -e "${GREEN}No open code scanning alerts found!${NC}"
	exit 0
fi

echo -e "${YELLOW}Found $TOTAL open alerts to dismiss${NC}"
echo ""

# Set dismissal reason and comment
REASON="won't fix"
COMMENT="Bulk dismissal of code scanning alerts"

echo -e "${YELLOW}Starting dismissal process...${NC}"
echo ""

COUNT=0
FAILED=0

while IFS= read -r alert_number; do
	if gh api -X PATCH "repos/$OWNER/$REPO/code-scanning/alerts/$alert_number" \
		-f state='dismissed' \
		-f dismissed_reason="$REASON" \
		-f dismissed_comment="$COMMENT" \
		--silent 2>/dev/null; then
		((COUNT++))
		if (( COUNT % 100 == 0 )); then
			echo -e "${GREEN}Progress: $COUNT/$TOTAL alerts dismissed...${NC}"
		fi
	else
		((FAILED++))
	fi
done < "$TEMP_FILE"

echo ""
echo "========================================"
echo -e "${GREEN}Summary:${NC}"
echo "  Total alerts: $TOTAL"
echo "  Successfully dismissed: $COUNT"
echo "  Failed: $FAILED"
echo "========================================"
