# Soft-Tester_UE

Documentation for the RAN tester UE software system - visit [docs.rantesterue.org](https://docs.rantesterue.org)

# Local Installation

The docs require multiple sphinx extensions.

On Ubuntu, they can be installed with:

```
sudo apt install python3-pip
pip3 install -r requirements.txt
```

Once these are installed, you can download and build the docs with the following:

```
git clone https://github.com/oran-testing/docs
cd docs
make html
```

Then you can make a server in the build directory with this command:

```bash
cd _build/html
python3 -m http.server 8080
```

Then visit http://localhost:8080 in your browser
