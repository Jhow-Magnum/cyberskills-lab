#!/usr/bin/env python3
from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_sock import Sock
import subprocess, yaml, uuid, time, threading, os, pty, select, struct, fcntl, termios, sqlite3, json
from pathlib import Path
from datetime import datetime, timedelta

app = Flask(__name__)
CORS(app)
sock = Sock(app)

sessions = {}
LABS_DIR = Path("repositories/cyberskills-lab/labs")
DB_FILE = "ctf_scores.db"

# Inicializa banco de dados
def init_db():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS users (
        user_id TEXT PRIMARY KEY,
        username TEXT,
        total_score INTEGER DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )''')
    c.execute('''CREATE TABLE IF NOT EXISTS sessions (
        session_id TEXT PRIMARY KEY,
        user_id TEXT,
        lab_id TEXT,
        score INTEGER DEFAULT 0,
        completed_challenges INTEGER DEFAULT 0,
        total_challenges INTEGER,
        start_time TIMESTAMP,
        end_time TIMESTAMP,
        duration_seconds INTEGER,
        FOREIGN KEY (user_id) REFERENCES users(user_id)
    )''')
    c.execute('''CREATE TABLE IF NOT EXISTS challenge_completions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id TEXT,
        challenge_id INTEGER,
        challenge_name TEXT,
        points INTEGER,
        completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (session_id) REFERENCES sessions(session_id)
    )''')
    conn.commit()
    
    # Cria usuário Tryg_Gelt com 1089 pontos (39 desafios)
    c.execute('SELECT user_id FROM users WHERE user_id = ?', ('Tryg_Gelt',))
    if not c.fetchone():
        c.execute('INSERT INTO users (user_id, username, total_score) VALUES (?, ?, ?)',
                  ('Tryg_Gelt', 'Tryg_Gelt', 1089))
        conn.commit()
    
    conn.close()

init_db()

def load_lab(lab_id):
    lab_file = LABS_DIR / lab_id / "lab.yaml"
    if lab_file.exists():
        with open(lab_file) as f:
            return yaml.safe_load(f)
    return None

@app.route('/api/labs')
def list_labs():
    # Pega user_id da query string
    user_id = request.args.get('user_id', '')
    
    labs = []
    for lab_dir in LABS_DIR.iterdir():
        if lab_dir.is_dir() and (lab_dir / "lab.yaml").exists():
            lab = load_lab(lab_dir.name)
            if lab:
                labs.append({
                    'id': lab_dir.name,
                    'name': lab['metadata']['name'],
                    'description': lab['metadata']['description'],
                    'difficulty': lab['metadata'].get('difficulty', 'medium'),
                    'duration': lab['metadata'].get('duration', '30m'),
                    'challenges': len(lab['spec']['challenges']),
                    'points': lab['spec']['scoring']['total_points']
                })
    
    # Verifica se usuário completou todos os labs
    if user_id:
        conn = sqlite3.connect(DB_FILE)
        c = conn.cursor()
        c.execute('SELECT COUNT(DISTINCT lab_id) FROM sessions WHERE user_id = ? AND completed_challenges = total_challenges', (user_id,))
        completed_labs = c.fetchone()[0]
        
        # Se completou todos os 6 labs, mostra desafio final
        if completed_labs >= 6:
            labs.append({
                'id': 'final-challenge',
                'name': '🏆 DESAFIO FINAL',
                'description': 'Você completou todos os desafios. Decifre o enigma final.',
                'difficulty': 'legendary',
                'duration': '10m',
                'challenges': 1,
                'points': 100
            })
        conn.close()
    
    return jsonify(labs)

@app.route('/api/start-lab', methods=['POST'])
def start_lab():
    data = request.json
    lab_id = data.get('lab_id')
    user_id = data.get('user_id', 'anonymous')
    
    # Desafio Final Especial
    if lab_id == 'final-challenge':
        session_id = str(uuid.uuid4())[:8]
        
        # Salva sessão
        conn = sqlite3.connect(DB_FILE)
        c = conn.cursor()
        c.execute('INSERT OR IGNORE INTO users (user_id, username) VALUES (?, ?)', 
                  (user_id, user_id))
        c.execute('''INSERT INTO sessions (session_id, user_id, lab_id, total_challenges, start_time)
                     VALUES (?, ?, ?, ?, ?)''',
                  (session_id, user_id, lab_id, 1, datetime.now()))
        conn.commit()
        conn.close()
        
        sessions[session_id] = {
            'container_id': None,
            'lab_id': lab_id,
            'user_id': user_id,
            'start_time': datetime.now(),
            'completed': set(),
            'score': 0
        }
        
        return jsonify({
            'success': True,
            'session': {
                'session_id': session_id,
                'ssh_port': None,
                'remaining_seconds': 600
            },
            'lab': {
                'name': '🏆 DESAFIO FINAL',
                'challenges': [{
                    'id': 1,
                    'name': 'Conquiste o Primeiro Lugar',
                    'description': 'Supere Tryg_Gelt no ranking.',
                    'points': 100,
                    'validation': {
                        'type': 'flag',
                        'flag': 'Jhow_Jhow'
                    }
                }]
            }
        })
    
    # Labs normais (código original)
    # Encerra TODAS as sessões anteriores do usuário e aguarda remoção
    for sid, sess in list(sessions.items()):
        if sess.get('user_id') == user_id:
            container_name = f'cyberskills-{sid}'
            # Remove container de forma forçada e aguarda
            subprocess.run(['docker', 'rm', '-f', container_name], capture_output=True)
            del sessions[sid]
    
    # Aguarda Docker processar remoções (importante!)
    time.sleep(1)
    
    lab = load_lab(lab_id)
    if not lab:
        return jsonify({'error': 'Lab não encontrado'}), 404
    
    session_id = str(uuid.uuid4())[:8]
    container_name = f'cyberskills-{session_id}'
    
    # Verifica se container com mesmo nome já existe (segurança extra)
    check = subprocess.run(['docker', 'ps', '-a', '-q', '-f', f'name={container_name}'], 
                          capture_output=True, text=True)
    if check.stdout.strip():
        subprocess.run(['docker', 'rm', '-f', container_name], capture_output=True)
        time.sleep(0.5)
    
    # Cria container com limites de recursos
    image = lab['spec']['environment']['image']
    cmd = [
        'docker', 'run', '-d',
        '--name', container_name,
        '--memory', '512m',
        '--cpus', '1.0',
        '-p', '22',
        image
    ]
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if result.returncode != 0:
        return jsonify({'error': 'Falha ao criar container'}), 500
    
    container_id = result.stdout.strip()
    time.sleep(2)
    
    # Remove arquivos que não devem existir ANTES de configurar
    subprocess.run(['docker', 'exec', container_name, 'sh', '-c',
                   'rm -f /root/README.txt /root/flag1.txt'],
                  capture_output=True)
    
    # Pega porta SSH
    port_result = subprocess.run(['docker', 'port', f'cyberskills-{session_id}', '22'], 
                                capture_output=True, text=True)
    ssh_port = port_result.stdout.strip().split(':')[-1] if port_result.returncode == 0 else '22'
    
    # Configura flags e ambiente no container
    for challenge in lab['spec']['challenges']:
        val = challenge.get('validation', {})
        
        # Crypto: não criar arquivos (já estão no Dockerfile)
        if lab_id == 'crypto':
            continue
        
        # Só cria arquivo se tiver location E não for flag1 (whoami)
        if val.get('type') == 'flag' and 'location' in val and 'flag1' not in val.get('location', ''):
            location = val['location']
            flag = val['flag']
            subprocess.run(['docker', 'exec', container_name, 'sh', '-c',
                          f'mkdir -p $(dirname {location}) && echo "{flag}" > {location}'],
                         capture_output=True)
    
    # Configurações especiais do Linux Basic
    if lab_id == 'linux-basic':
        # Script oculto (.secret.sh)
        subprocess.run(['docker', 'exec', container_name, 'sh', '-c',
                       'echo "#!/bin/bash" > /root/.secret.sh && echo "echo h1dd3n_scr1pt" >> /root/.secret.sh && chmod +x /root/.secret.sh'],
                      capture_output=True)
        
        # Histórico bash com flag
        subprocess.run(['docker', 'exec', container_name, 'sh', '-c',
                       'echo "cd /tmp" > /root/.bash_history && echo "ls -la" >> /root/.bash_history && echo "echo h1st0ry_m4tt3rs" >> /root/.bash_history'],
                      capture_output=True)
        
        # SUID já está configurado no Dockerfile (/usr/bin/find)
        # Apenas garantir que está ativo
        subprocess.run(['docker', 'exec', container_name, 'chmod', 'u+s', '/usr/bin/find'], capture_output=True)
        
        # Crontab em /etc/cron.d/ (como no Dockerfile original)
        subprocess.run(['docker', 'exec', container_name, 'sh', '-c',
                       'mkdir -p /etc/cron.d && echo "# CTF Cron Job" > /etc/cron.d/ctf-cron && echo "# Flag: cr0n_m4st3r" >> /etc/cron.d/ctf-cron && chmod 644 /etc/cron.d/ctf-cron'],
                      capture_output=True)
        
        # Remove README no final (usuário deve descobrir sozinho)
        subprocess.run(['docker', 'exec', container_name, 'rm', '-f', '/root/README.txt'], capture_output=True)
    
    # Salva sessão
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('INSERT OR IGNORE INTO users (user_id, username) VALUES (?, ?)', 
              (user_id, user_id))
    c.execute('''INSERT INTO sessions (session_id, user_id, lab_id, total_challenges, start_time)
                 VALUES (?, ?, ?, ?, ?)''',
              (session_id, user_id, lab_id, len(lab['spec']['challenges']), datetime.now()))
    conn.commit()
    conn.close()
    
    sessions[session_id] = {
        'container_id': container_id,
        'lab_id': lab_id,
        'user_id': user_id,
        'start_time': datetime.now(),
        'completed': set(),
        'score': 0
    }
    
    # Timer auto-destruição (baseado na duração do lab)
    duration_str = lab['metadata'].get('duration', '60m')
    duration_minutes = int(duration_str.replace('m', ''))
    duration_seconds = duration_minutes * 60
    
    def auto_destroy():
        time.sleep(duration_seconds)
        subprocess.run(['docker', 'rm', '-f', f'cyberskills-{session_id}'], capture_output=True)
        if session_id in sessions:
            del sessions[session_id]
    
    threading.Thread(target=auto_destroy, daemon=True).start()
    
    return jsonify({
        'success': True,
        'session': {
            'session_id': session_id,
            'ssh_port': ssh_port,
            'remaining_seconds': duration_seconds
        },
        'lab': {
            'name': lab['metadata']['name'],
            'challenges': lab['spec']['challenges']
        }
    })

@app.route('/api/get-hint', methods=['POST'])
def get_hint():
    data = request.json
    session_id = data.get('session_id')
    challenge_id = data.get('challenge_id')
    hint_index = data.get('hint_index', 0)
    
    if session_id not in sessions:
        return jsonify({'error': 'Sessão não encontrada'}), 404
    
    session = sessions[session_id]
    lab = load_lab(session['lab_id'])
    
    challenge = next((c for c in lab['spec']['challenges'] if c['id'] == challenge_id), None)
    if not challenge or 'hints' not in challenge:
        return jsonify({'error': 'Hint não disponível'}), 404
    
    hints = challenge['hints']
    if hint_index >= len(hints):
        return jsonify({'error': 'Hint não existe'}), 404
    
    hint = hints[hint_index]
    cost = hint.get('cost', 5)
    
    # Deduz pontos
    session['score'] = max(0, session['score'] - cost)
    
    # Atualiza banco
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('UPDATE sessions SET score = score - ? WHERE session_id = ?', (cost, session_id))
    c.execute('UPDATE users SET total_score = total_score - ? WHERE user_id = ?', (cost, session['user_id']))
    conn.commit()
    conn.close()
    
    return jsonify({
        'hint': hint['text'],
        'cost': cost,
        'new_score': session['score']
    })

@app.route('/api/get-writeup', methods=['POST'])
def get_writeup():
    data = request.json
    session_id = data.get('session_id')
    challenge_id = data.get('challenge_id')
    
    if session_id not in sessions:
        return jsonify({'error': 'Sessão não encontrada'}), 404
    
    session = sessions[session_id]
    
    # Só mostra writeup se completou o desafio
    if challenge_id not in session['completed']:
        return jsonify({'error': 'Complete o desafio primeiro'}), 403
    
    lab = load_lab(session['lab_id'])
    challenge = next((c for c in lab['spec']['challenges'] if c['id'] == challenge_id), None)
    
    if not challenge or 'solution' not in challenge:
        return jsonify({'error': 'Writeup não disponível'}), 404
    
    return jsonify({
        'writeup': challenge['solution'],
        'challenge_name': challenge['name']
    })

@app.route('/api/submit-flag', methods=['POST'])
def submit_flag():
    data = request.json
    session_id = data.get('session_id')
    task_id = data.get('task_id')
    flag = data.get('flag', '').strip()
    
    if session_id not in sessions:
        return jsonify({'error': 'Sessão não encontrada'}), 404
    
    session = sessions[session_id]
    lab = load_lab(session['lab_id'])
    
    challenge = next((c for c in lab['spec']['challenges'] if c['id'] == task_id), None)
    if not challenge:
        return jsonify({'correct': False, 'points': 0})
    
    expected = challenge.get('validation', {}).get('flag', '')
    
    if flag == expected:
        if task_id not in session['completed']:
            session['completed'].add(task_id)
            points = challenge.get('points', 10)
            session['score'] += points
            
            # Salva no banco
            conn = sqlite3.connect(DB_FILE)
            c = conn.cursor()
            c.execute('''INSERT INTO challenge_completions 
                        (session_id, challenge_id, challenge_name, points)
                        VALUES (?, ?, ?, ?)''',
                     (session_id, task_id, challenge['name'], points))
            c.execute('UPDATE sessions SET score = score + ?, completed_challenges = completed_challenges + 1 WHERE session_id = ?',
                     (points, session_id))
            c.execute('UPDATE users SET total_score = total_score + ? WHERE user_id = ?',
                     (points, session['user_id']))
            conn.commit()
            conn.close()
            
            return jsonify({'correct': True, 'points': points, 'total_score': session['score']})
        return jsonify({'correct': True, 'points': 0, 'total_score': session['score']})
    
    return jsonify({'correct': False, 'points': 0})

@app.route('/api/stop/<session_id>', methods=['DELETE'])
def stop_lab(session_id):
    if session_id in sessions:
        session = sessions[session_id]
        
        # Atualiza banco com fim da sessão
        conn = sqlite3.connect(DB_FILE)
        c = conn.cursor()
        duration = int((datetime.now() - session['start_time']).total_seconds())
        c.execute('UPDATE sessions SET end_time = ?, duration_seconds = ? WHERE session_id = ?',
                 (datetime.now(), duration, session_id))
        conn.commit()
        conn.close()
        
        container_name = f'cyberskills-{session_id}'
        result = subprocess.run(['docker', 'rm', '-f', container_name], 
                               capture_output=True, text=True)
        del sessions[session_id]
        return jsonify({'success': True, 'removed': result.returncode == 0})
    return jsonify({'success': True, 'message': 'Sessão já removida'})

@app.route('/api/cleanup-user', methods=['POST'])
def cleanup_user():
    """Remove TODOS os containers de um usuário (usado ao recarregar página)"""
    data = request.json
    user_id = data.get('user_id', 'anonymous')
    
    removed_count = 0
    # Remove sessões do usuário no dicionário
    for sid, sess in list(sessions.items()):
        if sess.get('user_id') == user_id:
            container_name = f'cyberskills-{sid}'
            result = subprocess.run(['docker', 'rm', '-f', container_name], 
                                   capture_output=True, text=True)
            if result.returncode == 0:
                removed_count += 1
            del sessions[sid]
    
    return jsonify({
        'success': True, 
        'removed_count': removed_count,
        'message': f'{removed_count} container(s) removido(s)'
    })

@app.route('/api/status/<session_id>', methods=['GET'])
def get_status(session_id):
    if session_id not in sessions:
        return jsonify({'error': 'Sessão não encontrada'}), 404
    return jsonify({'success': True, 'session': sessions[session_id]})

@app.route('/api/create-challenge-user', methods=['POST'])
def create_challenge_user():
    """Cria o usuário desafio final Tryg_Gelt"""
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    
    # Verifica se já existe
    c.execute('SELECT user_id FROM users WHERE user_id = ?', ('Tryg_Gelt',))
    if c.fetchone():
        conn.close()
        return jsonify({'exists': True})
    
    # Cria com pontuação quase completa (falta 1 desafio)
    # Total de pontos: ~840 (soma de todos os labs)
    # Tryg_Gelt terá: 820 pontos (falta 20 pontos)
    c.execute('INSERT INTO users (user_id, username, total_score) VALUES (?, ?, ?)',
              ('Tryg_Gelt', 'Tryg_Gelt', 820))
    conn.commit()
    conn.close()
    return jsonify({'created': True, 'score': 820})

@app.route('/api/scoreboard', methods=['GET'])
def scoreboard():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('''SELECT user_id, username, total_score, 
                 (SELECT COUNT(*) FROM sessions WHERE sessions.user_id = users.user_id) as sessions_count
                 FROM users ORDER BY total_score DESC LIMIT 20''')
    users = [{'user_id': row[0], 'username': row[1], 'score': row[2], 'sessions': row[3]} 
             for row in c.fetchall()]
    conn.close()
    return jsonify({'scoreboard': users})

@app.route('/api/user-progress/<user_id>', methods=['GET'])
def user_progress(user_id):
    """Retorna progresso do usuário para verificar se pode acessar desafio final"""
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('SELECT total_score FROM users WHERE user_id = ?', (user_id,))
    user = c.fetchone()
    conn.close()
    
    if not user:
        return jsonify({'score': 0, 'can_access_final': False})
    
    return jsonify({
        'score': user[0],
        'can_access_final': user[0] >= 800
    })

@app.route('/api/user/<user_id>/stats', methods=['GET'])
def user_stats(user_id):
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    
    # Stats gerais
    c.execute('SELECT total_score FROM users WHERE user_id = ?', (user_id,))
    user = c.fetchone()
    if not user:
        conn.close()
        return jsonify({'error': 'Usuário não encontrado'}), 404
    
    # Sessões
    c.execute('''SELECT session_id, lab_id, score, completed_challenges, total_challenges, 
                 start_time, end_time, duration_seconds
                 FROM sessions WHERE user_id = ? ORDER BY start_time DESC''', (user_id,))
    sessions_data = [{
        'session_id': row[0], 'lab_id': row[1], 'score': row[2],
        'completed': row[3], 'total': row[4], 'start': row[5],
        'end': row[6], 'duration': row[7]
    } for row in c.fetchall()]
    
    # Desafios completados
    c.execute('''SELECT cc.challenge_name, cc.points, cc.completed_at, s.lab_id
                 FROM challenge_completions cc
                 JOIN sessions s ON cc.session_id = s.session_id
                 WHERE s.user_id = ? ORDER BY cc.completed_at DESC''', (user_id,))
    challenges = [{
        'name': row[0], 'points': row[1], 'completed_at': row[2], 'lab': row[3]
    } for row in c.fetchall()]
    
    conn.close()
    return jsonify({
        'user_id': user_id,
        'total_score': user[0],
        'sessions': sessions_data,
        'challenges_completed': challenges
    })

@sock.route('/ws/scoreboard')
def scoreboard_ws(ws):
    """WebSocket para atualizações em tempo real do scoreboard"""
    while True:
        try:
            conn = sqlite3.connect(DB_FILE)
            c = conn.cursor()
            c.execute('''SELECT user_id, username, total_score FROM users ORDER BY total_score DESC LIMIT 20''')
            scoreboard = [{'user_id': row[0], 'username': row[1], 'score': row[2]} for row in c.fetchall()]
            conn.close()
            
            ws.send(json.dumps({'scoreboard': scoreboard}))
            time.sleep(2)  # Atualiza a cada 2 segundos
        except:
            break

@sock.route('/ws/terminal/<session_id>')
def terminal_ws(ws, session_id):
    if session_id not in sessions:
        ws.close()
        return
    
    container_name = f'cyberskills-{session_id}'
    
    # Executa bash no container
    cmd = ['docker', 'exec', '-it', container_name, '/bin/bash']
    master, slave = pty.openpty()
    
    proc = subprocess.Popen(
        cmd,
        stdin=slave,
        stdout=slave,
        stderr=slave,
        preexec_fn=os.setsid
    )
    
    os.close(slave)
    
    def read_output():
        while True:
            try:
                r, _, _ = select.select([master], [], [], 0.1)
                if r:
                    data = os.read(master, 4096)  # Aumentado de 1024 para 4096
                    if data:
                        # Envia em chunks menores para evitar overflow
                        chunk_size = 1024
                        for i in range(0, len(data), chunk_size):
                            ws.send(data[i:i+chunk_size].decode('utf-8', errors='ignore'))
                            time.sleep(0.01)  # Pequeno delay entre chunks
                    else:
                        break
            except:
                break
    
    threading.Thread(target=read_output, daemon=True).start()
    
    while True:
        try:
            data = ws.receive()
            if data:
                os.write(master, data.encode())
        except:
            break
    
    proc.terminate()
    os.close(master)

@app.route('/manifest.json')
def manifest():
    return open('manifest.json').read(), 200, {'Content-Type': 'application/json'}

@app.route('/favicon.ico')
def favicon():
    return '', 204

@app.route('/assets/<path:filename>')
def serve_assets(filename):
    return open(f'assets/{filename}', 'rb').read(), 200, {'Content-Type': 'image/png'}

@app.route('/')
def index():
    return open('web.html').read()

if __name__ == '__main__':
    print("🚀 CYBERSKILLS LAB - Cybersecurity Training Platform")
    print("📡 http://localhost:5000")
    print("👨‍💻 Created by Jhow Magnum")
    print("🔗 https://github.com/Jhow-Magnum/cyberskills-lab")
    app.run(host='0.0.0.0', port=5000, debug=False)
