FROM python:3.13.13-slim-trixie@sha256:9213d136547f0602c3337ff48291e937f9cc43060b3e123402cf2aaff1a08b75

RUN apt-get update && apt-get install --no-install-recommends -y curl && \
    curl -sSfl https://get.anchore.io/syft | sh -s -- -b /usr/local/bin && \
    curl -sSfL https://get.anchore.io/grype | sh -s -- -b /usr/local/bin 

COPY requirements.txt .

CMD ["/usr/local/bin/syft", "requirements.txt", "-o", "cyclonedx-json"]
