from flask import Flask, jsonify, request, render_template_string
import psycopg2
from psycopg2.extras import RealDictCursor
import os
from datetime import datetime
import logging

app = Flask(__name__)

# Настройка логирования
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Конфигурация БД
DATABASE_URL = os.getenv('DATABASE_URL', 'postgresql://devops_user:devops_password@localhost:5432/devops_db')

def get_db_connection():
    try:
        conn = psycopg2.connect(DATABASE_URL, cursor_factory=RealDictCursor)
        return conn
    except Exception as e:
        logger.error(f"Database connection error: {e}")
        return None

@app.route('/api/health')
def health_check():
    """API Health Check с проверкой БД"""
    try:
        conn = get_db_connection()
        if conn:
            cur = conn.cursor()
            cur.execute('SELECT 1')
            conn.close()
            return jsonify({
                'status': 'healthy',
                'database': 'connected',
                'timestamp': datetime.now().isoformat()
            })
        else:
            return jsonify({
                'status': 'unhealthy',
                'database': 'disconnected',
                'timestamp': datetime.now().isoformat()
            }), 500
    except Exception as e:
        return jsonify({
            'status': 'error',
            'error': str(e),
            'timestamp': datetime.now().isoformat()
        }), 500

@app.route('/api/stats')
def get_stats():
    """Получение статистики из БД"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Database connection failed'}), 500
        
        cur = conn.cursor()
        
        # Статистика посещений
        cur.execute('SELECT COUNT(*) as total_visits FROM visits')
        visits = cur.fetchone()
        
        # Последние визиты
        cur.execute('SELECT * FROM visits ORDER BY visit_time DESC LIMIT 10')
        recent_visits = cur.fetchall()
        
        conn.close()
        
        return jsonify({
            'total_visits': visits['total_visits'],
            'recent_visits': [dict(visit) for visit in recent_visits],
            'timestamp': datetime.now().isoformat()
        })
    except Exception as e:
        logger.error(f"Stats error: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/visit', methods=['POST'])
def log_visit():
    """Логирование посещения"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({'error': 'Database connection failed'}), 500
        
        cur = conn.cursor()
        user_agent = request.headers.get('User-Agent', 'Unknown')
        ip_address = request.remote_addr
        
        cur.execute(
            'INSERT INTO visits (ip_address, user_agent, visit_time) VALUES (%s, %s, %s)',
            (ip_address, user_agent, datetime.now())
        )
        conn.commit()
        conn.close()
        
        return jsonify({'status': 'logged', 'timestamp': datetime.now().isoformat()})
    except Exception as e:
        logger.error(f"Visit logging error: {e}")
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)