#!/bin/bash

echo "Validating development environment..."

# Check required tools
tools=("node" "npm" "git" "curl" "postgresql")
for tool in "${tools[@]}"; do
    if ! command -v $tool &> /dev/null; then
        echo "❌ $tool is not installed"
        exit 1
    else
        echo "✅ $tool is installed"
    fi
done

# Check Node.js version
node_version=$(node -v)
echo "Node.js version: $node_version"

# Check npm version
npm_version=$(npm -v)
echo "npm version: $npm_version"

# Check workspace structure
directories=("client" "server" "shared")
for dir in "${directories[@]}"; do
    if [ ! -d "../$dir" ]; then
        echo "❌ $dir directory is missing"
        exit 1
    else
        echo "✅ $dir directory exists"
    fi
    
    if [ ! -f "../$dir/package.json" ]; then
        echo "❌ $dir/package.json is missing"
        exit 1
    else
        echo "✅ $dir/package.json exists"
    fi
done

# Check required environment variables
required_vars=("NODE_ENV" "DATABASE_URL" "CHROME_PATH")
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "❌ $var is not set"
        exit 1
    else
        echo "✅ $var is set"
    fi
done

echo "✅ Environment validation complete"
