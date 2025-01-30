Python Development
------------------

First install poetry:

.. code:: bash

   sudo apt install python3 pipx
   pipx install poetry

Then navigate to the poetry project directory (where the pyproject.toml
file is located) and run ``poetry install``

Run:

- ``poetry add <dep name>`` to add a new dependency
- ``poetry run black .`` to reformat python code 
- ``poetry run isort .`` to manage python imports code 
- ``poetry run flake8 .`` to lint python code
- ``poetry run mypy .`` for debugging and static typing of python code
- ``poetry run pytest ./tests/__init__.py`` to run python tests
- ``poetry show --tree`` to show a tree of the current packages and their dependencies 

C++ Development
---------------

For all C++ development (primarily on srsRAN code) we will be using
clangd to format code as we write.

Install the C++ VSCode extension, and it will automatically detect and
use the .clang-tidy file If you are using another editor install and run
a clangd LSP server like so:

.. code:: bash

   sudo apt install clangd
   cd <repo folder>
   clangd --clang-tidy .

Then the clangd process will format code passed through stdout

Repo Management
---------------

what repos should we have? Should everything be committed to one or
should we split based on responsiblites.
