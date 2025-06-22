FROM python:3.11-alpine

WORKDIR /app

# Установка зависимостей для PostgreSQL
RUN apk add --no-cache postgresql-dev gcc musl-dev

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/api/health || exit 1

CMD ["python", "app.py"]