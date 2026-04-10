# Python Package Template
This is a small script to help you initialize a typical python package. By default the script operates in the current directory and does the following things:
- initialize package using `uv` 
- add `ruff`, `pytest` and `mypy` to dev dependencies
- add `ruff` and `mypy` config to `pyproject.toml`
- add a pre-commit hook to automatically run 
    - `ruff format .`
    - `ruff check .`
    - `mypy .`
    - `pytest`

## Usage
The behaviour can be controlled via the following command line options:
    ```
    -v, --version       specify the python version to use for the virtual environment
    -n, --name          specify the name of the package to be created (default: the name of the directory)
    --no-ruff           do not include ruff in the virtual environment
    --no-mypy           do not include mypy in the virtual environment
    --no-pytest         do not include pytest in the virtual environment
    --no-ruff-hook      do not include the ruff pre-commit hook in the project
    --no-mypy-hook      do not include the mypy pre-commit hook in the project
    --no-pytest-hook    do not include the pytest pre-commit hook in the project
    -h, --help          show this help message and exit
    ```
Of course if the tools (ruff/mypy/pytest) are not installed the pre-commit hooks are automatically disabeled.

## Setup
### Requirements
- [uv](https://docs.astral.sh/uv/)
- [git](https://git-scm.com/)

### Installation
The most convenient way is to checkout this repository and run the provided install script:
```
git clone https://github.com/tobiweisss/python_package_template.git
cd python_package_template
sudo ./install.sh
```
This will create a symlink to the package template script in `/usr/local/bin` so that you can run it from anywhere on your system. If you want to update the script in the future, simply pull the latest changes from the repository and everything will be up to date.

Alternatively you can also create a copy of the `package-init.sh` script together with the `configs` and `hooks` directories into `/usr/local/bin` (or any other directory in your `PATH`) via the following commands:
```
sudo mkdir -p /usr/local/bin/package-init
sudo cp package-init.sh /usr/local/bin/package-init/package-init
sudo cp -r configs /usr/local/bin/package-init/configs
sudo cp -r hooks /usr/local/bin/package-init/hooks
sudo chmod +x /usr/local/bin/package-init/package-init
```
This will create a new directory called `package-init` in `/usr/local/bin` and copy the script and the necessary config and hook files into it. You can then run the script from anywhere on your system by simply typing `package-init` in the terminal.

## Contributing
If you want to contribute to this project, feel free to open a pull request or submit an issue. Any contributions are welcome! If you have any suggestions for improvements or new features, please let me know. If you like this project and want to support it, consider giving it a star on GitHub. This helps me to keep the project alive and motivates me to add new features and fix bugs. Thank you for your support!

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
