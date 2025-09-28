# Installation Guide for Qwen-Ralph

## Prerequisites

Before installing Qwen-Ralph, ensure you have:

- Node.js v18 or higher
- npm or yarn package manager
- Git for version control
- A Qwen API key (if using hosted version)

## Installing Qwen

1. Install the Qwen CLI globally:

```bash
npm install -g @qwen-code/qwen-code@latest
```

2. Verify the installation:

```bash
qwen --version
```

3. Log in to your Qwen account (if required):

```bash
qwen login
```

## Installing Qwen-Ralph

### Option 1: Clone and Use Scripts Directly

```bash
# Clone the repository
git clone https://github.com/mik-tf/ralph-qwen.git
cd ralph-qwen

# Use the enhanced workflow with Makefile
make help
make create-project

# OR use scripts directly:
chmod +x scripts/*.sh
./scripts/ralph-init.sh my-project
```

### Option 2: Install via npm (when published)

```bash
npm install -g @mik-tf/ralph-qwen
```

## Setting up Your Environment

### Environment Variables (Optional)

You can set environment variables to customize the Ralph loop behavior:

```bash
# Set custom prompt file
export PROMPT_FILE="custom-prompt.md"

# Set custom log file
export LOG_FILE="my-project.log"

# Set maximum iterations (0 for infinite)
export MAX_ITERATIONS=100

# Set delay between iterations (in seconds)
export SLEEP_DELAY=15

# Set custom commit message prefix
export COMMIT_PREFIX="AI-Agent: "
```

### Configuration Files

#### .qwen/config.json

Create a configuration file to specify model preferences:

```json
{
  "model": "qwen-max",
  "temperature": 0.2,
  "max_tokens": 4000,
  "context_window": 32000
}
```

#### .qwenignore

Use this file to specify files/directories the agent should not modify:

```
node_modules/
.git/
dist/
build/
*.log
.env
TODO_BACKUP/
```

## Initial Setup for a New Project

### Method 1: Enhanced Workflow (Recommended)

1. Use the Makefile interface:
   ```bash
   cd /path/to/ralph-qwen
   make create-project
   ```
   Follow the interactive prompts to create your project.

### Method 2: Traditional Script Approach

1. Create a project directory:
   ```bash
   mkdir my-ralph-project
   cd my-ralph-project
   git init
   ```

2. Copy the Ralph scripts to your project:
   ```bash
   cp /path/to/qwen-ralph/scripts/ralph-*.sh ./
   chmod +x ralph-*.sh
   ```

3. Initialize the project:
   ```bash
   ./ralph-init.sh .
   ```

4. Customize your `prompt.md` file with specific instructions

5. Start the Ralph loop:
   ```bash
   ./ralph-loop.sh
   ```

## Docker Setup (Optional)

For isolated execution, you can run Qwen-Ralph in Docker:

```dockerfile
FROM node:18-alpine

# Install git
RUN apk add --no-cache git

# Install Qwen CLI
RUN npm install -g @qwen-code/qwen-code@latest

# Copy Ralph scripts
COPY ralph-*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/ralph-*.sh

WORKDIR /app

CMD ["sh", "-c", "ralph-init.sh project && cd project && ralph-loop.sh"]
```

Build and run:
```bash
docker build -t qwen-ralph .
docker run -it --env QWEN_API_KEY=your_key_here qwen-ralph
```