import random
import string
from typing import NamedTuple
from decimal import Decimal
import random
import string
from pyodbc import IntegrityError
from persistence.session import create_connection


class AnuncioVenda(NamedTuple):
    numero: int
    data_venda: str
    preco: float
    codigo_veiculo: int
    id_vendedor: int


class Motociclo(NamedTuple):
    segmento: str
    cilindrada: int


class Automovel(NamedTuple):
    segmento: str
    num_portas: int
    num_lugares: int
    cavalos: int


class Veiculo(NamedTuple):
    ano: int
    marca: str
    modelo: str
    km: int
    combustivel: str
    estado: str
    tipo_caixa: str


class AnuncioVeiculo2(NamedTuple):
    codigo_veiculo: str
    numero: int
    marca: str
    modelo: str
    ano: int
    km: int
    preco: Decimal
    tipo: str


class AnuncioAutomovelTotal(NamedTuple):
    codigo_veiculo: str
    numero: int
    marca: str
    modelo: str
    ano: int
    segmento: str
    km: int
    preco: Decimal
    tipo: str
    num_portas: int
    num_lugares: int
    cavalos: int
    combustivel: str
    estado: str
    tipo_caixa: str


class AnuncioMotocicloTotal(NamedTuple):
    codigo_veiculo: str
    numero: int
    marca: str
    modelo: str
    ano: int
    segmento: str
    km: int
    preco: Decimal
    tipo: str
    cilindrada: int
    combustivel: str
    estado: str
    tipo_caixa: str


def list_user_anuncios(id_vendedor):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """  EXEC anuncioveiculototalByUser @id_vendedor =  ?""", (id_vendedor,))
        result = []
        while True:
            rows = cursor.fetchall()
            if rows:
                result.extend(rows)
            if cursor.nextset():
                continue
            else:
                break
        return [AnuncioAutomovelTotal(*row) if row[8] == 'automovel' else AnuncioMotocicloTotal(*row) for row in result]


def list_user_compras(id_comprador):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("EXEC ComprasByUser @id_comprador = ?", (id_comprador,))
        result = []
        while True:
            rows = cursor.fetchall()
            if rows:
                result.extend(rows)
            if cursor.nextset():
                continue
            else:
                break
        return [AnuncioAutomovelTotal(*row) if row[8] == 'automovel' else AnuncioMotocicloTotal(*row) for row in result]


def list_user_compras_automovel(id_comprador):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """  EXEC ComprasByUser @id_comprador =  ?""", (id_comprador,))
        result = []
        while True:
            rows = cursor.fetchall()
            if rows:
                result.extend(rows)
            if cursor.nextset():
                continue
            else:
                break
        return [AnuncioAutomovelTotal(*row) for row in result if row[8] == 'automovel']


def list_user_compras_motociclo(id_comprador):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """  EXEC ComprasByUser @id_comprador =  ?""", (id_comprador,))
        result = []
        while True:
            rows = cursor.fetchall()
            if rows:
                result.extend(rows)
            if cursor.nextset():
                continue
            else:
                break
        return [AnuncioMotocicloTotal(*row) for row in result if row[8] == 'motociclo']


def list_anuncios_automovel():
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("""EXEC anuncios_automovel;""")
        return [AnuncioAutomovelTotal(*row) for row in cursor.fetchall()]


def list_anuncios_motociclo():
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("""EXEC anuncios_motociclo;""")
        return [AnuncioMotocicloTotal(*row) for row in cursor.fetchall()]


def list_anuncios_automovel_User(id_vendedor):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """  EXEC anuncioveiculototalByUser @id_vendedor =  ?""", (id_vendedor,))
        result = []
        while True:
            rows = cursor.fetchall()
            if rows:
                result.extend(rows)
            if cursor.nextset():
                continue
            else:
                break
        return [AnuncioAutomovelTotal(*row) for row in result if row[8] == 'automovel']


def list_anuncios_motociclo_User(id_vendedor):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """  EXEC anuncioveiculototalByUser @id_vendedor =  ?""", (id_vendedor,))
        result = []
        while True:
            rows = cursor.fetchall()
            if rows:
                result.extend(rows)
            if cursor.nextset():
                continue
            else:
                break
        return [AnuncioMotocicloTotal(*row) for row in result if row[8] == 'motociclo']


