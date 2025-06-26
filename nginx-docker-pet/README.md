# 🚀 DevOps Pet Project by MDX 


Этот проект демонстрирует комплексное решение, включающее контейнеризацию, мониторинг, базу данных, API и полную автоматизацию развертывания с помощью Ansible.


![Снимок экрана 2025-06-22 213657](https://github.com/user-attachments/assets/89acda72-2754-4daf-a7e3-90cdf28247b0)

### 🏗️ **Архитектура и инфраструктура**
- ✅ **Multi-stage Docker контейнеры** с оптимизацией образов
- ✅ **Docker Compose** для оркестрации всех сервисов
- ✅ **Nginx** как reverse proxy и веб-сервер
- ✅ **PostgreSQL 15** база данных с инициализацией
- ✅ **Flask API** для взаимодействия с БД
- ✅ **Health checks** для всех сервисов

### 📊 **Мониторинг и наблюдаемость**
- ✅ **Prometheus** для сбора метрик
- ✅ **Grafana** для визуализации данных
- ✅ **PostgreSQL Exporter** для мониторинга БД
- ✅ **Nginx Status** для мониторинга веб-сервера
- ✅ **Логирование** всех сервисов

### 🤖 **Автоматизация с Ansible**
- ✅ **Полная автоматизация развертывания**
- ✅ **Ansible Roles** для модульной структуры
- ✅ **Inventory management** для разных окружений
- ✅ **Idempotent playbooks** для надежного развертывания
- ✅ **Проверка синтаксиса** и dry-run режим

### 🗄️ **База данных**
- ✅ **PostgreSQL** с автоматической инициализацией
- ✅ **Мониторинг производительности БД**
- ✅ **Система логирования посещений**

## 🏛️ Архитектура проекта

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Nginx (80)    │◄──►│   Flask API      │◄──►│ PostgreSQL      │
│   Web Server    │    │   (5000)         │    │ Database (5432) │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         │              ┌─────────────────┐              │
         │              │  Prometheus     │              │
         └──────────────►│  Monitoring     │◄─────────────┘
                        │  (9090)         │
                        └─────────────────┘
                                 │
                        ┌─────────────────┐
                        │   Grafana       │
                        │   Dashboard     │
                        │   (3000)        │
                        └─────────────────┘
```

## 🗂️ Структура проекта

```
nginx-devops-project/
├── 📄 README.md
├── 🐳 Dockerfile                    # Multi-stage Nginx контейнер
├── 📋 docker-compose.yml            # Оркестрация всех сервисов
├── ⚙️ Makefile                      # Команды управления
├── 🌐 nginx/
│   ├── nginx.conf                   # Конфигурация Nginx
│   └── html/                        # Веб-страницы
│       ├── index.html               # Главная страница
│       └── health.html              # Health check страница
├── 🐍 app/
│   ├── app.py                       # Flask API
│   ├── Dockerfile                   # API контейнер
│   └── requirements.txt             # Python зависимости
├── 🗄️ database/
│   ├── init.sql                     # Инициализация БД
├── 📊 prometheus/
│   └── prometheus.yml               # Конфигурация мониторинга
├── 📈 grafana/
│   ├── dashboards/                  # Преднастроенные дашборды
│   └── datasources/                 # Источники данных
├── 🤖 ansible/
│   ├── ansible.cfg                  # Конфигурация Ansible
│   ├── inventory/hosts              # Инвентарь серверов
│   ├── playbooks/                   # Основные playbooks
│   │   ├── site.yml                 # Главный playbook
│   │   ├── deploy.yml               # Развертывание
│   ├── roles/                       # Ansible роли
│   │   ├── docker/                  # Роль установки Docker
│   │   ├── monitoring/              # Роль мониторинга
│   │   └── database/                # Роль базы данных
│   └── group_vars/all.yml           # Переменные
└── 📜 scripts/
    ├── test.sh                      # Скрипт тестирования
    └── deploy.sh                    # Скрипт развертывания
```

## 🚀 Быстрый старт

  
### 1️⃣ Клонирование и подготовка
```bash
git clone https://github.com/mdx9/nginx-docker-pet.git
cd nginx-docker-pet
chmod +x scripts/*.sh
```

### 2️⃣ Локальный запуск
```bash
# Сборка и запуск всех сервисов
make build
make up

# Проверка статуса
make status

# Запуск тестов
make test
```

### 3️⃣ Автоматическое развертывание
```bash
# Развертывание через Ansible
make deploy

# Или поэтапно
make ansible-check  # Проверка синтаксиса
make ansible-deploy # Развертывание
```

## 🔗 Доступные сервисы

После запуска проекта доступны:

| Сервис | URL | Описание |
|--------|-----|----------|
| 🌐 **Веб-сайт** | http://localhost | Главная страница |
| 💚 **Health Check** | http://localhost/health | Проверка здоровья |
| 📊 **API Stats** | http://localhost:5000/api/stats | Статистика API |
| 📈 **Grafana** | http://localhost:3000 | Дашборды (admin/admin) |
| 🔍 **Prometheus** | http://localhost:9090 | Метрики |
| 🗄️ **PostgreSQL** | localhost:5432 | База данных |

## 🛠️ Доступные команды

```bash
# Основные команды
make build      # 🔨 Собрать Docker образы
make up         # ▶️ Запустить все сервисы
make down       # ⏹️ Остановить сервисы
make status     # 📊 Статус всех сервисов
make logs       # 📋 Просмотр логов
make test       # 🧪 Запуск тестов

# Обслуживание
make clean      # 🧹 Очистить Docker ресурсы

# Ansible команды
make deploy           # 🚀 Полное развертывание
make ansible-check    # ✅ Проверка playbooks
make ansible-deploy   # 🤖 Развертывание через Ansible
```
