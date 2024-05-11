import pyodbc
from flask import Flask, jsonify, render_template, request, render_template_string
from persistence import Anuncios

app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/comprar')
def comprar():
    return render_template('comprar.html')

@app.route('/list_anuncios', methods=['GET'])
def get_anuncios():
    anuncios = Anuncios.list_anuncios()
    anuncios_dict = [anuncio._asdict() for anuncio in anuncios]  # Convert to dictionaries
    return jsonify(anuncios_dict)  # Convert to JSON and return


@app.route('/test_connection_local', methods=['POST'])
def test_connection_local():
    # Get form data

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


def create_connection_local(db_name):
    DRIVER_NAME = 'SQL Server Native Client 11.0'
    SERVER_NAME = 'LAPTOP-PQBKH6FT'
    connection_string = f"""DRIVER={{{DRIVER_NAME}}};SERVER={SERVER_NAME};DATABASE={db_name};Trusted_Connection=yes;"""

    conn = pyodbc.connect(connection_string)
    return conn


if __name__ == '__main__':
    app.run(debug=True)
