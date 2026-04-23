FROM python:3.13.13-slim-trixie@sha256:9213d136547f0602c3337ff48291e937f9cc43060b3e123402cf2aaff1a08b75

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt


CMD ["python", "mange.py", "runserver", "0.0.0.0:8000"]
