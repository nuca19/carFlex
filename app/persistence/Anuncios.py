from persistence.session import create_connection
from pyodbc import IntegrityError
import random
from decimal import Decimal
from typing import NamedTuple
import string
import random
import pyodbc


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


class CompraAutomovelTotal(NamedTuple):
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
    num_compra: int
    data_compra: str
    avaliacao: str
    comentario: str


class CompraMotocicloTotal(NamedTuple):
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
    num_compra: int
    data_compra: str
    avaliacao: str
    comentario: str


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


def list_user_anuncios(id_vendedor, tipo=None):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """  EXEC anuncioveiculototalByUser @id_vendedor =  ?""", (id_vendedor,))
        result = []
        while True:
            try:
                rows = cursor.fetchall()
            except pyodbc.ProgrammingError as e:
                return None
            if rows:
                result.extend(rows)
            if cursor.nextset():
                continue
            else:
                break
        if tipo == 'automovel':
            return [AnuncioAutomovelTotal(*row) for row in result if row[8] == 'automovel']
        elif tipo == 'motociclo':
            return [AnuncioMotocicloTotal(*row) for row in result if row[8] == 'motociclo']
        else:
            return [AnuncioAutomovelTotal(*row) if row[8] == 'automovel' else AnuncioMotocicloTotal(*row) for row in result]

def list_user_compras(id_comprador, tipo=None):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """  EXEC ComprasByUser @id_comprador =  ?""", (id_comprador,))
        result = []
        while True:
            try:
                rows = cursor.fetchall()
            except pyodbc.ProgrammingError as e:
                return None
            if rows:
                result.extend(rows)
            if cursor.nextset():
                continue
            else:
                break
        if tipo == 'automovel':
            return [AnuncioAutomovelTotal(*row) for row in result if row[8] == 'automovel']
        elif tipo == 'motociclo':
            return [AnuncioMotocicloTotal(*row) for row in result if row[8] == 'motociclo']
        else:
            return [AnuncioAutomovelTotal(*row) if row[8] == 'automovel' else AnuncioMotocicloTotal(*row) for row in result]



def createAnuncioAutomovel(automovel: Automovel, veiculo: Veiculo, preco, id_vendedor):
    with create_connection() as conn:
        cursor = conn.cursor()
        while True: #generate codigo not in use
            codigo = generate_codigo()
            cursor.execute("SELECT * FROM Anuncio_venda WHERE codigo_veiculo = ?", (codigo,))
            if cursor.fetchone() is None:
                break

        params = (codigo, *veiculo, *automovel, preco, id_vendedor)
        cursor.execute("EXEC CreateAnuncioAutomovel @codigo = ?, @ano = ?, @marca = ?, @modelo = ?, @km = ?, @combustivel = ?, @estado = ?, @tipo_caixa = ?, @segmento = ?, @num_portas = ?, @num_lugares = ?, @cavalos = ?, @preco = ?, @id_vendedor = ?", params)
        return


def createAnuncioMotociclo(motociclo: Motociclo, veiculo: Veiculo, preco, id_vendedor):
    with create_connection() as conn:
        cursor = conn.cursor()
        while True: #generate codigo not in use
            codigo = generate_codigo()
            cursor.execute("SELECT * FROM Anuncio_venda WHERE codigo_veiculo = ?", (codigo,))
            if cursor.fetchone() is None:
                break
            
        cursor.execute("SELECT * FROM Anuncio_venda WHERE codigo_veiculo = ?", (codigo,))
        params = (codigo, *veiculo, *motociclo, preco, id_vendedor)
        cursor.execute("EXEC CreateAnuncioMotociclo @codigo = ?, @ano = ?, @marca = ?, @modelo = ?, @km = ?, @combustivel = ?, @estado = ?, @tipo_caixa = ?, @segmento = ?, @cilindrada = ?, @preco = ?, @id_vendedor = ?", params)
        return


def get_anuncio(codigo_veiculo):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """EXEC anuncioveiculototal @codigo_veiculo = ? """, (codigo_veiculo,))
        result = cursor.fetchone()
        print(result)
        tipo = result[8]
        if result[-4] is None: #numero compra
            result = result[:-4]
            if tipo == 'automovel':
                return AnuncioAutomovelTotal(*result)	
            elif tipo == 'motociclo':
                return AnuncioMotocicloTotal(*result)
        else:
            if tipo == 'automovel':
                return CompraAutomovelTotal(*result)
            elif tipo == 'motociclo':
                return CompraMotocicloTotal(*result)
            else:
                return None



def comprarAnuncio(numero, id_comprador):
    with create_connection() as conn:
        num_venda = numero
        cursor = conn.cursor()
        cursor.execute(f"""
            INSERT INTO Compra 
            VALUES (?, GETDATE(), ?)
        """, (num_venda, id_comprador))
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
            VALUES (?, ?, ?)
        """, (num_compra, avaliacao, comentario))
        conn.commit()
        return


def filter_anuncios(tipo, marca, segmento, ano, km, combustivel, estado, tipo_caixa, cavalos, num_portas, num_lugares, cilindrada, preco, modelo):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(f"""
            EXEC filter_anuncios @tipo = ?, @marca = ?, @segmento = ?, @ano = ?, @km = ?, @combustivel = ?, @estado = ?, @tipo_caixa = ?, @cavalos = ?, @num_portas = ?, @num_lugares = ?, @cilindrada = ?, @preco = ?, @modelo = ?
        """, (tipo, marca, segmento, ano, km, combustivel, estado, tipo_caixa, cavalos, num_portas, num_lugares, cilindrada, preco, modelo))

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

def checkifowner(num_anu, user): #check if user on page is the owner of the anuncio
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''SELECT * FROM Anuncio_venda WHERE numero = ? AND id_vendedor = ?''', (num_anu, user))
        result = cursor.fetchone()
        if result is None:
            return 0
        return 1
    
def removeAnuncio(num_anu):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''DELETE FROM Anuncio_venda WHERE numero = ?''', (num_anu,))
        conn.commit()
        return

def generate_codigo(length=8):
    chars = string.ascii_letters + string.digits
    codigo = ''.join(random.choice(chars) for _ in range(length))
    return codigo


def generate_5dig():
    return random.randint(10000, 99999)
