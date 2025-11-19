# RAN Tester UE Docs

Documentation for **RAN Tester UE**, a 5G security analysis tool.

> [!TIP]
> This documentation supports both `.rst` and `.md` files.

# Local Installation

1. Clone the repository and navigate into it:
```console
git clone https://github.com/oran-testing/docs.git
cd docs/
```

2. Create and activate a Python virtual environment:
```console
python3 -m venv .env
source .env/bin/activate
```

3. Install the required dependencies:
```console
pip install -r requirements.txt
```

For convenience, run the live-reload Sphinx server, which will show live updates as you edit the docs files:
```console
sphinx-autobuild . _build/html/
```

Then, open <http://127.0.0.1:8000/> in your browser to see live updates.

After finishing your work, deactivate the virtual environment by running:
```console
deactivate
```
