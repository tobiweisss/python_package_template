# 🐍 Python Package Template

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Python](https://img.shields.io/badge/python-3.x-blue.svg)
![Tools](https://img.shields.io/badge/tools-ruff%20%7C%20mypy%20%7C%20pytest-informational)

A lightweight script to quickly bootstrap a clean and modern Python package setup.

---

## ✨ Features

* 📦 Initialize a Python package using `uv`
* 🧪 Automatically add development tools:

  * `ruff` (linting & formatting)
  * `mypy` (type checking)
  * `pytest` (testing)
* ⚙️ Preconfigured `pyproject.toml`
* 🔁 Pre-commit hooks for:

  * formatting (`ruff format`)
  * linting (`ruff check`)
  * type checking (`mypy`)
  * testing (`pytest`)

---

## 🚀 Usage

Run the script inside your project directory:

```bash
package-init
```

### ⚙️ Options

```bash
-v, --version           Specify the Python version for the virtual environment
-n, --name              Package name (default: current directory name)

--no-ruff               Skip installing ruff
--no-mypy               Skip installing mypy (DEPRECATED: use --no-ty instead, will be removed in version: 1.0.0)
--no-ty                 Skip installing ty for type checking
--no-pytest             Skip installing pytest

--no-ruff-hook          Skip ruff pre-commit hook
--no-mypy-hook          Skip mypy pre-commit hook (DEPRECATED: use --no-ty-hook instead, will be removed in version: 1.0.0)
--no-ty-hook            Skip ty pre-commit hook
--no-pytest-hook        Skip pytest pre-commit hook

--include-ty-for-tests  Include test files in type checking (only applies if ty is included)

-h, --help              Show help message
```

> 💡 If a tool is not installed, its corresponding pre-commit hook will be disabled automatically.

---

## 🛠️ Setup

### Requirements

* [uv](https://docs.astral.sh/uv/)
* [git](https://git-scm.com/)

---

### 📥 Installation

#### Option 1 (Recommended)

Download the package format for your platform from the [Releases](https://github.com/tobiweisss/python_package_template/releases) page and install it using your system's package manager.

For Ubuntu/Debian:

```bash
sudo apt install package-init-<version>.deb
```

For Fedora/RHEL:
```bash
sudo dnf install package-init-<version>.rpm
```

> [!NOTE]
> This was only tested on Fedora 43, but it should work on any Linux distribution with a compatible package manager. If you encounter any issues, please report them via the GitHub issues page and consider contributing a fix.

#### Option 2 (Manual)
Clone the repository and add the script to your :

```bash
git clone https://github.com/tobiweisss/python_package_template.git
cp python_package_template/package-init.sh /usr/bin/package-init
chmod +x /usr/bin/package-init
cp -r python_package_template/hooks/ /usr/share/package-init/hooks/
cp -r python_package_template/configs/ /usr/share/package-init/configs/
```


## Change Log
- `0.2.1` - fix pre-commit hook for type checking to work with `ty`, ignore `*.ipynb` files in type checking by default
- `0.2.0` - switch from `mypy` to `ty` for type checking, add option to include type checking for test files
- `0.1.5` - fix pre-commit hook to fail when ruff formats the code
- `0.1.4` - Let the pre-commit hook fail when ruff changes the code
- `0.1.3` - Drop dependency on `uv` since uv is usually not installed via the system package manager.
- `0.1.2` - Initial release with basic functionality and support for `ruff`, `mypy`, and `pytest`.

## 🤝 Contributing

Contributions are very welcome!

* 🐛 Report bugs via issues
* 💡 Suggest features
* 🔧 Open pull requests

If you like this project, consider giving it a ⭐ on GitHub.

---

## 📄 License

This project is licensed under the MIT License.
See the [LICENSE](LICENSE) file for details.
