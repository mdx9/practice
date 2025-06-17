#!/bin/bash

echo "🧪 Запуск тестов..."

# Проверка доступности главной страницы
echo "Проверка главной страницы..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost | grep -q "200"; then
    echo "✅ Главная страница доступна"
else
    echo "❌ Главная страница недоступна"
    exit 1
fi

# Проверка health check
echo "Проверка health check..."
if curl -s http://localhost/health | grep -q "healthy"; then
    echo "✅ Health check прошел"
else
    echo "❌ Health check не прошел"
    exit 1
fi

# Проверка статуса nginx
echo "Проверка статуса nginx..."
if curl -s http://localhost/status | grep -q "Active connections"; then
    echo "✅ Статус nginx доступен"
else
    echo "❌ Статус nginx недоступен"
    exit 1
fi

echo "🎉 Все тесты прошли успешно!"