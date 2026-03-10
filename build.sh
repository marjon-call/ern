#!/bin/bash
# Build Script
set -e

echo "Building all contracts..."
forge build
echo "Build complete"
