#!/bin/bash
# Ralph Project Initializer
# Sets up a new project for using the Ralph technique with Qwen

set -e

# Check if qwen is installed
if ! command -v qwen &> /dev/null; then
    echo "Qwen CLI is not installed. Please install it first:"
    echo "  npm install -g @qwen-code/qwen-code@latest"
    exit 1
fi

# Get project name from argument or prompt
echo "🚀 Ralph-Qwen Project Creator"
echo "=============================="
echo ""

PROJECT_NAME="$1"
if [ -z "$PROJECT_NAME" ]; then
    read -p "Enter project name: " PROJECT_NAME
    echo ""
fi

if [ -z "$PROJECT_NAME" ]; then
    echo "❌ Error: Project name is required"
    exit 1
fi

# Check if project already exists in workspace
if [ -d "../$PROJECT_NAME" ]; then
    echo "❌ Error: Project '$PROJECT_NAME' already exists in workspace"
    exit 1
fi

# Get time duration with validation
TIME_TEXT=""
while [ -z "$TIME_TEXT" ]; do
    echo "⏱️  How long should Ralph Qwen run?"
    echo "Examples: 30m, 1h, 2h30m, indefinite"
    echo ""
    read -p "Enter duration: " TIME_DURATION
    echo ""
    
    # Parse time duration
    if [[ "$TIME_DURATION" =~ ^[Ii]nf ]]; then
        TIME_TEXT="indefinite"
    elif [[ "$TIME_DURATION" =~ ^([0-9]+)h([0-9]+)m$ ]]; then
        HOURS="${BASH_REMATCH[1]}"
        MINUTES="${BASH_REMATCH[2]}"
        TIME_TEXT="in $HOURS hour(s) and $MINUTES minute(s) of time"
    elif [[ "$TIME_DURATION" =~ ^([0-9]+)h(our)?s?$ ]]; then
        HOURS="${BASH_REMATCH[1]}"
        TIME_TEXT="in $HOURS hour(s) of time"
    elif [[ "$TIME_DURATION" =~ ^([0-9]+)m(in)?(ute)?s?$ ]]; then
        MINUTES="${BASH_REMATCH[1]}"
        TIME_TEXT="in $MINUTES minute(s) of time"
    else
        echo "❌ Error: Invalid duration format '$TIME_DURATION'"
        echo "   Valid formats: 30m, 1h, 2h30m, indefinite"
        echo ""
        # Loop will continue
    fi
done

# Create project directory in parent directory
echo "🔧 Creating project directory..."
mkdir -p "../$PROJECT_NAME"
cd "../$PROJECT_NAME"

# Initialize git repo
echo "🔧 Initializing git repository..."
git init
git checkout -b main

# Create basic directory structure
echo "🔧 Creating project structure..."
mkdir -p src target .agent docs .qwen

# Ask for prompt type
echo "📝 Choose prompt type:"
echo "1) Custom prompt (paste your own)"
echo "2) Generic template (select from options)"
echo ""
read -p "Select (1-2) [2]: " PROMPT_TYPE
PROMPT_TYPE=${PROMPT_TYPE:-2}
echo ""

# Default prefix for all prompts
DEFAULT_PREFIX="Your job is to work on this codebase and maintain the repository.

Make a commit and push your changes after every single file edit.

Use the .agent/ directory as a scratchpad for your work. Store long term plans and todo lists there.

Follow existing code patterns and conventions.

CURRENT STATUS: Starting the project

The specific project requirements:"

# Handle custom prompt
if [ "$PROMPT_TYPE" = "1" ]; then
    echo "📋 Enter your custom prompt (press Ctrl+D when done):"
    echo ""
    CUSTOM_PROMPT=$(cat)
    
    # Build final prompt
    cat > prompt.md << EOF
$DEFAULT_PREFIX
EOF
    
    # Add time constraint if not indefinite
    if [ "$TIME_TEXT" != "indefinite" ]; then
        cat >> prompt.md << EOF

Check the time log as you start your work and $TIME_TEXT, you must finish and give what you have at this moment.
EOF
    fi
    
    # Add custom prompt
    cat >> prompt.md << EOF

$CUSTOM_PROMPT
EOF
    
    echo ""
    echo "✅ Custom prompt configured"
else
    # Ask for project type
    echo "📋 Select generic project template:"
    echo "1) Codebase Porting (e.g., React to Vue)"
    echo "2) Translation Services"
    echo "3) Editing & Proofreading"
    echo "4) Copywriting"
    echo "5) Website Creation"
    echo "6) Other/General Purpose"
    echo ""
    read -p "Select (1-6) [1]: " PROJECT_TYPE
    PROJECT_TYPE=${PROJECT_TYPE:-1}
    echo ""
    
    # Start with default prefix
    cat > prompt.md << EOF
$DEFAULT_PREFIX
EOF
    
    # Add time constraint if not indefinite
    if [ "$TIME_TEXT" != "indefinite" ]; then
        cat >> prompt.md << EOF

Check the time log as you start your work and $TIME_TEXT, you must finish and give what you have at this moment.
EOF
    fi
    
    # Add specific template content based on project type
    case $PROJECT_TYPE in
        1)
            # Codebase Porting
            cat >> prompt.md << 'EOF'

