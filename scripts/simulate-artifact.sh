#!/bin/bash
# Simulates GHA artifact structure for local testing
set -e

SHOWCASE_DIR="${1:-/tmp/test-showcase-sim}"
TIMESTAMP=$(date -u +%Y-%m-%d-%H%M)

echo "=== Simulating Artifact Propagation ==="
echo "Target: $SHOWCASE_DIR"
echo "Timestamp: $TIMESTAMP"

# Create showcase structure
mkdir -p "$SHOWCASE_DIR/ruby-cucumber/$TIMESTAMP"

# Copy report (simulates artifact download)
if [[ -f reports/cucumber.html ]]; then
  cp reports/cucumber.html "$SHOWCASE_DIR/ruby-cucumber/$TIMESTAMP/"
  echo "✅ Copied report to $SHOWCASE_DIR/ruby-cucumber/$TIMESTAMP/"
else
  echo "❌ No report found. Run scripts/validate-report.sh first"
  exit 1
fi

# Generate index (mirrors aggregate-reports.yml logic)
cat > "$SHOWCASE_DIR/ruby-cucumber/index.html" << EOF
<!DOCTYPE html>
<html><head><title>Ruby Cucumber Reports</title></head>
<body>
<h1>Ruby Cucumber Reports</h1>
<ul>
EOF

for run in $(ls -dr "$SHOWCASE_DIR/ruby-cucumber"/2* 2>/dev/null | head -20); do
  echo "<li><a href=\"$(basename $run)/cucumber.html\">$(basename $run)</a></li>" >> "$SHOWCASE_DIR/ruby-cucumber/index.html"
done

echo '</ul></body></html>' >> "$SHOWCASE_DIR/ruby-cucumber/index.html"

echo "✅ Index generated at $SHOWCASE_DIR/ruby-cucumber/index.html"
echo ""
echo "Preview: open $SHOWCASE_DIR/ruby-cucumber/index.html"
