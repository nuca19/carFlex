import pyodbc
from flask import Flask, jsonify, render_template, request, session, redirect, render_template_string
from persistence import Anuncios
from persistence.Anuncios import *

app = Flask(__name__)

app.secret_key = '12secr34etkey56'  # Set a secret key
session = {}
session['auth']=False

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
        cursor.execute('SELECT id FROM Utilizador WHERE username = ? AND pass_word = ?', (username, password))
        res = cursor.fetchone()
        print(res)
        return res


@app.route('/logout')
def logout():
    if session['auth']:
        session['auth']=False
        session.pop('userID', None)
    return redirect('/')

@app.route('/')
def index():
    if session['auth']:
        return render_template('index.html')
    else:
        return render_template('login.html')

@app.route('/comprar')
def comprar():
    if session['auth']:
        return render_template('comprar.html')
    else:
        return redirect('/')

@app.route('/vender')
def vender():
    if session['auth']:
        return render_template('vender.html')
    else:
        return redirect('/')

@app.route('/sobre')
def sobre():
    return render_template('sobre.html')




@app.route('/list_anuncios', methods=['GET'])
def get_anuncios():
    anuncios = Anuncios.list_anuncios()
    anuncios_dict = [anuncio._asdict() for anuncio in anuncios]
    return jsonify(anuncios_dict)


@app.route('/test_connection_local', methods=['POST'])
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


@app.route('/cars', methods=['POST'])
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


@app.route('/submitAnuncioAutomovel', methods=['POST'])
def submitVenda():
# Extract Automovel data
    automovel_details = {field: request.form.get(field) for field in Automovel._fields}
    automovel = Automovel(**automovel_details)

    veiculo_details = {field: request.form.get(field) for field in Veiculo._fields}
    veiculo = Veiculo(**veiculo_details)

    preco = Decimal(request.form.get('preco'))
    print(session)
    id_vendedor =  session['userID']

    Anuncios.createAnuncioAutomovel(automovel, veiculo, preco, id_vendedor)
    return redirect('/comprar')


@app.route('/submitAnuncioMotociclo', methods=['POST'])
def submitVendaMotociclo():
    # Extract Motociclo data
    motociclo_details = {field: request.form.get(field) for field in Motociclo._fields}
    motociclo = Motociclo(**motociclo_details)

    veiculo_details = {field: request.form.get(field) for field in Veiculo._fields}
    veiculo = Veiculo(**veiculo_details)

    preco = Decimal(request.form.get('preco'))
    print(session)
    id_vendedor =  session['userID']

    Anuncios.createAnuncioMotociclo(motociclo, veiculo, preco, id_vendedor)
    return redirect('/comprar')

@app.route('/comprar/<codigo>', methods=['GET'])
def get_anuncio(codigo):
    anuncio = Anuncios.get_anuncio(codigo)
    if anuncio is None:
        return redirect('/comprar')
    return render_template('anuncio.html', anuncio=anuncio._asdict())



def create_connection_local(db_name):
    DRIVER_NAME = 'SQL Server Native Client 11.0'
    SERVER_NAME = 'LAPTOP-PQBKH6FT'
    connection_string = f"""DRIVER={{{DRIVER_NAME}}};SERVER={SERVER_NAME};DATABASE={db_name};Trusted_Connection=yes;"""

    conn = pyodbc.connect(connection_string)
    return conn


if __name__ == '__main__':
    app.run(debug=True)
