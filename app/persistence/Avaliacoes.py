from persistence.session import create_connection
from pyodbc import IntegrityError
import random
from decimal import Decimal
from typing import NamedTuple
import string
import random

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