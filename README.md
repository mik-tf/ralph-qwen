# Qwen-Ralph: The Ralph Coding Technique with Qwen

## Table of Contents
- [Introduction](#introduction)
- [What is the Ralph Technique?](#what-is-the-ralph-technique)
- [Why Qwen?](#why-qwen)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Use Cases](#use-cases)
- [Advanced Usage](#advanced-usage)
- [Qwen-Specific Implementation](#qwen-specific-implementation)
- [Prompt Templates](#prompt-templates)
- [Scripts and Automation](#scripts-and-automation)
- [Examples](#examples)
- [Troubleshooting and Best Practices](#troubleshooting-and-best-practices)
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

For detailed information about the Qwen-specific implementation, see [QWEN_IMPLEMENTATION.md](QWEN_IMPLEMENTATION.md).

## Installation

For detailed installation instructions, see [INSTALLATION.md](INSTALLATION.md).

### Prerequisites
- Node.js (v18 or higher)
- npm or yarn
- Git for version control
- A Qwen API key (if using hosted version)

### Install Qwen CLI

```bash
# Install Qwen globally
npm install -g @qwen-code/qwen-code@latest

# Verify installation
qwen --version

# Log in to your account (if required)
qwen login
```

### Install Qwen-Ralph

#### Option 1: Use Scripts Directly
```bash
# Clone the repository
git clone https://github.com/threefold/qwen-ralph.git
cd qwen-ralph

# Make scripts executable
chmod +x ralph-*.sh

# Initialize a new project
./ralph-init.sh my-project
```

#### Option 2: Install via npm (when published)
```bash
npm install -g @threefold/qwen-ralph
```

## Quick Start

1. **Create a project directory**:
   ```bash
   mkdir my-ralph-project
   cd my-ralph-project
   ```

2. **Initialize your source and target repositories**:
   ```bash
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
   # Use the provided script (created later in this guide)
   ./ralph-loop.sh
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

For detailed prompt templates for these use cases, see [PROMPT_TEMPLATES.md](PROMPT_TEMPLATES.md).

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

For detailed information about how Qwen works with the Ralph technique, configuration, and best practices specific to Qwen, see [QWEN_IMPLEMENTATION.md](QWEN_IMPLEMENTATION.md).

## Prompt Templates

For a comprehensive collection of prompt templates for different use cases (React to Vue, Python to TypeScript, API implementation, etc.), see [PROMPT_TEMPLATES.md](PROMPT_TEMPLATES.md).

## Scripts and Automation

The repository includes several scripts to automate the Ralph technique:

- `ralph-loop.sh`: Basic infinite loop script
- `ralph-loop-advanced.sh`: Advanced loop with monitoring and control features
- `ralph-init.sh`: Project initialization script

For detailed documentation about these scripts and how to use them, see the scripts themselves or [INSTALLATION.md](INSTALLATION.md).

## Examples

Check out the [examples/](./examples/) directory for:
- React to Vue porting example
- Python to TypeScript conversion
- API specification to implementation
- Custom language creation

See [examples/README.md](examples/README.md) for more details on using the examples.

## Troubleshooting and Best Practices

For comprehensive troubleshooting guidance and best practices when using the Ralph technique, see [TROUBLESHOOTING_BEST_PRACTICES.md](TROUBLESHOOTING_BEST_PRACTICES.md).

## Troubleshooting

For detailed troubleshooting information and best practices, see [TROUBLESHOOTING_BEST_PRACTICES.md](TROUBLESHOOTING_BEST_PRACTICES.md).

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

Apache License 2.0, Copyright 2025 ThreeFold - see the LICENSE file for details.