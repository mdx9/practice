-- Создание таблицы для логирования посещений
CREATE TABLE IF NOT EXISTS visits (
    id SERIAL PRIMARY KEY,
    ip_address INET NOT NULL,
    user_agent TEXT,
    visit_time TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    page_url TEXT DEFAULT '/'
);

-- Создание индексов для оптимизации
CREATE INDEX IF NOT EXISTS idx_visits_time ON visits(visit_time);
CREATE INDEX IF NOT EXISTS idx_visits_ip ON visits(ip_address);

-- Вставка тестовых данных
INSERT INTO visits (ip_address, user_agent, visit_time) VALUES
    ('127.0.0.1', 'Mozilla/5.0 (Test Browser)', NOW() - INTERVAL '1 hour'),
    ('192.168.1.100', 'Mozilla/5.0 (Chrome)', NOW() - INTERVAL '2 hours'),
    ('10.0.0.1', 'Mozilla/5.0 (Firefox)', NOW() - INTERVAL '3 hours');

-- Создание пользователя для мониторинга (если нужно)
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'monitoring') THEN
        CREATE ROLE monitoring WITH LOGIN PASSWORD 'monitoring_pass';
        GRANT CONNECT ON DATABASE devops_db TO monitoring;
        GRANT USAGE ON SCHEMA public TO monitoring;
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO monitoring;
    END IF;
END
$$;