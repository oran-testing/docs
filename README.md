# RAN Tester UE Docs

Documentation for RAN tester UE, a 5G security analysis tool.

# Local Installation

The docs require multiple sphinx extensions.

On Ubuntu, they can be installed by first setting up a virtual environment with the following commands within the docs project: 
```
apt install python3.10-venv
python -m venv .venv
```

Then run
```
source .venv/bin/activate
```

You can then install the necessary requirements using:

```
pip install -r requirements.txt
```

Once all dependencies are installed, you can download and build the docs with the following commands: 

```
git clone https://github.com/oran-testing/docs.git
cd docs/
make html
```

Then, navigate to the output directory where the HTML files are generated:

```bash
cd _build/html
python3 -m http.server 8080
```

This will start a server at http://localhost:8080/ which can be viewed in your browser, any changes to the docs will be shown here once saved. 


After finishing your work, deactivate the virtual environment by running:
```
deactivate
```

