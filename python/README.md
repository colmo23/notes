
Based on https://www.stuartellis.name/articles/python-modern-practices/

# Project creation
uv -  https://github.com/astral-sh/uv

# Code formatting
ruff
or
autopep8 --in-place --aggressive --aggressive python/script_template.py

# Code linter
ruff

# Testing 
pytest

# Type hinting
mypy

# Coding

* use enums and namedtuples
* use f strings f" my_var is: {my_var}"
* use argparse for command line options
* use pathlib for files - https://docs.python.org/3/library/pathlib.html
