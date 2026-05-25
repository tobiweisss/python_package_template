# CLAUDE.md

## Purpose

This file provides guidance to Claude Code (claude.ai/code) when working with a Python project. It defines the preferred workflow, conventions, and tooling so that Claude can assist efficiently and consistently.

## Typical Development Workflow

1. **Plan** –
   - Create a task list in the Claude task system (or a plain TODO file).
   - Outline the steps, identify dependencies, and estimate effort.
   - Record any design decisions, open questions, or constraints.
2. **Write Code** –
   - Implement the feature or fix, following the project's style guidelines.
   - Keep functions small and well‑named; add type hints where appropriate.
   - Update documentation strings only when the intent changes.
3. **Lint / Test / Type‑Check** –
   - Run `uv run ruff format .` and `uv run ruff check --fix .` to format and lint.
   - Run `uv run pytest` to execute the test suite.
   - Run `uv run ty check .` for static type checking.
   - Fix any failures before committing.
4. **Commit** –
   - Stage only the intended changes (`git add <files>`).
   - Write a concise commit message that explains **why** the change is needed.
   - The pre‑commit hooks will automatically run lint, type‑check, and tests.
5. **Review & Merge** –
   - Open a Pull Request, ensure the CI passes, and request reviewers.
   - Once approved, merge to `main` and bump the version in `version.txt`.

## Coding Conventions

- **Naming**: Use `snake_case` for functions/variables, `PascalCase` for classes, and `UPPER_SNAKE_CASE` for constants.
- **Imports**: Group standard library, third‑party, and local imports, separated by a blank line. Use absolute imports for intra‑repo modules.
- **Docstrings**: One‑line summary plus optional description; follow the NumPy style.
- **Type Hints**: Add hints for function signatures and public APIs. Use `typing` module for complex types.
- **Error Handling**: Raise specific exception classes; avoid bare `except:`.
- **Testing**: Place tests in `tests/` mirroring the package layout. Use `pytest` fixtures for shared setup.

## Repository Structure Overview

```
my_package/
├── src/                 # Primary source code package
|   └── my_package/      # The actual Python package 
├── tests/               # Test suite
├── CLAUDE.md            # This guidance file (template for new packages)
├── README.md            # User‑facing documentation
└── pyproject.toml       # Project metadata and dependencies
```

## Common Commands (quick reference)

- **Initialize a new package**: `package-init [options]`
- **Install dev dependencies**: `uv sync --dev`
- **Add a dev tool**: `uv add --dev <tool>`
- **Add new dependency**: `uv add <package>`
- **Format code**: `uv run ruff format .`
- **Lint & fix**: `uv run ruff check --fix .`
- **Type check**: `uv run ty check .`
- **Run tests**: `uv run pytest`
- **Run pre‑commit manually**: `.git/hooks/pre-commit`

## Tips for Claude

- When asked to *plan* a change, propose a task list following the workflow above.
- For *code* changes, respect the naming, import, and docstring conventions.
- Before *committing*, run the lint, test, and type‑check steps and mention any failures.
- If a user asks for *documentation* updates, keep them concise and aligned with the README style.
- When *debugging*, prefer reproducing the failure locally (`uv run pytest` or running the script) before suggesting code edits.

---

*This template is designed to be copied into new projects via the `--claude` flag of `package-init.sh`.*
