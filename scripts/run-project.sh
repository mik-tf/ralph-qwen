#!/bin/bash
# run-project.sh - Start Ralph loop for a project
# Part of the enhanced Ralph-Qwen workflow

set -e

PROJECT_NAME="$1"

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 <project-name>"
    echo "Example: $0 my-awesome-project"
    exit 1
fi

if [ ! -d "../$PROJECT_NAME" ]; then
    echo "❌ Error: Project '$PROJECT_NAME' not found"
    exit 1
fi

echo "🚀 Starting Ralph loop for project: $PROJECT_NAME"
echo "=============================================="

cd "../$PROJECT_NAME"

# Start the Ralph loop in background
nohup ./ralph-loop.sh > ralph-output.log 2> ralph-errors.log &
RALPH_PID=$!

echo "✅ Ralph loop started with PID: $RALPH_PID"
echo "📝 Logs are being written to ralph-output.log and ralph-errors.log"
echo "🛑 To stop the loop, run: make stop-project PROJECT_NAME=$PROJECT_NAME"