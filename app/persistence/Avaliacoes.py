from persistence.session import create_connection
from pyodbc import IntegrityError
import random
from decimal import Decimal
from typing import NamedTuple
import string
import random

class AvaliacaoCard(NamedTuple):
    codigo_veiculo: str
    data_compra: str
    avaliacao: str
    comentario: str

def checkforAvaliacao(num_venda, user):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            SELECT CASE 
                WHEN Avaliacao.numero IS NULL THEN 0 
                ELSE 1 
            END 
            FROM Compra
            LEFT JOIN Avaliacao ON Compra.numero = Avaliacao.num_compra
            WHERE Compra.num_venda = ? AND Compra.id_comprador = ?
        ''', (num_venda, user))
        result = cursor.fetchone()
        print(result)
        if result is None:
            return 1
        return result[0]
    
def listAvaliacoes():
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            SELECT Anuncio_venda.codigo_veiculo, Compra.data_compra, Avaliacao.avaliacao, Avaliacao.comentario 
            FROM Avaliacao 
            JOIN Compra ON Avaliacao.num_compra = Compra.numero 
            JOIN Anuncio_venda ON Compra.num_venda = Anuncio_venda.numero
        ''')
        return [AvaliacaoCard(*row) for row in cursor.fetchall()]

def filterAvaliacoes(tipo, marca, modelo, sort):
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute('''EXEC filterAvaliacoes ?, ?, ?, ?''', (tipo, marca, modelo, sort))
        return [AvaliacaoCard(*row) for row in cursor.fetchall()]
