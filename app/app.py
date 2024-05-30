import pyodbc
from flask import Flask, jsonify, render_template, request, session, redirect, render_template_string
from persistence import Anuncios, Avaliacoes
from werkzeug.security import generate_password_hash, check_password_hash
from persistence.Anuncios import *
from persistence.Avaliacoes import *
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
        cursor.execute(
            'SELECT id, pass_word FROM Utilizador WHERE username = ?', (username,))
        res = cursor.fetchone()
        if res and check_password_hash(res[1], password):
            return res
        else:
            return None


@app.route('/submitRegistration', methods=['POST'])
def register_user():
    nif = request.form['nif']
    nome = request.form['nome']
    endereco = request.form['endereco']
    username = request.form['username']
    password = generate_password_hash(request.form['password'])

    # Check if nome is a string
    if not nome.isalpha():
        return "Nome inválido", 400

    with create_connection() as conn:
        cursor = conn.cursor()
        try:
            cursor.execute("INSERT INTO Utilizador(nif, nome, endereco, username, pass_word) VALUES (?, ?, ?, ?, ?)",
                        (nif, nome, endereco, username, password))
            conn.commit()
        except pyodbc.Error as ex:
            sqlstate = ex.args[0]
            if sqlstate == '23000':
                return 'Tente um diferente username ou nif', 400

    return jsonify({'status': 200, 'message': 'Registration successful'}), 200


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


@app.route('/compra')
def compra():
    if session['auth']:
        return render_template('compra.html')
    else:
        return redirect('/')


@ app.route('/vender')
def vender():
    if session['auth']:
        return render_template('vender.html')
    else:
        return redirect('/')
    
@app.route('/avaliacoes')
def avaliacoes():
    if session['auth']:
        return render_template('avaliacoes.html')
    else:
        return redirect('/')



@app.route('/register')
def register():
    return render_template('register.html')


@app.route('/perfil')
def perfil():
    if session['auth']:
        with create_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM Utilizador WHERE id=?",
                           (session['userID'],))
            user = cursor.fetchone()
        return render_template('perfil.html', user=user)
    else:
        return redirect('/')


@app.route('/submitUserInfo', methods=['POST'])
def submitUserInfo():
    id = session['userID']
    nif = request.form['nif']
    nome = request.form['nome']
    endereco = request.form['endereco']
    username = request.form['username']

    with create_connection() as conn:
        cursor = conn.cursor()
        try:
            cursor.execute("UPDATE Utilizador SET nif=?, nome=?, endereco=?, username=? WHERE id=?", (nif, nome, endereco, username, id))
            conn.commit()
            return redirect('/perfil')
        except pyodbc.Error as ex:
            sqlstate = ex.args[0]
            if sqlstate == '23000':
                return 'Tente um diferente username ou nif', 400

    return

#user--
@app.route('/anuncios_user')
def anuncions_user():
    all_anuncios = Anuncios.list_user_anuncios(session['userID'])
    if all_anuncios is None:
        return jsonify([])
    anuncios_dict = [anuncio._asdict() for anuncio in all_anuncios]
    return jsonify(anuncios_dict)

@app.route('/list_anuncios_automovel_User', methods=['GET'])
def get_anuncios_automovel_User():
    anuncios = Anuncios.list_user_anuncios(session['userID'], 'automovel')
    anuncios_dict = [anuncio._asdict() for anuncio in anuncios]
    return jsonify(anuncios_dict)


@app.route('/list_anuncios_motociclo_User', methods=['GET'])
def get_anuncios_motociclo_User():
    anuncios = Anuncios.list_user_anuncios(session['userID'], 'motociclo')
    anuncios_dict = [anuncio._asdict() for anuncio in anuncios]
    return jsonify(anuncios_dict)


@app.route('/compras_user')
def compras_user():
    all_compras = Anuncios.list_user_compras(session['userID'])
    if all_compras is None:
        return jsonify([])
    compras_dict = [compra._asdict() for compra in all_compras]
    return jsonify(compras_dict)


@app.route('/compras_user_automovel')
def compras_user_automovel():
    compras = Anuncios.list_user_compras(session['userID'], 'automovel')
    if compras is None:
        return jsonify([])
    compras_dict = [compra._asdict() for compra in compras]
    return jsonify(compras_dict)


@app.route('/compras_user_motociclo')
def compras_user_motociclo():
    compras = Anuncios.list_user_compras(session['userID'], 'motociclo')
    print(compras)
    if compras is None:
        return jsonify([])
    compras_dict = [compra._asdict() for compra in compras]
    return jsonify(compras_dict)


#anuncios geral--
@app.route('/list_anuncios_automovel', methods=['GET'])
def get_anuncios_automovel():
    anuncios = Anuncios.list_anuncios_automovel()
    anuncios_dict = [anuncio._asdict() for anuncio in anuncios]
    return jsonify(anuncios_dict)


@app.route('/list_anuncios_motociclo', methods=['GET'])
def get_anuncios_motociclo():
    anuncios = Anuncios.list_anuncios_motociclo()
    anuncios_dict = [anuncio._asdict() for anuncio in anuncios]
    return jsonify(anuncios_dict)


@app.route('/list_all_anuncios', methods=['GET'])
def get_all_anuncios():
    anuncios_automovel = Anuncios.list_anuncios_automovel()
    anuncios_motociclo = Anuncios.list_anuncios_motociclo()
    all_anuncios = anuncios_automovel + anuncios_motociclo
    all_anuncios_dict = [anuncio._asdict() for anuncio in all_anuncios]
    return jsonify(all_anuncios_dict)


