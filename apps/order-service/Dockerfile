# apps/order-service/Dockerfile
FROM python:3.11-slim
WORKDIR /app
RUN useradd -m svcuser
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN chown -R svcuser:svcuser /app
USER svcuser
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
