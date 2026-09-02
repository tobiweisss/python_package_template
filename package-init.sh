#!/bin/bash

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -v, --version           specify the python version to use for the virtual environment"
    echo "  -n, --name              specify the name of the package to be created (default: the name of the directory)"
    echo "  -c, --claude            enable creation of Claude‑Code configuration files"
    echo "  --no-ruff               do not include ruff in the virtual environment"
    echo "  --no-mypy               do not include mypy in the virtual environment (DEPRECATED: use --no-ty instead, will be removed in version: 1.0.0)"
    echo "  --no-ty                 do not include ty in the virtual environment"
    echo "  --no-pytest             do not include pytest in the virtual environment"
    echo "  --no-ruff-hook          do not include the ruff pre-commit hook in the project"
    echo "  --no-mypy-hook          do not include the mypy pre-commit hook in the project (DEPRECATED: use --no-ty-hook instead, will be removed in version: 1.0.0)"
    echo "  --no-ty-hook            do not include the ty pre-commit hook in the project"
    echo "  --no-pytest-hook        do not include the pytest pre-commit hook in the project"
    echo "  -h, --help              show this help message and exit"
    exit 1
}

# Default values
SCRIPT_DIR="/usr/share/package-init"
# NOTE: if you want this script to live somewhere else, change the above path
PYTHON_VERSION=""
PACKAGE_NAME=""
INCLUDE_RUFF=true
INCLUDE_TY=true
INCLUDE_PYTEST=true
INCLUDE_RUFF_HOOK=true
INCLUDE_TY_HOOK=true
INCLUDE_PYTEST_HOOK=true
INCLUDE_CLAUDE=false


# Parse command-line arguments
handle_args() {
    while [ $# -gt 0 ]; do
        case "$1" in
            -v|--version)
                PYTHON_VERSION="$2"
                shift 2
                ;;
            -n|--name)
                PACKAGE_NAME="$2"
                shift 2
                ;;
            --no-ruff)
                INCLUDE_RUFF=false
                shift
                ;;
            --no-mypy)
                INCLUDE_TY=false
                shift
                ;;
            --no-ty)
                INCLUDE_TY=false
                shift
                ;;
            --no-pytest)
                INCLUDE_PYTEST=false
                shift
                ;;
            --no-ruff-hook)
                INCLUDE_RUFF_HOOK=false
                shift
                ;;
            --no-mypy-hook)
                INCLUDE_TY_HOOK=false
                shift
                ;;
            --no-ty-hook)
                INCLUDE_TY_HOOK=false
                shift
                ;;
            --no-pytest-hook)
                INCLUDE_PYTEST_HOOK=false
                shift
                ;;
            -h|--help)
                usage
                ;;
            *)
                echo "Unknown option: $1" >&2
                usage
                ;;
        esac
    done
}

# set -eou pipefail

handle_args $@

echo ""
echo "Initializing package with the following settings:"
echo "  Python version: ${PYTHON_VERSION:-default}"
echo "  Package name: ${PACKAGE_NAME:-default (directory name)}"
echo "  Include ruff: ${INCLUDE_RUFF}"
echo "  Include ty: ${INCLUDE_TY}"
echo "  Include pytest: ${INCLUDE_PYTEST}"
echo "  Include ruff pre-commit hook: ${INCLUDE_RUFF_HOOK}"
echo "  Include ty pre-commit hook: ${INCLUDE_TY_HOOK}"
echo ""

if [ -n "$PYTHON_VERSION" ]; then
    echo "Creating package with Python $PYTHON_VERSION..."
    uv init --python "$PYTHON_VERSION" --package "${PACKAGE_NAME:-.}"
else
    echo "Creating package with default Python version..."
    uv init --package "${PACKAGE_NAME:-.}"
fi

if [ -n "$PACKAGE_NAME" ]; then
    cd "$PACKAGE_NAME"
fi

if [ "$INCLUDE_RUFF" = true ]; then
    echo "Adding ruff to the virtual environment..."
    uv add --dev ruff
    # Add ruff config to pyproject.toml
    echo "Adding ruff configuration to pyproject.toml..."
    cat "$SCRIPT_DIR/configs/ruff-config.toml" >> pyproject.toml
fi

if [ "$INCLUDE_TY" = true ]; then
    echo "Adding ty to the virtual environment..."
    uv add --dev ty
fi

if [ "$INCLUDE_PYTEST" = true ]; then
    echo "Adding pytest to the virtual environment..."
    uv add --dev pytest
fi

if [ "$INCLUDE_RUFF_HOOK" = true ] && [ "$INCLUDE_RUFF" = true ]; then
    echo "Adding ruff pre-commit hook..."
    cat "$SCRIPT_DIR/hooks/ruff.hook" >> .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
fi

if [ "$INCLUDE_TY_HOOK" = true ] && [ "$INCLUDE_TY" = true ]; then
    echo "Adding ty pre-commit hook..."
    cat "$SCRIPT_DIR/hooks/ty.hook" >> .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
fi

if [ "$INCLUDE_PYTEST_HOOK" = true ] && [ "$INCLUDE_PYTEST" = true ]; then
    echo "Adding pytest pre-commit hook..."
    cat "$SCRIPT_DIR/hooks/pytest.hook" >> .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
fi

if [ "$INCLUDE_CLAUDE" = true ]; then
  mkdir -p .claude

  # Generate CLAUDE.md with project details
  cat <<'EOF' > .claude/CLAUDE.md
  # Project Description

  <!-- Add a brief overview of the project -->

  # Structure

  - `package-init.sh` – initialization script
  - `configs/` – tool configuration files
  - `hooks/` – pre‑commit hook scripts
  - `.claude/` – Claude‑Code configuration

  # Code Guidelines

  - Follow PEP 8 style (ruff will enforce)
  - Use type hints (ty will check)
  - Write tests for all public functions (pytest)

  # Tools

  - **ruff** – linting and formatting
  - **ty** – type checking (replaces mypy)
  - **pytest** – test runner
  EOF

  # Create Claude‑Code settings describing used tools and hooks
  cat <<'EOF' > .claude/settings.json
  {
    "language": "python",
    "tools": {
      "ruff": ${INCLUDE_RUFF},
      "ty": ${INCLUDE_TY},
      "pytest": ${INCLUDE_PYTEST}
    },
    "hooks": {
      "ruff": ${INCLUDE_RUFF_HOOK},
      "ty": ${INCLUDE_TY_HOOK},
      "pytest": ${INCLUDE_PYTEST_HOOK}
    }
  }
  EOF

  # Example agent configurations for testing and code review
  mkdir -p .claude/agents
  cat <<'EOF' > .claude/agents/testing.json
  {
    "name": "testing",
    "description": "Run pytest on the project",
    "command": "pytest"
  }
  EOF

  cat <<'EOF' > .claude/agents/code_review.json
  {
    "name": "code_review",
    "description": "Run code‑review skill on the current diff",
    "command": "/code-review --effort medium"
  }
  EOF

fi

echo "Package initialization complete!"
