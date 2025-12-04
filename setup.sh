#!/bin/bash
set -e

echo "🚀 App Factory V2 - One-Time Setup"
echo "=================================="
echo ""

# Check OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     PLATFORM=Linux;;
    Darwin*)    PLATFORM=Mac;;
    MINGW*|MSYS*|CYGWIN*) PLATFORM=Windows;;
    *)          PLATFORM="UNKNOWN:${OS}"
esac

echo "Platform: $PLATFORM"
echo ""

# 1. Check/Install Node.js
echo "📦 1/4 Checking Node.js..."
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node --version)
    echo "   ✅ Node.js $NODE_VERSION installed"
else
    echo "   ❌ Node.js not found"
    echo ""
    echo "Please install Node.js first:"
    if [ "$PLATFORM" = "Mac" ]; then
        echo "   brew install node"
    elif [ "$PLATFORM" = "Linux" ]; then
        echo "   https://nodejs.org/"
    else
        echo "   https://nodejs.org/"
    fi
    exit 1
fi

# 2. Check/Install GitHub CLI
echo ""
echo "📦 2/4 Checking GitHub CLI..."
if command -v gh >/dev/null 2>&1; then
    GH_VERSION=$(gh --version | head -1)
    echo "   ✅ $GH_VERSION installed"
    
    # Check if authenticated
    if gh auth status >/dev/null 2>&1; then
        echo "   ✅ GitHub authenticated"
    else
        echo "   🔐 Authenticating to GitHub..."
        gh auth login
    fi
else
    echo "   ❌ GitHub CLI not found"
    echo ""
    echo "Please install GitHub CLI first:"
    if [ "$PLATFORM" = "Mac" ]; then
        echo "   brew install gh"
    elif [ "$PLATFORM" = "Linux" ]; then
        echo "   https://cli.github.com/"
    else
        echo "   https://cli.github.com/"
    fi
    exit 1
fi

# 3. Install MCP Tool
echo ""
echo "📦 3/4 Installing App Factory MCP tool..."
npm install -g git+https://github.com/nelc/appfactory-v2-mcp.git
echo "   ✅ MCP tool installed"

# 4. Configure Cursor
echo ""
echo "📦 4/4 Configuring Cursor..."

# Determine config path
if [ "$PLATFORM" = "Mac" ] || [ "$PLATFORM" = "Linux" ]; then
    CONFIG_DIR="$HOME/.config/cursor"
    CONFIG_FILE="$CONFIG_DIR/mcp.json"
elif [ "$PLATFORM" = "Windows" ]; then
    CONFIG_DIR="$APPDATA/Cursor"
    CONFIG_FILE="$CONFIG_DIR/mcp.json"
fi

mkdir -p "$CONFIG_DIR"

# Create or update MCP config
if [ -f "$CONFIG_FILE" ]; then
    echo "   ⚠️  Cursor MCP config already exists"
    echo "   Please manually add this to $CONFIG_FILE:"
    echo ""
    echo '   "app-factory": {'
    echo '     "command": "app-factory-mcp"'
    echo '   }'
    echo ""
else
    cat > "$CONFIG_FILE" << 'EOF'
{
  "mcpServers": {
    "app-factory": {
      "command": "app-factory-mcp"
    }
  }
}
EOF
    echo "   ✅ Cursor configured"
fi

echo ""
echo "════════════════════════════════════════════════"
echo "✅ Setup Complete!"
echo "════════════════════════════════════════════════"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Restart Cursor (if it's running)"
echo ""
echo "2. In Cursor, start a chat and say:"
echo '   "Generate my [App Name] using App Factory tool"'
echo ""
echo "3. After code is generated, run:"
echo "   ./deploy.sh"
echo ""
echo "4. Add the DNS record shown in the output"
echo ""
echo "════════════════════════════════════════════════"
echo ""

