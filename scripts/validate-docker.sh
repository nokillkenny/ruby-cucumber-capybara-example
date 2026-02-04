#!/bin/bash
# Validates Docker build and test execution
set -e

cd "$(dirname "$0")/.."

echo "=== Docker Validation ==="

echo "Building image..."
docker compose build --quiet

echo "Running tests in container..."
docker compose run --rm tests 2>&1 | tee /tmp/docker-test-output.txt

if grep -q "scenarios.*passed" /tmp/docker-test-output.txt; then
  echo ""
  echo "✅ Docker tests passed"
else
  echo ""
  echo "❌ Docker tests failed"
  exit 1
fi
