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

The "Ralph" technique is an approach to continuous automated programming where a coding agent runs in an infinite loop, continuously working on a codebase to implement features, port code, fix bugs, or maintain repositories. This repository provides everything you need to implement the Ralph technique using Qwen, Anthropic's powerful coding assistant.

## What is the Ralph Technique?

The Ralph technique, named after Ralph Wiggum from The Simpsons, involves running a coding agent in an infinite loop:

```bash
while :; do cat prompt.md | qwen; done
```

The technique was popularized by Geoff Huntley and used at a YC hackathon where teams ran Claude in loops to port codebases overnight, successfully porting several major projects including:
- Browser Use from Python to TypeScript
- Assistant-UI from React to Vue
- Creating new programming languages

## Why Qwen?

Qwen is an excellent choice for the Ralph technique because:
- Powerful code understanding and generation capabilities
- Context awareness for maintaining code consistency
- Good performance on refactoring and porting tasks
- Access to multiple models with different capabilities

For detailed information about the Qwen-specific implementation, see [docs/QWEN_IMPLEMENTATION.md](docs/QWEN_IMPLEMENTATION.md).

## Installation

For detailed installation instructions, see [docs/INSTALLATION.md](docs/INSTALLATION.md).

The easiest way to get started is to use the Makefile interface:

```bash
# Clone the repository
git clone https://github.com/mik-tf/ralph-qwen.git
cd ralph-qwen

# See available commands
make help

# Create your first project
make create-project
```

## Quick Start

1. **Enhanced Workflow** (Recommended):
   ```bash
   # Use the Makefile for easy automation
   make help
   make create-project
   # Follow the interactive prompts to create your project
   
   # Start the Ralph loop for your project
   make run-project PROJECT_NAME=my-awesome-project
   ```

2. **Traditional Approach**:
   ```bash
   # Create a project directory
   mkdir my-ralph-project
   cd my-ralph-project
   
   # Initialize your source and target repositories
   # For porting, create your source repository first
   # Then create the target directory
   mkdir target-repo
   ```

3. **Create your prompt file** (`prompt.md`):
   ```markdown
   Your job is to port my-react-project to my-vue-project (React to Vue) and maintain the repository.

   You have access to the current my-react-project repository as well as the my-vue-project repository.

   Make a commit and push your changes after every single file edit.

   Use the my-vue-project/.agent/ directory as a scratchpad for your work. Store long term plans and todo lists there.

   The original project was mostly tested by manually running the code. When porting, you will need to write end to end and unit tests for the project. But make sure to spend most of your time on the actual porting, not on the testing. A good heuristic is to spend 80% of your time on the actual porting, and 20% on the testing.
   ```

4. **Run the Ralph loop**:
   ```bash
   # Use the enhanced workflow (recommended)
   make create-project
   # Follow the interactive prompts
   
   # OR use the traditional approach:
   # From the ralph-qwen directory
   ./scripts/ralph-loop.sh
   ```

## Use Cases

The Ralph technique is particularly effective for:

### Codebase Porting
- Converting from one framework to another (React to Vue, Angular to Svelte)
- Migrating between programming languages (Python to TypeScript, Java to Rust)
- Updating major version dependencies

### Repository Maintenance
- Automatically applying security patches
- Keeping dependencies up-to-date
- Performing code style updates

### Feature Implementation
- Adding consistent features across large codebases
- Implementing API endpoints based on specifications
- Creating boilerplate for new components

### Bug Fixes
- Applying fixes to multiple similar code sections
- Refactoring patterns that cause known issues

For detailed prompt templates for these use cases, see [docs/PROMPT_TEMPLATES.md](docs/PROMPT_TEMPLATES.md).

## Advanced Usage

### Custom Configuration

You can customize the Ralph technique with different configuration files:

- `config.json`: Configuration for the Qwen agent
- `.qwenignore`: Files to ignore during processing
- `prompt-advanced.md`: More detailed prompts with specific instructions

### Monitoring and Control

For long-running processes, consider:

- Using `tmux` or `screen` to run processes in the background
- Setting up logging to track the agent's progress
- Implementing early stopping conditions based on success metrics

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