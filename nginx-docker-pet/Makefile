.PHONY: help build up down logs status clean test

# Показать помощь
help:
	@echo "Доступные команды:"
	@echo "  build   - Собрать Docker образ"
	@echo "  up      - Запустить все сервисы"
	@echo "  down    - Остановить все сервисы"
	@echo "  logs    - Показать логи nginx"
	@echo "  status  - Проверить статус сервисов"
	@echo "  test    - Запустить тесты"
	@echo "  clean   - Очистить Docker ресурсы"

# Собрать образ
build:
	docker compose build

# Запустить сервисы
up:
	docker compose up -d
	@echo "Сервисы запущены!"
	@echo "Nginx: http://localhost"
	@echo "Grafana: http://localhost:3000 (admin/admin)"
	@echo "Prometheus: http://localhost:9090"

# Остановить сервисы
down:
	docker compose down

# Показать логи
logs:
	docker compose logs -f nginx

# Проверить статус
status:
	docker compose ps
	@echo "\nПроверка health check:"
	@curl -s http://localhost/health || echo "Сервис недоступен"

# Запустить тесты
test:
	./scripts/test.sh

# Очистить ресурсы
clean:
	docker compose down -v
	docker system prune -f
