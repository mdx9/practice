
🛠️Pet-Project: Nginx + Docker
---
**Контейнеризованное веб-приложение с мониторингом** на базе:  
- **Nginx** — веб-сервер и reverse proxy  
- **Prometheus** — сбор метрик  
- **Grafana** — визуализация данных  
---
# Используемые технологии 
### 🐳 **Docker & Контейнеризация**  
- Оптимизация образов через `multi-stage` сборку  

### 🧩 **Оркестрация**  
- Развертывание стека через `docker-compose.yml`  
- Связь контейнеров (Nginx ↔ Prometheus ↔ Grafana) 

### 📊 **Мониторинг**  
- Интеграция **Prometheus** для метрик 
- Создание дашбордов в **Grafana**

### ⚙️ **Автоматизация**  
- **Makefile** для стандартных задач (`make build`, `make up`)  
- Скрипты для тестирования доступности `bash`  

# 📁 Структура проекта 

```bash
nginx-docker-pet/
├── 📄 README.md          # 
├── 🐳 Dockerfile           # Конфигурация Docker-образа
├── 🧩 docker-compose.yml   # Настройка сервисов
├── ⚙️ Makefile            # Автоматизация команд
├── 🖥️ nginx/              # 
│   ├── 📄 nginx.conf     # Rонфиг Nginx
│   └── 📂 html/          
│       ├── 📄 index.html # Главная страница
│       └── 📄 health.html # Health-check страница
├── 📈 prometheus/        # Мониторинг
│   └── 📄 prometheus.yml 
└── 🛠️ scripts/           
    └── 📜 test.sh        # Тестовый скрипт
```
## 🚀 Инструкции по запуску

### 1. Подготовка окружения
```bash
# Клонировать репозиторий проекта
git clone https://github.com/mdx9/nginx-docker-pet.git
cd nginx-docker-pet

# Дать права на выполнение скриптов
chmod +x scripts/test.sh
```

### 2. Запуск сервисов

Собрать контейнеры и запустить сервисы
```make build && make up```

Доступные URL
```
Сайт: http://localhost
Health Check: http://localhost/health
Nginx Status: http://localhost/status
Grafana: http://localhost:3000 (admin/admin)
Prometheus: http://localhost:9090
```
### 3. Опции Makefile
Посмотреть все опции
```make help ```

Посмотреть логи
```make logs```

Остановить сервисы
```make down```

 Очистить все
```make clean```

Проверить статус
```make status```

Запустить тесты
```make test```

---

### 4. образ есть в 🐳 Docker HUB 🐳
```docker
docker push mdx9/nginx-devops-project:v3
```
![image](https://github.com/user-attachments/assets/4048fbd3-3cad-4f2c-8285-dbe5483cbf10)
