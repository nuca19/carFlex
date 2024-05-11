import random
import string
from typing import NamedTuple

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
    automovel_codigo: int
    motociclo_codigo: int
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
    marca: str
    modelo: str
    cavalos: int
    km: int


def list_anuncios():
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("""SELECT marca, modelo, cavalos, km
                            FROM (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo)""")

        return [AnuncioVeiculo(*row) for row in cursor.fetchall()]

