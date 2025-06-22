.PHONY: help build up down logs status clean test backup deploy ansible-check ansible-deploy

# Показать помощь
help:
	@echo "Доступные команды:"
	@echo "  build        - Собрать Docker образы"
	@echo "  up           - Запустить все сервисы"
	@echo "  down         - Остановить все сервисы"
	@echo "  logs         - Показать логи сервисов"
	@echo "  status       - Проверить статус сервисов"
	@echo "  test         - Запустить тесты"
	@echo "  backup       - Создать бэкап БД"
	@echo "  clean        - Очистить Docker ресурсы"
	@echo "  deploy       - Развернуть проект через Ansible"
	@echo "  ansible-check - Проверить Ansible playbooks"

# Собрать образы
build:
	docker compose build --no-cache

# Запустить сервисы
up:
	docker-compose up -d
	@echo "Сервисы запущены!"
	@echo "Веб-сайт: http://localhost"
	@echo "API: http://localhost:5000"
	@echo "Grafana: http://localhost:3000 (admin/admin)"
	@echo "Prometheus: http://localhost:9090"
	@echo "PostgreSQL: localhost:5432"

# Остановить сервисы
down:
	docker compose down

# Показать логи
logs:
	docker compose logs -f

# Проверить статус
status:
	docker compose ps
	@echo "\nПроверка health check:"
	@curl -s http://localhost/health || echo "Nginx недоступен"
	@curl -s http://localhost:5000/api/health || echo "API недоступен"

# Запустить тесты
test:
	./scripts/test.sh

# Создать бэкап БД
backup:
	./scripts/backup.sh

# Развертывание через Ansible
deploy:
	./scripts/deploy.sh

# Проверка Ansible
ansible-check:
	cd ansible && ansible-playbook -i inventory/hosts playbooks/site.yml --check

# Развертывание через Ansible
ansible-deploy:
	cd ansible && ansible-playbook -i inventory/hosts playbooks/site.yml

# Очистить ресурсы
clean:
	docker compose down -v --remove-orphans
	docker system prune -f
	docker volume prune -f