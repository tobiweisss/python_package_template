# Python Package Template
This script is designed to quickly set up a clean and modern Python package structure, complete with essential development tools and pre-commit hooks.

It includes the following features:
- Initializes a Python package using `uv`
- Automatically add development tools to the project environment:
    - `ruff` for linting and formatting
    - `ty` for type checking (replacing `mypy`)
    - `pytest` for testing
- Preconfigured `pyproject.toml` for project metadata and dependencies
- Pre-commit hooks for:
    - Formatting with `ruff format`
    - Linting with `ruff check`
    - Type checking with `ty`
    - Testing with `pytest`

# Strcture
`package_init.sh` - The main script to intialize the package structure and set up the development environment.
`README.md` - This file, providing an overview of the project and instructions for usage.
`configs/` - A directory containing configuration files for the development tools (e.g. `ruff.toml`)
`hooks/` - A directory containing pre-commit hook scripts for the various tools (e.g. `ruff_hook.sh`, `ty_hook.sh`, `pytest_hook.sh`)
