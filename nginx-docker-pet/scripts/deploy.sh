#!/bin/bash

set -e

echo "🚀 Запуск автоматического развертывания..."

# Проверить Ansible
if ! command -v ansible-playbook &> /dev/null; then
    echo "❌ Ansible не установлен"
    exit 1
fi

# Проверить синтаксис playbook
echo "📋 Проверка синтаксиса Ansible playbooks..."
cd ansible
ansible-playbook -i inventory/hosts playbooks/site.yml --syntax-check

# Выполнить dry-run
echo "🔍 Выполнение dry-run..."
ansible-playbook -i inventory/hosts playbooks/site.yml --check

# Подтверждение развертывания
read -p "Продолжить развертывание? (y/N): " confirm
if [[ $confirm == [yY] ]]; then
    echo "🔧 Развертывание проекта..."
    ansible-playbook -i inventory/hosts playbooks/site.yml
    echo "✅ Развертывание завершено!"
else
    echo "❌ Развертывание отменено"
    exit 1
fi