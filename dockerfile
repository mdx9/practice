# Стадия 1: Подготовка файлов
FROM alpine:3.18 AS builder

# Устанавливаем утилиты для подготовки
RUN apk add --no-cache curl

# Создаем рабочую директорию
WORKDIR /app

# Копируем файлы для подготовки
COPY nginx/ ./nginx/

# Здесь можно добавить обработку файлов, минификацию и т.д.
# Для примера просто копируем
RUN mkdir -p /prepared/html /prepared/conf
RUN cp -r nginx/html/* /prepared/html/
RUN cp nginx/nginx.conf /prepared/conf/

# Стадия 2: Финальный образ
FROM nginx:1.25-alpine AS production

# Устанавливаем только необходимые пакеты
RUN apk add --no-cache curl && \
    rm -rf /var/cache/apk/*

# Копируем подготовленные файлы из предыдущей стадии
COPY --from=builder /prepared/conf/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /prepared/html/ /usr/share/nginx/html/

# Проверяем конфигурацию nginx
RUN nginx -t

# Health check
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]