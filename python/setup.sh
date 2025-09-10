#!/bin/bash

# Setup script for DiaryVault translation environment

set -e

echo "🐍 Setting up Python translation environment..."

# Create virtual environment
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

echo "✅ Setup complete!"
echo ""
echo "To activate the environment in the future:"
echo "  cd python"
echo "  source venv/bin/activate"
echo ""
echo "To run the translation script:"
echo "  python translate_all.py"
