# ORAN Tester UE Project Documentation

## Generate Docs

Install sphynx:

```bash
pip3 install -r requirements.txt
```

Choose one of the following depending on your needs:

```bash
make html
make json
make latex
```

## Run a server locally

```bash
cd _build/html
python3 -m http.server 8080
```

The docs can then be viewed at http://localhost:8080