def createAnuncioAutomovel(automovel: Automovel, veiculo: Veiculo, preco, id_vendedor):
    with create_connection() as conn:
        codigo = generate_codigo()
        numero = generate_5dig()
        cursor = conn.cursor()
        cursor.execute(f"""
                INSERT INTO Veiculo (codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa, tipo)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (codigo, *veiculo, 'automovel'))

        cursor.execute(f"""
                INSERT INTO Automovel (codigo, segmento, num_portas, num_lugares, cavalos)
                VALUES (?, ?, ?, ?, ?)
            """, (codigo, *automovel))

        cursor.execute(f"""
                INSERT INTO Anuncio_venda (numero, data_venda, preco, codigo_veiculo, id_vendedor)
                VALUES (?, GETDATE(), ?, ?, ?)
            """, (numero, preco, codigo, id_vendedor))

        conn.commit()
        return


def createAnuncioMotociclo(motociclo: Motociclo, veiculo: Veiculo, preco, id_vendedor):
    with create_connection() as conn:
        codigo = generate_codigo()
        numero = generate_5dig()
        cursor = conn.cursor()
        cursor.execute(f"""
            INSERT INTO Veiculo (codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa, tipo)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (codigo, *veiculo, 'motociclo'))

        cursor.execute(f"""
            INSERT INTO Motociclo (codigo, segmento, cilindrada)
            VALUES (?, ?, ?)
        """, (codigo, *motociclo))

        cursor.execute(f"""
            INSERT INTO Anuncio_venda (numero, data_venda, preco, codigo_veiculo, id_vendedor)
            VALUES (?, GETDATE(), ?, ?, ?)
        """, (numero, preco, codigo, id_vendedor))
        conn.commit()
        return


def get_anuncio(codigo_veiculo):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """EXEC anuncioveiculototal @codigo_veiculo = ? """, (codigo_veiculo,))
        result = cursor.fetchone()
        tipo = result[8]
        if tipo == 'automovel':
            return AnuncioAutomovelTotal(*result)
        elif tipo == 'motociclo':
            return AnuncioMotocicloTotal(*result)
        else:
            return None


def comprarAnuncio(numero, id_comprador):
    with create_connection() as conn:
        num_compra = generate_5dig()
        num_venda = numero
        cursor = conn.cursor()
        cursor.execute(f"""
            INSERT INTO Compra 
            VALUES (?, ?, GETDATE(), ?)
        """, (num_compra, num_venda, id_comprador))
        conn.commit()
        return


def submitAvaliacao(numero, avaliacao, comentario):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(f"""
            SELECT numero FROM Compra WHERE num_venda = ?
        """, (numero,))
        row = cursor.fetchone()
        if row is None:
            return "No matching num_compra found for num_venda", 400
        num_compra = row[0]
        # Insert into Avaliacao
        cursor.execute(f"""
            INSERT INTO Avaliacao 
            VALUES (?, ?, ?, ?)
        """, (generate_5dig(), num_compra, avaliacao, comentario))
        conn.commit()
        return


def filter_anuncios(tipo, marca, segmento, ano, km, combustivel, estado, tipo_caixa, cavalos, num_portas, num_lugares, cilindrada):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(f"""
            EXEC filter_anuncios @tipo = ?, @marca = ?, @segmento = ?, @ano = ?, @km = ?, @combustivel = ?, @estado = ?, @tipo_caixa = ?, @cavalos = ?, @num_portas = ?, @num_lugares = ?, @cilindrada = ?
        """, (tipo, marca, segmento, ano, km, combustivel, estado, tipo_caixa, cavalos, num_portas, num_lugares, cilindrada))

        result = []
        while True:
            rows = cursor.fetchall()
            if rows:
                result.extend(rows)
            if cursor.nextset():
                continue
            else:
                break

        return [AnuncioAutomovelTotal(*row) if row[8] == 'automovel' else AnuncioMotocicloTotal(*row) for row in result]


def generate_codigo(length=8):
    chars = string.ascii_letters + string.digits
    codigo = ''.join(random.choice(chars) for _ in range(length))
    return codigo


def generate_5dig():
    return random.randint(10000, 99999)
