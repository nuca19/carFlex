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
    numero: int
    marca: str
    modelo: str
    cavalos: int
    km: int
    preco: Decimal





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
        cursor.execute("""SELECT numero, marca, modelo, cavalos, km, preco
                        FROM Anuncio_venda JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo) ON Anuncio_venda.codigo_veiculo=Veiculo.codigo""")
        return [AnuncioVeiculo(*row) for row in cursor.fetchall()]
    
def createAnuncioVenda(automovel: Automovel, veiculo: Veiculo, anuncio_venda: AnuncioVendaForm):
    with create_connection() as conn:
            codigo = generate_codigo()
            numero = generate_5dig()
            id_vendedor = 103
            cursor = conn.cursor()
            print(*veiculo)
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
            """, (numero, anuncio_venda.preco, codigo, id_vendedor))
            conn.commit()
            return


def generate_codigo(length=8):
    chars = string.ascii_letters + string.digits
    codigo = ''.join(random.choice(chars) for _ in range(length))
    return codigo

def generate_5dig():
    return random.randint(10000, 99999)