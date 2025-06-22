#!/bin/bash

set -e

BACKUP_DIR="./database/backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
CONTAINER_NAME="postgres-db"
DB_NAME="devops_db"
BACKUP_FILE="backup_${DB_NAME}_${TIMESTAMP}.sql"

echo "🗄️ Создание бэкапа PostgreSQL..."

# Создать директорию для бэкапов
mkdir -p $BACKUP_DIR

# Создать бэкап
docker exec $CONTAINER_NAME pg_dump -U devops_user -d $DB_NAME > "${BACKUP_DIR}/${BACKUP_FILE}"

# Сжать бэкап
gzip "${BACKUP_DIR}/${BACKUP_FILE}"

echo "✅ Бэкап создан: ${BACKUP_DIR}/${BACKUP_FILE}.gz"

# Удалить старые бэкапы (старше 7 дней)
find $BACKUP_DIR -name "backup_*.sql.gz" -mtime +7 -delete

echo "🧹 Старые бэкапы удалены"