@ app.route('/filter_anuncios', methods=['POST'])
def filter_anuncios():
    data = request.get_json()
    print(data)
    tipo = data.get('tipo', '') if data.get('tipo', '') != '' else None
    marca = data.get('marca', '') if data.get('marca', '') != '' else None
    segmento = data.get('segmento', '') if data.get(
        'segmento', '') != '' else None
    ano = int(data.get('ano', '')) if data.get('ano', '') != '' else None
    km = int(data.get('km', '')) if data.get('km', '') != '' else None
    combustivel = data.get('combustivel', '') if data.get(
        'combustivel', '') != '' else None
    estado = data.get('estado', '') if data.get('estado', '') != '' else None
    tipo_caixa = data.get('tipo_caixa', '') if data.get(
        'tipo_caixa', '') != '' else None
    cavalos = int(data.get('cavalos', '')) if data.get(
        'cavalos', '') != '' else None
    num_portas = int(data.get('num_portas', '')) if data.get(
        'num_portas', '') != '' else None
    num_lugares = int(data.get('num_lugares', '')) if data.get(
        'num_lugares', '') != '' else None
    cilindrada = int(data.get('cilindrada', '')) if data.get(
        'cilindrada', '') != '' else None
    preco = int(data.get('preco', '')) if data.get('preco', '') != '' else None
    modelo = data.get('modelo', '') if data.get('modelo', '') != '' else None

    cursor = Anuncios.filter_anuncios(tipo, marca, segmento, ano, km,
                                      combustivel, estado, tipo_caixa,
                                      cavalos, num_portas, num_lugares, cilindrada,
                                      preco, modelo)
    anuncios = list(cursor)
    anuncios_dict = [anuncio._asdict() for anuncio in anuncios]
    return jsonify(anuncios_dict)


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
    try:
        Anuncios.comprarAnuncio(numero, id_comprador)
    except pyodbc.ProgrammingError as e:
        if 'Nao pode comprar um anuncio seu' in str(e):
            return f"""<div style="color: red;">Nao pode comprar um anuncio seu.</div>"""
        elif 'Veiculo ja comprado' in str(e):
            return f"""<div style="color: red;">Veiculo ja foi Comprado.</div>"""

    return f"""
        <form id="avaliacaoForm" action="/submitAvaliacao/{numero}" method="post">
            <label for="avaliacao">Avaliação:</label>
            <input type="number" id="avaliacao" name="avaliacao" required>
            <label for="comentario">Comentário:</label>
            <input type="text" id="comentario" name="comentario" required>
            <button type="submit">Avaliar</button>
        </form>
    """

@app.route('/checkifowner/<num_anu>', methods=['POST'])
def checkifowner(num_anu):
    user = session['userID']
    check = Anuncios.checkifowner(num_anu, user)
    if check == 1:
        return f"""
            <form id="removeAnuncioForm" class="center-form" action="/removeAnuncio/{num_anu}" method="post">
                <button type="submit">Remover Anuncio</button>
            </form>
        """
    else:
        return
    
@app.route('/removeAnuncio/<num_anu>', methods=['POST'])
def removeAnuncio(num_anu):
    try:
        Anuncios.removeAnuncio(num_anu)
    except pyodbc.ProgrammingError as e:
        if 'Cannot delete Anuncio_venda because it is associated with a Compra.' in str(e):
            return f"""<div style="color: red;">Veiculo ja foi Comprado.</div>"""
    return redirect('/anuncios')
    




@app.route('/submitAvaliacao/<numero>', methods=['POST'])
def submitAvaliacao(numero):
    avaliacao = request.form['avaliacao']
    comentario = request.form['comentario']
    Anuncios.submitAvaliacao(numero, avaliacao, comentario)
    return redirect('/perfil')

@app.route('/checkforAvaliacao/<num_venda>', methods=['POST'])
def checkforAvaliacao(num_venda):
    user = session['userID']
    aval_status = Avaliacoes.checkforAvaliacao(num_venda, user)
    if aval_status == 0:
        return f"""
                <form id="avaliacaoForm" action="/submitAvaliacao/{num_venda}" method="post">
                    <label for="avaliacao">Avaliação:</label>
                    <input type="number" id="avaliacao" name="avaliacao" required>
                    <label for="comentario">Comentário:</label>
                    <input type="text" id="comentario" name="comentario" required>
                    <button type="submit">Avaliar</button>
                </form>
            """
    else:
        return
    

@app.route('/listAvaliacoes', methods=['GET'])
def listAvaliacoes():
    avaliacoes = Avaliacoes.listAvaliacoes()
    avaliacoes_dict = [avaliacao._asdict() for avaliacao in avaliacoes]
    print(avaliacoes_dict)
    return jsonify(avaliacoes_dict)


@app.route('/filterAvaliacoes', methods=['POST'])
def filterAvaliacoes():
    data = request.get_json()
    tipo = data.get('tipo', '') if data.get('tipo', '') != '' else None
    marca = data.get('marca', '') if data.get('marca', '') != '' else None
    modelo = data.get('modelo', '') if data.get('modelo', '') != '' else None
    sort = data.get('sort', '') if data.get('sort', '') != '' else None

    avaliacoes = Avaliacoes.filterAvaliacoes(tipo, marca, modelo, sort)
    avaliacoes_dict = [avaliacao._asdict() for avaliacao in avaliacoes]
    return jsonify(avaliacoes_dict)

if __name__ == '__main__':
    app.run(debug=True)
