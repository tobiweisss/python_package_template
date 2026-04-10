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
-v, --version       Specify the Python version for the virtual environment
-n, --name          Package name (default: current directory name)

--no-ruff           Skip installing ruff
--no-mypy           Skip installing mypy
--no-pytest         Skip installing pytest

--no-ruff-hook      Skip ruff pre-commit hook
--no-mypy-hook      Skip mypy pre-commit hook
--no-pytest-hook    Skip pytest pre-commit hook

-h, --help          Show help message
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

```bash
git clone https://github.com/tobiweisss/python_package_template.git
cd python_package_template
sudo ./install.sh
```

Creates a symlink in `/usr/local/bin`, so you can use `package-init` globally.

To update:

```bash
git pull
```
in the repository directory.

---

#### Option 2 (Manual)

```bash
sudo cp package-init.sh /usr/local/bin/package-init
sudo cp -r configs /usr/local/bin/configs
sudo cp -r hooks /usr/local/bin/hooks
sudo chmod +x /usr/local/bin/package-init
```

Then run:

```bash
package-init
```

---

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
