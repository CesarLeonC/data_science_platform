FROM openjdk:8-jre-slim AS builder

WORKDIR /build

COPY requirements.txt .

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -rf /var/lib/apt/lists/*

FROM openjdk:8-jre-slim

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

RUN wget -O /tmp/spark-3.5.3-bin-hadoop3.tgz https://archive.apache.org/dist/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz && \
    tar -xzvf /tmp/spark-3.5.3-bin-hadoop3.tgz -C /opt/ && \
    rm /tmp/spark-3.5.3-bin-hadoop3.tgz

ENV SPARK_HOME=/opt/spark-3.5.3-bin-hadoop3
ENV PATH=$PATH:$SPARK_HOME/bin