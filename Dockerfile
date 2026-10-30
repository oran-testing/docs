FROM python:3-slim

WORKDIR /docs

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN sphinx-build -b html . _build

EXPOSE 8080

CMD ["python3", "-m", "http.server", "8080", "-d", "_build"]