# Makefile for Ralph-Qwen Enhanced Workflow
# Standardized build and automation targets

# Variables
PROJECT_DIR := $(CURDIR)
SCRIPTS_DIR := $(PROJECT_DIR)/scripts
DOCS_DIR := $(PROJECT_DIR)/docs
TEMPLATES_DIR := $(PROJECT_DIR)/templates

# Default target
.PHONY: help
help:
	@echo "Ralph-Qwen Enhanced Workflow"
	@echo "============================="
	@echo "Available targets:"
	@echo "  create-project     - Create a new Ralph project with interactive setup"
	@echo "  list-projects      - List all Ralph projects in workspace"
	@echo "  run-project        - Start Ralph loop for a project"
	@echo "  monitor-project    - Monitor project progress"
	@echo "  stop-project       - Stop running Ralph loop"
	@echo "  test-setup         - Test Ralph-Qwen tool configuration"
	@echo "  clean              - Clean temporary files"
	@echo "  docs               - Generate documentation"
	@echo "  help               - Show this help message"

# Create a new project with interactive Qwen setup
.PHONY: create-project
create-project:
	@echo "Creating new Ralph project..."
	$(SCRIPTS_DIR)/create-project.sh

# List all projects in the workspace
.PHONY: list-projects
list-projects:
	@echo "Ralph projects in workspace:"
	@find .. -maxdepth 2 -name ".ralph" -type d | while read project; do \
		project_name=$$(dirname "$$project"); \
		echo "  - $$(basename "$$project_name")"; \
	done || echo "  No projects found"

# Run Ralph loop for a specific project
.PHONY: run-project
run-project:
	@echo "Starting Ralph loop..."
	@$(BIN_DIR)/run-project.sh

# Monitor project progress
.PHONY: monitor-project
monitor-project:
	@echo "Monitoring project progress..."
	@$(BIN_DIR)/monitor-project.sh

# Stop running Ralph loop
.PHONY: stop-project
stop-project:
	@echo "Stopping Ralph loop..."
	@$(BIN_DIR)/stop-project.sh

# Test setup
.PHONY: test-setup
test-setup:
	@echo "Testing Ralph-Qwen setup..."
	@$(SCRIPTS_DIR)/test-setup.sh

# Clean temporary files
.PHONY: clean
clean:
	@echo "Cleaning temporary files..."
	@find . -name "*.tmp" -delete
	@find . -name "*.log" -delete
	@echo "Temporary files cleaned."

# Generate documentation
.PHONY: docs
docs:
	@echo "Generating documentation..."
	@$(BIN_DIR)/generate-docs.sh

# Install dependencies (if needed)
.PHONY: install
install:
	@echo "Installing dependencies..."
	@npm install

# Update Ralph-Qwen
.PHONY: update
update:
	@echo "Updating Ralph-Qwen..."
	@git pull origin main