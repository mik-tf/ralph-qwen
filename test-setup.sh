#!/bin/bash
# Test Script for Ralph-Qwen Setup
# Verifies that Qwen CLI has proper file system tool access

echo "Testing Ralph-Qwen Setup..."
echo "============================="

# Test 1: Check if Qwen is installed
echo "1. Checking Qwen installation..."
if ! command -v qwen &> /dev/null; then
    echo "❌ FAIL: Qwen CLI is not installed"
    echo "   Please install it first:"
    echo "   npm install -g @qwen-code/qwen-code@latest"
    exit 1
else
    echo "✅ PASS: Qwen CLI is installed"
    QWEN_VERSION=$(qwen --version 2>/dev/null || echo "unknown")
    echo "   Version: $QWEN_VERSION"
fi

# Test 2: Check if file system tools are available
echo ""
echo "2. Testing file system tool access..."

# Create a temporary test directory
TEST_DIR="/tmp/ralph-test-$$"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# Create a test prompt
cat > test_prompt.md << 'EOF'
Please create a file named "test_file.txt" with the content: "Ralph tools are working correctly."
Then verify the file was created and read its content.
EOF

# Test Qwen with proper flags
echo "   Running Qwen with file system tools enabled..."
if echo "Create a file named 'verification.txt' with content: 'Tools verified successfully.'" | timeout 30 qwen --approval-mode yolo --sandbox false >/dev/null 2>&1; then
    if [ -f "verification.txt" ]; then
        echo "✅ PASS: File system tools are working correctly"
        VERIFICATION_CONTENT=$(cat verification.txt)
        echo "   Content: $VERIFICATION_CONTENT"
    else
        echo "❌ FAIL: Qwen ran but file was not created"
    fi
else
    echo "❌ FAIL: Qwen execution failed"
fi

# Clean up
cd /
rm -rf "$TEST_DIR"

echo ""
echo "3. Testing loop script configuration..."

# Test loop scripts have proper flags
RALPH_REPO_DIR="$(dirname "$0")"
if [ -f "$RALPH_REPO_DIR/ralph-loop.sh" ]; then
    if grep -q "approval-mode yolo" "$RALPH_REPO_DIR/ralph-loop.sh" && grep -q "sandbox false" "$RALPH_REPO_DIR/ralph-loop.sh"; then
        echo "✅ PASS: Basic loop script is properly configured"
    else
        echo "❌ WARNING: Basic loop script may not have proper tool flags"
    fi
else
    echo "   Info: Basic loop script not found in current directory"
fi

if [ -f "$RALPH_REPO_DIR/ralph-loop-advanced.sh" ]; then
    if grep -q "approval-mode yolo" "$RALPH_REPO_DIR/ralph-loop-advanced.sh" && grep -q "sandbox false" "$RALPH_REPO_DIR/ralph-loop-advanced.sh"; then
        echo "✅ PASS: Advanced loop script is properly configured"
    else
        echo "❌ WARNING: Advanced loop script may not have proper tool flags"
    fi
else
    echo "   Info: Advanced loop script not found in current directory"
fi

echo ""
echo "Setup Verification Complete!"
echo "=============================="
echo "✅ Ralph-Qwen should now work with file system tools"
echo "💡 Remember to always use --approval-mode yolo --sandbox false flags"
echo "💡 Or ensure .qwen/config.json has proper tool configuration"