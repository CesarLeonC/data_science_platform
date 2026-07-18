FROM spark:3.5.3-scala2.12-java17-python3-ubuntu as builder

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

