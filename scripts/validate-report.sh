#!/bin/bash
# Validates test report generation
set -e

cd "$(dirname "$0")/.."

echo "=== Validating Report Generation ==="

rm -rf reports/
mkdir -p reports

# Run passing tests only
bundle exec cucumber --tags "not @error-handling" --format html --out reports/cucumber.html --publish-quiet

if [[ ! -f reports/cucumber.html ]]; then
  echo "❌ FAIL: cucumber.html not generated"
  exit 1
fi

size=$(wc -c < reports/cucumber.html)
if [[ $size -lt 1000 ]]; then
  echo "❌ FAIL: cucumber.html too small ($size bytes)"
  exit 1
fi

# Basic HTML validity
if ! grep -q "</html>" reports/cucumber.html; then
  echo "❌ FAIL: Report HTML malformed"
  exit 1
fi

echo "✅ Report generated: reports/cucumber.html ($size bytes)"
