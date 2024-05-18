import pyodbc
from flask import Flask, jsonify, render_template, request, session, redirect, render_template_string
from persistence import Anuncios
from werkzeug.security import generate_password_hash, check_password_hash
from persistence.Anuncios import *

import sqlite3
import random

app = Flask(__name__)

app.secret_key = '12secr34etkey56'  # Set a secret key
session = {}
session['auth'] = False


@app.route('/submitLogin', methods=['POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = validate_user(username, password)
        if user:
            session['auth'] = True
            session['userID'] = user[0]
        else:
            return render_template('login.html')
    return redirect('/')


def validate_user(username, password):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('SELECT id, pass_word FROM Utilizador WHERE username = ?', (username,))
        res = cursor.fetchone()
        if res and check_password_hash(res[1], password):
            return res
        else:
            return None


@app.route('/submitRegistration', methods=['POST'])
def register_user():
    id = random.randint(100, 999)
    nif = request.form['nif']
    nome = request.form['nome']
    endereco = request.form['endereco']
    username = request.form['username']
    password = generate_password_hash(request.form['password'])

    # Check if nome is a string
    if not isinstance(nome, str):
        return "Name must be a string", 400

    # Check if nif is 9 characters long
    if len(nif) != 9:
        return "NIF must be 9 characters long", 400

    with create_connection() as conn:
        cursor = conn.cursor()

        # Check if the generated id already exists
        cursor.execute("SELECT id FROM Utilizador WHERE id=?", (id,))
        result = cursor.fetchone()
        while result is not None:
            id = random.randint(100, 999)
            cursor.execute("SELECT id FROM Utilizador WHERE id=?", (id,))
            result = cursor.fetchone()

        # Check if the username already exists
        cursor.execute(
            "SELECT username FROM Utilizador WHERE username=?", (username,))
        if cursor.fetchone() is not None:
            return "Username already exists", 400

        # Check if the nif already exists
        cursor.execute("SELECT nif FROM Utilizador WHERE nif=?", (nif,))
        if cursor.fetchone() is not None:
            return "NIF already exists", 400

        cursor.execute("INSERT INTO Utilizador(id, nif, nome, endereco, username, pass_word) VALUES (?, ?, ?, ?, ?, ?)",
                       (id, nif, nome, endereco, username, password))

        conn.commit()

    return redirect('/')


@ app.route('/logout')
def logout():
    if session['auth']:
        session['auth'] = False
        session.pop('userID', None)
    return redirect('/')


@ app.route('/')
def index():
    if session['auth']:
        return render_template('index.html')
    else:
        return render_template('login.html')


@ app.route('/anuncios')
def anuncios():
    if session['auth']:
        return render_template('anuncios.html')
    else:
        return redirect('/')


@ app.route('/vender')
def vender():
    if session['auth']:
        return render_template('vender.html')
    else:
        return redirect('/')


@app.route('/register')
def register():
    return render_template('register.html')


@ app.route('/sobre')
def sobre():
    return render_template('sobre.html')


@ app.route('/list_anuncios', methods=['GET'])
def get_anuncios():
    anuncios = Anuncios.list_anuncios()
    anuncios_dict = [anuncio._asdict() for anuncio in anuncios]
    return jsonify(anuncios_dict)


@ app.route('/test_connection_local', methods=['POST'])
def test_connection_local():
    db_name = request.form['database_name']
    print("testlocal")

    try:
        with create_connection_local(db_name) as conn:
            print("success")
            message = "Connection successful!"
            colour = "green"
    except pyodbc.Error as e:
        print("error")
        message = f"Connection failed: {str(e)}"
        colour = "red"

    return f'<label style="color: {colour};">{message}</label>'


@ app.route('/cars', methods=['POST'])
def print_cars():
    # Get form data
    db_name = request.form['database_name']

    # Fetch the hello table
    with create_connection_local(db_name) as conn:
        cursor = conn.cursor()
        cursor.execute("""
            SELECT marca, modelo, cavalos
            FROM Veiculo
            JOIN Automovel ON Veiculo.automovel_codigo = Automovel.codigo
        """)
        messages = list(cursor)

    return render_template_string("""
        <h1>cars</h1>
        {% for x in messages %}
        <p>{{ x }}</p>
        {% endfor %}
        """, messages=messages)


@ app.route('/submitAnuncioAutomovel', methods=['POST'])
def submitVenda():
    # Extract Automovel data
    automovel_details = {field: request.form.get(
        field) for field in Automovel._fields}
    automovel = Automovel(**automovel_details)

    veiculo_details = {field: request.form.get(
        field) for field in Veiculo._fields}
    veiculo = Veiculo(**veiculo_details)

    preco = Decimal(request.form.get('preco'))
    print(session)
    id_vendedor = session['userID']

    Anuncios.createAnuncioAutomovel(automovel, veiculo, preco, id_vendedor)
    return redirect('/anuncios')


@ app.route('/submitAnuncioMotociclo', methods=['POST'])
def submitVendaMotociclo():
    # Extract Motociclo data
    motociclo_details = {field: request.form.get(
        field) for field in Motociclo._fields}
    motociclo = Motociclo(**motociclo_details)

    veiculo_details = {field: request.form.get(
        field) for field in Veiculo._fields}
    veiculo = Veiculo(**veiculo_details)

    preco = Decimal(request.form.get('preco'))
    print(session)
    id_vendedor = session['userID']

    Anuncios.createAnuncioMotociclo(motociclo, veiculo, preco, id_vendedor)
    return redirect('/anuncios')


@ app.route('/anuncios/<codigo>', methods=['GET'])
def get_anuncio(codigo):
    anuncio = Anuncios.get_anuncio(codigo)
    print(anuncio)
    if anuncio is None:
        return redirect('/anuncios')
    return render_template('anuncio.html', anuncio=anuncio._asdict())

@app.route('/comprarAnuncio/<numero>', methods=['POST'])
def comprarAnuncio(numero):
    id_comprador = session['userID']
    print(numero)
    numero = int(numero)
    Anuncios.comprarAnuncio(numero, id_comprador)
    return redirect('/anuncios')

@app.route('/submitAvaliacao/<numero>', methods=['POST'])
def submitAvaliacao(numero):
    avaliacao = request.form['avaliacao']
    comentario = request.form['comentario']
    Anuncios.submitAvaliacao(numero, avaliacao, comentario)
    return redirect('/anuncios')

def create_connection_local(db_name):
    DRIVER_NAME = 'SQL Server Native Client 11.0'
    SERVER_NAME = 'LAPTOP-PQBKH6FT'
    connection_string = f"""DRIVER={{{DRIVER_NAME}}};SERVER={SERVER_NAME};DATABASE={db_name};Trusted_Connection=yes;"""

    conn = pyodbc.connect(connection_string)
    return conn


if __name__ == '__main__':
    app.run(debug=True)
