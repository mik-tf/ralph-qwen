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

# Get project name interactively
echo "🚀 Ralph-Qwen Project Creator"
echo "=============================="
echo ""
read -p "Enter project name: " PROJECT_NAME
echo ""

if [ -z "$PROJECT_NAME" ]; then
    echo "❌ Error: Project name is required"
    exit 1
fi

# Check if project already exists in workspace
if [ -d "../$PROJECT_NAME" ]; then
    echo "❌ Error: Project '$PROJECT_NAME' already exists in workspace"
    exit 1
fi

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

# Ask for project type
echo "📋 What type of project are you working on?"
echo "1) Codebase Porting (e.g., React to Vue)"
echo "2) Translation Services"
echo "3) Editing & Proofreading"
echo "4) Copywriting"
echo "5) Website Creation"
echo "6) Other"
echo ""
read -p "Select project type (1-6) [1]: " PROJECT_TYPE
PROJECT_TYPE=${PROJECT_TYPE:-1}

# Create appropriate prompt based on project type
case $PROJECT_TYPE in
    1)
        # Codebase Porting
        cat > prompt.md << 'EOF'
Your job is to port my-[SOURCE]-project to my-[TARGET]-project ([SOURCE] to [TARGET]) and maintain the repository.

You have access to the current my-[SOURCE]-project repository as well as the my-[TARGET]-project repository.

Make a commit and push your changes after every single file edit.

Use the my-[TARGET]-project/.agent/ directory as a scratchpad for your work. Store long term plans and todo lists there.

Follow existing code patterns and conventions.

CURRENT STATUS: Starting the project

Please ask me for more details about the specific project requirements, source code location, and target requirements.
EOF
        ;;
    2)
        # Translation Services
        cat > prompt.md << 'EOF'
Your job is to provide professional translation services for documents, websites, and multimedia content.

You have access to the source documents and need to translate them accurately while maintaining cultural appropriateness.

Make a commit and push your changes after every single file edit.

Use the .agent/ directory as a scratchpad for your work. Store long term plans and todo lists there.

Follow existing translation patterns and conventions.

CURRENT STATUS: Starting translation project

Please ask me for more details about the specific documents, languages, and requirements.
EOF
        ;;
    3)
        # Editing & Proofreading
        cat > prompt.md << 'EOF'
Your job is to provide expert proofreading and editing services to ensure content is polished, accurate, and meets the highest quality standards.

You have access to the source documents and need to review them for grammar, style, consistency, and clarity.

Make a commit and push your changes after every single file edit.

Use the .agent/ directory as a scratchpad for your work. Store long term plans and todo lists there.

Follow existing editing patterns and conventions.

CURRENT STATUS: Starting editing project

Please ask me for more details about the specific documents and requirements.
EOF
        ;;
    4)
        # Copywriting
        cat > prompt.md << 'EOF'
Your job is to create creative and compelling copy that engages your audience and drives action across all marketing channels.

You have access to the project requirements and need to craft copy that resonates with local audiences while maintaining your brand's voice and identity.

Make a commit and push your changes after every single file edit.

Use the .agent/ directory as a scratchpad for your work. Store long term plans and todo lists there.

Follow existing copywriting patterns and conventions.

CURRENT STATUS: Starting copywriting project

Please ask me for more details about the specific requirements and target audience.
EOF
        ;;
    5)
        # Website Creation
        cat > prompt.md << 'EOF'
Your job is to create custom websites designed to showcase your brand and optimized for user experience and search engines.

You have access to the project requirements and need to build responsive, accessible, and conversion-focused websites.

Make a commit and push your changes after every single file edit.

Use the .agent/ directory as a scratchpad for your work. Store long term plans and todo lists there.

Follow existing web development patterns and conventions.

CURRENT STATUS: Starting website creation project

Please ask me for more details about the specific requirements and design preferences.
EOF
        ;;
    *)
        # Other
        cat > prompt.md << 'EOF'
Your job is to work on this codebase and maintain the repository.

Make a commit and push your changes after every single file edit.

Use the .agent/ directory as a scratchpad for your work. Store long term plans and todo lists there.

Follow existing code patterns and conventions.

CURRENT STATUS: Starting the project

Please ask me for more details about the specific project requirements.
EOF
        ;;
esac

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

# Create initial TODO file
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

# Initialize git repository
echo "🔧 Initializing git repository..."
git add .
git commit -m "Initial commit: Project '$PROJECT_NAME' created with Ralph-Qwen"

echo ""
echo "✅ Project '$PROJECT_NAME' created successfully!"
echo ""
echo "Next steps:"
echo "1. cd ../$PROJECT_NAME"
echo "2. Update prompt.md with your specific instructions" 
echo "3. Run: make run-project PROJECT_NAME=$PROJECT_NAME"
echo ""