Port my-[SOURCE]-project to my-[TARGET]-project ([SOURCE] to [TARGET]).

You have access to the current my-[SOURCE]-project repository as well as the my-[TARGET]-project repository.

Use the my-[TARGET]-project/.agent/ directory as a scratchpad for your work. Store long term plans and todo lists there.

Please ask me for more details about the specific project requirements, source code location, and target requirements.
EOF
            ;;
        2)
            # Translation Services
            cat >> prompt.md << 'EOF'

Provide professional translation services for documents, websites, and multimedia content.

You have access to the source documents and need to translate them accurately while maintaining cultural appropriateness.

Please ask me for more details about the specific documents, languages, and requirements.
EOF
            ;;
        3)
            # Editing & Proofreading
            cat >> prompt.md << 'EOF'

Provide expert proofreading and editing services to ensure content is polished, accurate, and meets the highest quality standards.

You have access to the source documents and need to review them for grammar, style, consistency, and clarity.

Please ask me for more details about the specific documents and requirements.
EOF
            ;;
        4)
            # Copywriting
            cat >> prompt.md << 'EOF'

Create creative and compelling copy that engages your audience and drives action across all marketing channels.

You have access to the project requirements and need to craft copy that resonates with local audiences while maintaining your brand's voice and identity.

Please ask me for more details about the specific requirements and target audience.
EOF
            ;;
        5)
            # Website Creation
            cat >> prompt.md << 'EOF'

Create custom websites designed to showcase your brand and optimized for user experience and search engines.

You have access to the project requirements and need to build responsive, accessible, and conversion-focused websites.

Please ask me for more details about the specific requirements and design preferences.
EOF
            ;;
        *)
            # Other
            cat >> prompt.md << 'EOF'

Please ask me for more details about the specific project requirements.
EOF
            ;;
    esac
    
    echo "✅ Generic template configured"
fi

# Create default Qwen configuration
mkdir -p .qwen
cat > .qwen/config.json << 'EOF'
{
  "model": "qwen-max",
  "temperature": 0.2,
  "max_tokens": 4000,
  "context_window": 32000,
  "tools": {
    "sandbox": false,
    "allowed": ["write_file", "edit", "read_file", "web_fetch", "todo_write", "task", "glob", "run_shell_command"]
  },
  "approvalMode": "yolo"
}
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
node_modules/
.git/
dist/
build/
*.log
.env
.env.local
TODO_BACKUP/
.agent/TODO_BACKUP.md
.tmp/
.cache/
EOF

# Create initial TODO file and time log
mkdir -p .agent
cat > .agent/TODO.md << 'EOF'
# Ralph TODO List

## Status
- Running: No
- Last Action: Project initialization
- Iteration: 0

## TODO
- [ ] Define specific task for the Ralph agent
- [ ] Update prompt.md with detailed instructions
- [ ] Begin main task

## Progress Log
- $(date): Project initialized
EOF

# Create time log file with current timestamp
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
cat > .agent/time_log.txt << EOF
Project Start Time: $CURRENT_TIME
Time Constraint: $TIME_TEXT
EOF

# Create README
cat > README.md << EOF
# $PROJECT_NAME

This project was created with Ralph-Qwen.

## Configuration

- **Time Constraint**: $TIME_TEXT
- **Prompt Type**: $([ "$PROMPT_TYPE" = "1" ] && echo "Custom" || echo "Generic Template")

## Setup

The project is ready to run! The prompt has been configured in \`prompt.md\`.

To start the Ralph loop:

\`\`\`bash
# From the ralph-qwen directory
make run-project PROJECT_NAME=$PROJECT_NAME
\`\`\`

## Current Status

Project initialized and ready to begin.

## TODO

See \`.agent/TODO.md\` for the agent's tracking file.
EOF

# Initialize git repository
echo "🔧 Initializing git repository..."
git add .
git commit -m "Initial commit: Project '$PROJECT_NAME' created with Ralph-Qwen"

echo ""
echo "✅ Project '$PROJECT_NAME' created successfully!"
echo ""
echo "Configuration:"
echo "  - Time constraint: $TIME_TEXT"
echo "  - Prompt: $([ "$PROMPT_TYPE" = "1" ] && echo "Custom" || echo "Generic template")"
echo ""

# Ask if user wants to start Ralph Qwen now
echo "🚀 Do you want to start Ralph Qwen now for the project '$PROJECT_NAME'?"
read -p "Start now? (y/N): " START_NOW
echo ""

if [[ "$START_NOW" =~ ^[Yy]$ ]]; then
    echo "Starting Ralph Qwen for project '$PROJECT_NAME'..."
    echo ""
    # Get the ralph-qwen directory (parent of this script's directory)
    RALPH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    cd "$RALPH_DIR"
    make run-project PROJECT_NAME="$PROJECT_NAME"
else
    echo "Next steps:"
    echo "1. cd ../$PROJECT_NAME"
    echo "2. Review prompt.md (already configured)" 
    echo "3. Run from ralph-qwen directory: make run-project PROJECT_NAME=$PROJECT_NAME"
    echo ""
fi