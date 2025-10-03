# Qwen-Ralph: The Ralph Coding Technique with Qwen

## Table of Contents
- [Qwen-Ralph: The Ralph Coding Technique with Qwen](#qwen-ralph-the-ralph-coding-technique-with-qwen)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [What is the Ralph Technique?](#what-is-the-ralph-technique)
  - [Why Qwen?](#why-qwen)
  - [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Install Qwen CLI](#install-qwen-cli)
    - [Install Qwen-Ralph](#install-qwen-ralph)
  - [Quick Start](#quick-start)
  - [Use Cases](#use-cases)
    - [Codebase Porting](#codebase-porting)
    - [Repository Maintenance](#repository-maintenance)
    - [Feature Implementation](#feature-implementation)
    - [Bug Fixes](#bug-fixes)
  - [Advanced Usage](#advanced-usage)
    - [Custom Configuration](#custom-configuration)
    - [Monitoring and Control](#monitoring-and-control)
  - [Qwen-Specific Implementation](#qwen-specific-implementation)
  - [Prompt Templates](#prompt-templates)
  - [Repository Structure](#repository-structure)
  - [Examples](#examples)
  - [Troubleshooting and Best Practices](#troubleshooting-and-best-practices)
  - [Troubleshooting](#troubleshooting)
    - [Common Issues](#common-issues)
    - [Monitoring Progress](#monitoring-progress)
  - [Contributing](#contributing)
  - [License](#license)

## Introduction

The "Ralph" technique is an approach to **continuous automated programming** where a coding agent runs in an infinite loop, continuously working on codebases to implement features, port code, fix bugs, or maintain repositories. This repository provides everything you need to implement the Ralph technique using Qwen, Anthropic's powerful coding assistant.

**Ralph-Qwen is a universal project automation framework** that can be applied to virtually any type of project - from codebase porting and software development to content creation, data processing, research projects, and creative endeavors.

## What is the Ralph Technique?

The Ralph technique, named after Ralph Wiggum from The Simpsons, involves running a coding agent in an infinite loop:

```bash
while :; do cat prompt.md | qwen; done
```

The technique was popularized by Geoff Huntley and used at a YC hackathon where teams ran Claude in loops to port codebases overnight, successfully porting several major projects including:
- Browser Use from Python to TypeScript
- Assistant-UI from React to Vue
- Creating new programming languages

## Universal Project Automation Framework

**Ralph-Qwen is a universal project automation framework** that can be applied to virtually any type of project, not just linguistic services. The framework provides continuous automation capabilities for:

### 🎯 Broad Application Areas
1. **Codebase Porting & Migration**
   - React → Vue conversion
   - Python → TypeScript migration
   - Angular → Svelte transformation
   - Legacy system modernization

2. **Software Development**
   - API implementation from specifications
   - Feature development across large codebases
   - Bug fixing and refactoring
   - Test suite creation and maintenance

3. **Content Creation & Management**
   - Blog series generation
   - Documentation writing
   - Marketing copy creation
   - Social media content automation

4. **Data Processing & Analysis**
   - Data transformation pipelines
   - Report generation from raw data
   - Pattern recognition in datasets
   - Automated data cleaning workflows

5. **Research & Experimentation**
   - Scientific computing projects
   - Algorithm implementation and testing
   - Simulation development
   - Research paper drafting

6. **Creative Projects**
   - Game development
   - Interactive story creation
   - Art generation scripts
   - Music composition tools

### 🚀 Universal Workflow Features
The framework provides universal automation capabilities:

```bash
# Create ANY type of project (with optional PROJECT_NAME parameter)
make create-project
make create-project PROJECT_NAME=my-project
# → Interactive setup with time constraints, custom/generic prompts
# → Optional auto-start feature

# Run continuous automation
make run-project PROJECT_NAME=my-awesome-project
# → Infinite loop automation for any task
# → Respects time constraints set during creation

# Monitor progress
make monitor-project PROJECT_NAME=my-awesome-project
# → Real-time progress tracking
# → Check time logs and TODO updates

# Stop when done
make stop-project PROJECT_NAME=my-awesome-project
# → Graceful termination
```

## Installation

For detailed installation instructions, see [docs/INSTALLATION.md](docs/INSTALLATION.md).

The easiest way to get started is to use the Makefile interface:

```bash
# Clone the repository
git clone https://github.com/mik-tf/ralph-qwen.git
cd ralph-qwen

# See available commands
make help

# Create your first project (fully interactive)
make create-project

# Or skip the project name prompt
make create-project PROJECT_NAME=my-first-project
```

## Quick Start

### 🚀 One-Command Project Setup (Recommended)

```bash
# Full interactive mode
make create-project

# Skip project name prompt
make create-project PROJECT_NAME=my-awesome-project
```

**The enhanced workflow will guide you through:**

1. **📛 Project Name** (skipped if `PROJECT_NAME=` provided)
   - Enter a unique project name
   - Validates that project doesn't already exist

2. **⏱️ Time Duration** (with validation)
   - `30m` → 30 minutes
   - `1h` → 1 hour
   - `2h30m` → 2 hours 30 minutes
   - `indefinite` → No time limit
   - Invalid formats will prompt again with error message

3. **📝 Prompt Type**
   - **Custom**: Paste your own multi-line prompt (Ctrl+D to finish)
   - **Generic**: Choose from 6 pre-built templates

4. **🎯 Template Selection** (if Generic chosen)
   1. Codebase Porting (e.g., React to Vue)
   2. Translation Services
   3. Editing & Proofreading
   4. Copywriting
   5. Website Creation
   6. Other/General Purpose

5. **🚀 Auto-Start Option**
   - Optionally start Ralph Qwen immediately after setup
   - Type `y` to start now, `N` to start later

### 📋 Default Prompt Structure

All projects include a consistent default prefix:

```markdown
Your job is to work on this codebase and maintain the repository.

Make a commit and push your changes after every single file edit.

Use the .agent/ directory as a scratchpad for your work.

Follow existing code patterns and conventions.

CURRENT STATUS: Starting the project

The specific project requirements:

[Time constraint if not indefinite]

[Your custom prompt or selected template]
```

### ▶️ Starting Ralph Qwen

```bash
# If you chose to start later, run:
make run-project PROJECT_NAME=my-awesome-project

# Monitor progress:
make monitor-project PROJECT_NAME=my-awesome-project

# Stop when done:
make stop-project PROJECT_NAME=my-awesome-project
```

### 📊 Example Session

```bash
$ make create-project

🚀 Ralph-Qwen Project Creator
==============================

Enter project name: my-website

⏱️  How long should Ralph Qwen run?
Examples: 30m, 1h, 2h30m, indefinite

Enter duration: 30m

📝 Choose prompt type:
1) Custom prompt (paste your own)
2) Generic template (select from options)

Select (1-2) [2]: 1

📋 Enter your custom prompt (press Ctrl+D when done):
Create a beautiful landing page for a math education website
^D

✅ Custom prompt configured
✅ Project 'my-website' created successfully!

Configuration:
  - Time constraint: in 30 minute(s) of time
  - Prompt: Custom

🚀 Do you want to start Ralph Qwen now for the project 'my-website'?
Start now? (y/N): y

Starting Ralph Qwen for project 'my-website'...
✅ Ralph loop started with PID: 12345
```

## Use Cases

The Ralph technique is particularly effective for a wide variety of projects:

### Codebase Porting
- Converting from one framework to another (React to Vue, Angular to Svelte)
- Migrating between programming languages (Python to TypeScript, Java to Rust)
- Updating major version dependencies
- Legacy system modernization

### Repository Maintenance
- Automatically applying security patches
- Keeping dependencies up-to-date
- Performing code style updates
- Refactoring large codebases for consistency

### Feature Implementation
- Adding consistent features across large codebases
- Implementing API endpoints based on specifications
- Creating boilerplate for new components
- Extending existing functionality

### Bug Fixes
- Applying fixes to multiple similar code sections
- Refactoring patterns that cause known issues
- Identifying and resolving performance bottlenecks
- Addressing security vulnerabilities

### Content Creation
- Generating blog posts and articles
- Creating documentation and tutorials
- Producing marketing materials and copy
- Developing educational content and courses

### Data Processing
- Transforming data between formats
- Cleaning and validating datasets
- Generating reports and analytics
- Automating data pipeline tasks

### Research & Development
- Implementing algorithms from research papers
- Conducting experiments and simulations
- Analyzing data and generating insights
- Prototyping new ideas and concepts

### Creative Projects
- Developing games and interactive experiences
- Creating art and design assets
- Writing stories and narratives
- Composing music and audio content

For detailed prompt templates for these use cases, see [docs/PROMPT_TEMPLATES.md](docs/PROMPT_TEMPLATES.md).

For detailed prompt templates for these use cases, see [docs/PROMPT_TEMPLATES.md](docs/PROMPT_TEMPLATES.md).

## Advanced Usage

### Custom Configuration

You can customize the Ralph technique for any type of project with different configuration files:

- `config.json`: Configuration for the Qwen agent
- `.qwenignore`: Files to ignore during processing
- `prompt-advanced.md`: More detailed prompts with specific instructions

### Monitoring and Control

For long-running processes on any project type, consider:

- Using `tmux` or `screen` to run processes in the background
- Setting up logging to track the agent's progress
- Implementing early stopping conditions based on success metrics
- Using `make monitor-project` to track progress

### Universal Project Types

The Ralph technique can be adapted for various project categories:

#### 1. Codebase Transformation Projects
- Framework migrations (React → Vue, Angular → Svelte)
- Language conversions (Python → TypeScript, Java → Rust)
- Architecture refactoring (Monolith → Microservices)

#### 2. Content Generation Projects
- Blog series creation and publication
- Documentation writing and maintenance
- Marketing campaign development
- Educational material generation

#### 3. Data Processing Projects
- ETL pipeline development
- Data analysis and reporting
- Format conversion workflows
- Automated data cleaning

#### 4. Research & Development Projects
- Algorithm implementation from papers
- Experimental software development
- Scientific computing projects
- Prototype creation

#### 5. Creative Projects
- Game development and implementation
- Interactive storytelling
- Art and design generation
- Music composition tools

For detailed information about these project types and their specific implementations, see [docs/ADVANCED_USAGE.md](docs/ADVANCED_USAGE.md).

## Qwen-Specific Implementation

For detailed information about how Qwen works with the Ralph technique, configuration, and best practices specific to Qwen, see [docs/QWEN_IMPLEMENTATION.md](docs/QWEN_IMPLEMENTATION.md).

## Prompt Templates

For a comprehensive collection of prompt templates for different use cases (React to Vue, Python to TypeScript, API implementation, etc.), see [docs/PROMPT_TEMPLATES.md](docs/PROMPT_TEMPLATES.md).

## Repository Structure

The repository follows industry-standard organization:

```
ralph-qwen/
├── Makefile              # Build and automation targets
├── scripts/              # Automation scripts
│   ├── create-project.sh # Interactive project creator
│   ├── run-project.sh    # Start Ralph loop
│   ├── stop-project.sh   # Stop Ralph loop
│   ├── monitor-project.sh # Monitor progress
│   ├── ralph-init.sh     # Legacy project initializer
│   ├── ralph-loop.sh     # Basic Ralph loop
│   ├── ralph-loop-advanced.sh # Advanced Ralph loop
│   └── test-setup.sh     # Tool configuration test
├── docs/                 # Documentation files
│   ├── INSTALLATION.md
│   ├── PROMPT_TEMPLATES.md
│   └── ...
├── examples/             # Example projects
├── templates/            # Project templates
├── templates/            # Project templates
└── .gitignore            # Git ignore rules

## File System Tool Configuration

**Important**: To ensure the Ralph technique works correctly with file system operations, the Qwen CLI must be configured properly. See [docs/RALPH_SETUP.md](docs/RALPH_SETUP.md) for detailed instructions on setting up tool access.

### Quick Configuration

When running Qwen through the Ralph scripts, always use these flags:

```bash
qwen --approval-mode yolo --sandbox false
```

This enables the necessary file system tools:
- `write_file`: Create/write files
- `edit`: Modify existing files
- `read_file`: Read file contents
- And other essential tools for the Ralph technique

## Examples

Check out the [examples/](./examples/) directory for:
- React to Vue porting example
- Python to TypeScript conversion
- API specification to implementation
- Custom language creation

See [examples/README.md](examples/README.md) for more details on using the examples.

## Troubleshooting and Best Practices

For comprehensive troubleshooting guidance and best practices when using the Ralph technique, see [docs/TROUBLESHOOTING_BEST_PRACTICES.md](docs/TROUBLESHOOTING_BEST_PRACTICES.md).

## Troubleshooting

For detailed troubleshooting information and best practices, see [docs/TROUBLESHOOTING_BEST_PRACTICES.md](docs/TROUBLESHOOTING_BEST_PRACTICES.md).

### Common Issues

**Agent Stuck in Loops**: If the agent repeatedly tries the same failed approach, update the prompt to guide it away from that path.

**Performance Issues**: Monitor system resources during long runs. Consider running on a machine with sufficient memory and processing power.

**Rate Limits**: Be aware of API limits for your Qwen instance and implement delays if needed.

**Qwen Not Found**: Make sure Qwen CLI is properly installed and in your PATH.

### Monitoring Progress

To see what the agent is doing:

```bash
tail -f qwen-output.log
git log --oneline -10
```

## Contributing

We welcome contributions to the Qwen-Ralph project! Feel free to submit issues, feature requests, or pull requests.

## License

Apache License 2.0, Copyright 2025 ThreeFold - see the [license](LICENSE) for details.