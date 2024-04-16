FROM python:3.10-slim

RUN apt update && apt upgrade -y && \
    apt install -y ssh nmap gobuster git curl && \
    pip install --no-cache-dir poetry

WORKDIR /app

COPY ./src/pyproject.toml /app/pyproject.toml
RUN poetry install --no-root

COPY ./common.txt /app/common.txt

COPY ./src/main.py .

CMD ["poetry", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
