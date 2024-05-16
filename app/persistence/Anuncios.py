import random
import string
from typing import NamedTuple
from decimal import Decimal
import random
import string
from pyodbc import IntegrityError
from persistence.session import create_connection



class Motociclo(NamedTuple):
    codigo: int
    segmento: str
    cilindrada: int

class Automovel(NamedTuple):
    codigo: int
    segmento: str
    num_portas: int
    num_lugares: int
    cavalos: int

class Veiculo(NamedTuple):
    codigo: int
    ano: int
    marca: str
    modelo: str
    km: int
    combustivel: str
    estado: str
    tipo_caixa: str

class AnuncioVenda(NamedTuple):
    numero: int
    data_venda: str
    preco: float
    codigo_veiculo: int
    id_vendedor: int



class AnuncioVeiculo(NamedTuple):
    codigo_veiculo: str
    numero: int
    marca: str
    modelo: str
    km: int
    preco: Decimal



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

class AnuncioVendaForm(NamedTuple):
    preco: Decimal


def list_anuncios():
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("""(
                            SELECT Veiculo.codigo, numero, marca, modelo, km, preco
                            FROM Anuncio_venda 
                            JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo) 
                            ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
                        )
                        UNION ALL
                        (
                            SELECT Veiculo.codigo, numero, marca, modelo, km, preco
                            FROM Anuncio_venda 
                            JOIN (Veiculo JOIN Motociclo ON Veiculo.codigo=Motociclo.codigo) 
                            ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
                        )""")
        return [AnuncioVeiculo(*row) for row in cursor.fetchall()]
    
def createAnuncioAutomovel(automovel: Automovel, veiculo: Veiculo, preco, id_vendedor):
    with create_connection() as conn:
            codigo = generate_codigo()
            numero = generate_5dig()
            cursor = conn.cursor()
            cursor.execute(f"""
                INSERT INTO Veiculo (codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """, (codigo, *veiculo))

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
                INSERT INTO Veiculo (codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """, (codigo, *veiculo))

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
        cursor.execute(f"""
            SELECT numero, data_venda, preco, codigo_veiculo, id_vendedor
            FROM Anuncio_venda
            WHERE codigo_veiculo = ?
        """, (codigo_veiculo,))
        res = cursor.fetchone()
        if res is None:
            return None
        return AnuncioVenda(*res)


def generate_codigo(length=8):
    chars = string.ascii_letters + string.digits
    codigo = ''.join(random.choice(chars) for _ in range(length))
    return codigo

def generate_5dig():
    return random.randint(10000, 99999)