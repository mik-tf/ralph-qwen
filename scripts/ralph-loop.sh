#!/bin/bash
# Ralph Loop Script for Qwen
# This script runs Qwen in an infinite loop for continuous automated programming

set -e

# Accept project directory as argument (optional)
PROJECT_DIR="${1:-$(pwd)}"

# Change to project directory first
cd "$PROJECT_DIR" || {
    echo "❌ Error: Cannot access project directory: $PROJECT_DIR"
    exit 1
}

echo "Starting Qwen Ralph Loop..."
echo "Working directory: $(pwd)"
echo "Starting at: $(date)"
echo "------------------------"

# Configuration (all paths relative to project directory)
PROMPT_FILE="prompt.md"
LOG_FILE="ralph-output.log"
ERROR_LOG="ralph-errors.log"
AGENT_DIR=".agent"

# Create agent directory if it doesn't exist
mkdir -p "$AGENT_DIR"

# Initialize TODO tracking
TODO_FILE="$AGENT_DIR/TODO.md"
if [ ! -f "$TODO_FILE" ]; then
    echo "# Ralph TODO List

## Status
- Running: Yes
- Last Action: Initialization

## TODO
- [ ] Initial setup complete
- [ ] Begin main task

" > "$TODO_FILE"
fi

echo "Prompt file: $PROMPT_FILE"
echo "Logging to: $LOG_FILE"
echo "------------------------"

# Main loop

while true; do
    echo "$(date): Starting iteration" >> "$LOG_FILE"
    
    # Run Qwen with the current prompt - allow all tools (yolo mode) with proper configuration
    if cat "$PROMPT_FILE" | qwen --approval-mode yolo --sandbox false 2>>"$ERROR_LOG" >> "$LOG_FILE"; then
        # On success, commit changes
        git add .
        if git diff --cached --quiet; then
            echo "$(date): No changes to commit" >> "$LOG_FILE"
        else
            git commit -m "Ralph: Automated update at $(date)" >> "$LOG_FILE" 2>&1
            echo "$(date): Changes committed successfully" >> "$LOG_FILE"
        fi
    else
        # On error, log and continue
        echo "$(date): Qwen execution failed, continuing loop" >> "$LOG_FILE"
        echo "$(date): Error details logged to $ERROR_LOG" >> "$LOG_FILE"
    fi
    
    # Small delay to avoid overwhelming the API
    sleep 10
    
    # Update TODO status
    STATUS_MSG="Last run: $(date)"
    sed -i "s/Last Action:.*/Last Action: $STATUS_MSG/" "$TODO_FILE"
    
    # Check if we should stop (optional stop condition)
    # This could be based on a file, a condition in the TODO, etc.
    if [ -f "$AGENT_DIR/STOP" ]; then
        echo "$(date): Stop signal received, exiting loop" >> "$LOG_FILE"
        break
    fi
done

echo "Ralph loop stopped at: $(date)"