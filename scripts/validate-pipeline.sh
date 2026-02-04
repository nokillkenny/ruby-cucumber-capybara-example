#!/bin/bash
# End-to-end validation of the full report pipeline
set -e

SHOWCASE_DIR="/tmp/test-showcase-sim"

echo "=== Full Pipeline Validation ==="

# Step 1: Generate report
echo "Step 1: Generating report..."
./scripts/validate-report.sh

# Step 2: Simulate artifact propagation
echo ""
echo "Step 2: Simulating artifact propagation..."
./scripts/simulate-artifact.sh "$SHOWCASE_DIR"

# Step 3: Validate final structure
echo ""
echo "Step 3: Validating showcase structure..."

expected_files=(
  "$SHOWCASE_DIR/ruby-cucumber/index.html"
)

for f in "${expected_files[@]}"; do
  if [[ -f "$f" ]]; then
    echo "✅ $f"
  else
    echo "❌ Missing: $f"
    exit 1
  fi
done

# Check at least one timestamped report exists
report_count=$(find "$SHOWCASE_DIR/ruby-cucumber" -name "cucumber.html" | wc -l)
if [[ $report_count -gt 0 ]]; then
  echo "✅ Found $report_count timestamped report(s)"
else
  echo "❌ No timestamped reports found"
  exit 1
fi

echo ""
echo "=== Pipeline Validation Complete ==="
echo "Preview: open $SHOWCASE_DIR/ruby-cucumber/index.html"
