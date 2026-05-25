# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands
- **Initialize a new package** (the primary entry point of this repo):
  ```bash
  package-init [options]
  ```
  See `package-init.sh` for the full option list. Typical workflow is to run it in an empty directory to scaffold a new Python package.

- **Virtual‑environment / dependency management** (all commands use the `uv` tool that is bundled with the script):
  - Install the development dependencies listed in the generated `pyproject.toml`:
    ```bash
    uv sync --dev
    ```
  - Add a new dev tool (e.g., `ruff`, `ty`, `pytest`):
    ```bash
    uv add --dev <tool>
    ```

- **Lint & format** (handled by the `ruff` pre‑commit hook, but can be run manually):
  ```bash
  uv run ruff format .
  uv run ruff check --fix .
  ```

- **Static type checking** (via `ty`, the successor to `mypy`):
  ```bash
  uv run ty check .
  ```

- **Run tests**:
  ```bash
  # All tests
  uv run pytest
  # A single test file or test case
  uv run pytest path/to/test_file.py::test_name
  ```

- **Pre‑commit hooks** (installed automatically by `package-init.sh` when the corresponding tool is included):
  - `ruff` – formats and lints code.
  - `ty` – type checks.
  - `pytest` – runs the test suite.
  Running `git commit` will invoke these hooks; they can be triggered manually with:
  ```bash
  .git/hooks/pre-commit
  ```

- **Build distributable packages** (CI job in `.github/workflows/package_and_release.yaml`):
  - Ensure `version.txt` contains the desired version.
  - The workflow uses `fpm` to produce a `.deb` and `.rpm` containing `package-init.sh` plus the `configs/` and `hooks/` directories.
  - To build locally, install `fpm` and run the same `fpm` commands from the workflow.

## High‑Level Architecture & Structure
- **`package-init.sh`** – the core CLI script. It parses command‑line options, creates a Python package via `uv init`, optionally adds dev tools (`ruff`, `ty`, `pytest`), and appends the appropriate pre‑commit hook scripts to `.git/hooks/pre-commit`.
- **`hooks/`** – contains the shell snippets that each pre‑commit hook runs. They invoke the installed tool in the virtual environment and abort the commit on failures.
- **`configs/ruff-config.toml`** – the default Ruff configuration used when the `--no-ruff` flag is not set. It defines excluded paths, line length, target Python version, selected lint rules, and formatting style.
- **`README.md`** – user‑facing documentation describing the script’s purpose, feature list, installation methods, and usage options. Important for new developers to understand the intended workflow.
- **`.github/workflows/package_and_release.yaml`** – CI pipeline that triggers on changes to `version.txt`. It builds Debian and RPM packages using `fpm` and publishes a GitHub release.
- **`version.txt`** – single‑source version number consumed by the CI workflow.
- **`LICENSE`** – MIT license governing the project.

### Interaction Flow
1. **Plan** – Always start by making a plan for the change you want to make. Identify which files and functions will be affected.
2. **Implement** – Make your code changes, ensuring to follow the existing style and conventions. If adding a new feature, consider how it will integrate with the current architecture.
3. **Release** – Bump the version in `version.txt`, merge to `main`. The GitHub workflow automatically builds and publishes `.deb`/`.rpm` artifacts.

## Important Files Summary
- `package-init.sh` – entry point script (see line numbers for option handling).
- `hooks/ruff.hook`, `hooks/ty.hook`, `hooks/pytest.hook` – pre‑commit hook implementations.
- `configs/ruff-config.toml` – linting configuration.
- `.github/workflows/package_and_release.yaml` – CI automation for packaging.
- `README.md` – high‑level user documentation.
