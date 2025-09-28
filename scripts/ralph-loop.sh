#!/bin/bash
# Ralph Loop Script for Qwen
# This script runs Qwen in an infinite loop for continuous automated programming

set -e

# Configuration
PROMPT_FILE="prompt.md"
LOG_FILE="ralph-output.log"
ERROR_LOG="ralph-errors.log"
AGENT_DIR=".agent"

# Create agent directory if it doesn't exist
mkdir -p $AGENT_DIR

# Initialize TODO tracking
TODO_FILE="$AGENT_DIR/TODO.md"
if [ ! -f $TODO_FILE ]; then
    echo "# Ralph TODO List

## Status
- Running: Yes
- Last Action: Initialization

## TODO
- [ ] Initial setup complete
- [ ] Begin main task

" > $TODO_FILE
fi

echo "Starting Qwen Ralph Loop..."
echo "Prompt file: $PROMPT_FILE"
echo "Logging to: $LOG_FILE"
echo "Starting at: $(date)"
echo "------------------------"

# Main loop
cd "$(dirname "$0")" || exit 1
while true; do
    echo "$(date): Starting iteration" >> $LOG_FILE
    
    # Run Qwen with the current prompt - allow all tools (yolo mode) with proper configuration
    if cat $PROMPT_FILE | qwen --approval-mode yolo --sandbox false 2>>$ERROR_LOG >> $LOG_FILE; then
        # On success, commit changes
        git add .
        if git diff --cached --quiet; then
            echo "$(date): No changes to commit" >> $LOG_FILE
        else
            git commit -m "Ralph: Automated update at $(date)" >> $LOG_FILE 2>&1
            echo "$(date): Changes committed successfully" >> $LOG_FILE
        fi
    else
        # On error, log and continue
        echo "$(date): Qwen execution failed, continuing loop" >> $LOG_FILE
        echo "$(date): Error details logged to $ERROR_LOG" >> $LOG_FILE
    fi
    
    # Small delay to avoid overwhelming the API
    sleep 10
    
    # Update TODO status
    STATUS_MSG="Last run: $(date)"
    sed -i "s/Last Action:.*/Last Action: $STATUS_MSG/" $TODO_FILE
    
    # Check if we should stop (optional stop condition)
    # This could be based on a file, a condition in the TODO, etc.
    if [ -f "$AGENT_DIR/STOP" ]; then
        echo "$(date): Stop signal received, exiting loop" >> $LOG_FILE
        break
    fi
done

echo "Ralph loop stopped at: $(date)"