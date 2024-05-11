import configparser
import functools
from pathlib import Path

import pyodbc


@functools.cache
def conn_string() -> str:
    DRIVER_NAME = 'SQL Server Native Client 11.0'
    SERVER_NAME = 'LAPTOP-PQBKH6FT'
    db_name = 'carflex'
    connection_string = f"""DRIVER={{{DRIVER_NAME}}};SERVER={SERVER_NAME};DATABASE={db_name};Trusted_Connection=yes;"""

    return connection_string


def create_connection():
    my_conn_string = conn_string()
    return pyodbc.connect(my_conn_string)
