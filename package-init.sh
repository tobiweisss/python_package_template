#!/bin/bash

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -v, --version       specify the python version to use for the virtual environment"
    echo "  -n, --name          specify the name of the package to be created (default: the name of the directory)"
    echo "  --no-ruff           do not include ruff in the virtual environment"
    echo "  --no-mypy           do not include mypy in the virtual environment"
    echo "  --no-pytest         do not include pytest in the virtual environment"
    echo "  --no-ruff-hook      do not include the ruff pre-commit hook in the project"
    echo "  --no-mypy-hook      do not include the mypy pre-commit hook in the project"
    echo "  --no-pytest-hook    do not include the pytest pre-commit hook in the project"
    echo "  -h, --help          show this help message and exit"
    exit 1
}

# Default values
SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$0")")
PYTHON_VERSION=""
PACKAGE_NAME=""
INCLUDE_RUFF=true
INCLUDE_MYPY=true
INCLUDE_PYTEST=true
INCLUDE_RUFF_HOOK=true
INCLUDE_MYPY_HOOK=true
INCLUDE_PYTEST_HOOK=true


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
                INCLUDE_MYPY=false
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
                INCLUDE_MYPY_HOOK=false
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
echo "  Include mypy: ${INCLUDE_MYPY}"
echo "  Include pytest: ${INCLUDE_PYTEST}"
echo "  Include ruff pre-commit hook: ${INCLUDE_RUFF_HOOK}"
echo "  Include mypy pre-commit hook: ${INCLUDE_MYPY_HOOK}"
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

if [ "$INCLUDE_MYPY" = true ]; then
    echo "Adding mypy to the virtual environment..."
    uv add --dev mypy
    # Add mypy config to pyproject.toml
    echo "Adding mypy configuration to pyproject.toml..."
    cat "$SCRIPT_DIR/configs/mypy-config.toml" >> pyproject.toml
fi

if [ "$INCLUDE_PYTEST" = true ]; then
    echo "Adding pytest to the virtual environment..."
    uv add --dev pytest
fi

if [ "$INCLUDE_RUFF_HOOK" = true ] && [ "$INCLUDE_RUFF" = true ]; then
    echo "Adding ruff pre-commit hook..."
    cat "$SCRIPT_DIR/hooks/ruff.hook" >> .git/hooks/pre-commit
fi

if [ "$INCLUDE_MYPY_HOOK" = true ] && [ "$INCLUDE_MYPY" = true ]; then
    echo "Adding mypy pre-commit hook..."
    cat "$SCRIPT_DIR/hooks/mypy.hook" >> .git/hooks/pre-commit
fi

if [ "$INCLUDE_PYTEST_HOOK" = true ] && [ "$INCLUDE_PYTEST" = true ]; then
    echo "Adding pytest pre-commit hook..."
    cat "$SCRIPT_DIR/hooks/pytest.hook" >> .git/hooks/pre-commit
fi

echo "Package initialization complete!"
