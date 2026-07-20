FROM spark:3.5.3-scala2.12-java17-python3-ubuntu AS builder

USER root

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends build-essential && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    ls -al /usr/local/lib/python3.10

FROM spark:3.5.3-scala2.12-java17-python3-ubuntu

COPY --from=builder /usr/local/lib/python3.10/dist-packages /usr/local/lib/python3.10/dist-packages
COPY --from=builder /usr/local/bin /usr/local/bin

USER spark

