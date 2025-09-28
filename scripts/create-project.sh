#!/bin/bash
# create-project.sh - Interactive project creation script
# Part of the enhanced Ralph-Qwen workflow

set -e

echo \"🚀 Ralph-Qwen Project Creator\"
echo \"==============================\"
echo \"\"

# Get project name
read -p \"Enter project name: \" PROJECT_NAME
if [ -z \"$PROJECT_NAME\" ]; then
    echo \"❌ Error: Project name is required\"
    exit 1
fi

# Check if project already exists
if [ -d \"../$PROJECT_NAME\" ]; then
    echo \"❌ Error: Project '$PROJECT_NAME' already exists\"
    exit 1
fi

echo \"\"
echo \"📋 Available project templates:\"
echo \"1) Generic Project\"
echo \"2) React to Vue Conversion\"
echo \"3) Python to TypeScript Conversion\"
echo \"4) API Implementation\"
echo \"5) Codebase Maintenance\"
echo \"\"

read -p \"Select template (1-5) [1]: \" TEMPLATE_CHOICE
TEMPLATE_CHOICE=${TEMPLATE_CHOICE:-1}

# Create project directory
echo \"🔧 Creating project directory...\"
mkdir -p \"../$PROJECT_NAME\"
cd \"../$PROJECT_NAME\"

# Initialize git repo
echo \"🔧 Initializing git repository...\"
git init
git checkout -b main

# Create standard project structure
echo \"🔧 Creating project structure...\"
mkdir -p src target .agent docs .qwen

# Create basic files based on template
case $TEMPLATE_CHOICE in
    1)
        # Generic project
        cat > prompt.md << 'EOF'
Your job is to work on this codebase and maintain the repository.

Current status: Starting the project

Make a commit and push your changes after every single file edit.

Use the .agent/ directory as a scratchpad for your work. Store long term plans and todo lists there.

Follow existing code patterns and conventions.
EOF
        ;;
    2)
        # React to Vue conversion
        cat > prompt.md << 'EOF'
Your job is to convert this React codebase to Vue 3 Composition API.

Current status: Starting React to Vue conversion

Make a commit and push your changes after every single file edit.

Convert each React component to a Vue SFC with Composition API.
Maintain the same functionality and UI.
Use the .agent/ directory as a scratchpad for your work.
EOF
        ;;
    3)
        # Python to TypeScript conversion
        cat > prompt.md << 'EOF'
Your job is to convert this Python codebase to TypeScript.

Current status: Starting Python to TypeScript conversion

Make a commit and push your changes after every single file edit.

Convert each Python module to a TypeScript module.
Maintain the same functionality and API.
Use the .agent/ directory as a scratchpad for your work.
EOF
        ;;
    4)
        # API Implementation
        cat > prompt.md << 'EOF'
Your job is to implement an API based on the specifications.

Current status: Starting API implementation

Make a commit and push your changes after every single file edit.

Implement the API endpoints according to the specifications.
Use the .agent/ directory as a scratchpad for your work.
EOF
        ;;
    5)
        # Codebase Maintenance
        cat > prompt.md << 'EOF'
Your job is to maintain and improve this codebase.

Current status: Starting codebase maintenance

Make a commit and push your changes after every single file edit.

Identify areas for improvement, fix bugs, and enhance functionality.
Use the .agent/ directory as a scratchpad for your work.
EOF
        ;;
esac

# Create .qwen config
cat > .qwen/config.json << 'EOF'
{
  \"model\": \"qwen-max\",
  \"temperature\": 0.2,
  \"max_tokens\": 4000,
  \"context_window\": 32000,
  \"tools\": {
    \"sandbox\": false,
    \"allowed\": [\"write_file\", \"edit\", \"read_file\", \"web_fetch\", \"todo_write\", \"task\", \"glob\", \"run_shell_command\"]
  },
  \"approvalMode\": \"yolo\"
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

# Create TODO tracking
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

# Create README
cat > README.md << EOF
# $PROJECT_NAME

This project was created with Ralph-Qwen.

## Setup

1. Update \`prompt.md\` with your specific instructions
2. Run the Ralph loop:

\`\`\`bash
# From the ralph-qwen directory
make run-project PROJECT_NAME=$PROJECT_NAME
\`\`\`

## Current Status

Update this section with progress.

## TODO

See \`.agent/TODO.md\` for the agent's tracking file.
EOF

echo \"🔧 Initializing git repository...\"
git add .
git commit -m \"Initial commit: Project '$PROJECT_NAME' created with Ralph-Qwen\"

echo \"\"
echo \"✅ Project '$PROJECT_NAME' created successfully!\"
echo \"\"
echo \"Next steps:\"
echo \"1. cd ../$PROJECT_NAME\"
echo \"2. Update prompt.md with your specific instructions\" 
echo \"3. Run: make run-project PROJECT_NAME=$PROJECT_NAME\"
echo \"\"