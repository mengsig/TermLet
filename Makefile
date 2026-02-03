.PHONY: test test-file lint format format-check check clean help

# Default target
help:
	@echo "Available targets:"
	@echo "  make test         - Run all tests"
	@echo "  make test-file    - Run a specific test file (usage: make test-file FILE=tests/termlet_spec.lua)"
	@echo "  make lint         - Run luacheck linter"
	@echo "  make format       - Format code with stylua"
	@echo "  make format-check - Check formatting without modifying files"
	@echo "  make check        - Run lint, format-check, and tests"
	@echo "  make clean        - Clean up test artifacts"
	@echo "  make help         - Show this help message"

# Run all tests
test:
	@echo "Running all tests..."
	nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests/"

# Run a specific test file
# Usage: make test-file FILE=tests/termlet_spec.lua
test-file:
ifndef FILE
	@echo "Error: FILE parameter required"
	@echo "Usage: make test-file FILE=tests/termlet_spec.lua"
	@exit 1
endif
	@echo "Running tests in $(FILE)..."
	nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedFile $(FILE)"

# Run luacheck linter
lint:
	@echo "Running luacheck..."
	luacheck lua/ tests/

# Format code with stylua
format:
	@echo "Formatting with stylua..."
	stylua lua/ tests/

# Check formatting without modifying files
format-check:
	@echo "Checking formatting..."
	stylua --check lua/ tests/

# Run all checks (lint + format-check + tests)
check: lint format-check test

# Clean up any test artifacts
clean:
	@echo "Cleaning up test artifacts..."
	@find tests -name "*.swp" -delete 2>/dev/null || true
	@find tests -name "*~" -delete 2>/dev/null || true
	@echo "Clean complete"
