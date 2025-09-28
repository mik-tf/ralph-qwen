#!/bin/bash
# stop-project.sh - Stop running Ralph loop
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

echo "🛑 Stopping Ralph loop for project: $PROJECT_NAME"

cd "../$PROJECT_NAME"

# Look for running Ralph processes
RALPH_PIDS=$(pgrep -f "ralph-loop.sh" 2>/dev/null || true)

if [ -n "$RALPH_PIDS" ]; then
    echo " Killing Ralph processes: $RALPH_PIDS"
    kill $RALPH_PIDS
    echo "✅ Ralph loop stopped"
else
    echo "ℹ️  No running Ralph processes found"
fi