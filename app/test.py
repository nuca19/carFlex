import pypyodbc as odbc

DRIVER_NAME = 'SQL Server Native Client 11.0'
SERVER_NAME = 'LAPTOP-PQBKH6FT'
DATABASE_NAME = 'rentacar'
connection_string = f"""DRIVER={{{DRIVER_NAME}}};SERVER={SERVER_NAME};DATABASE={DATABASE_NAME};Trusted_Connection=yes;"""

conn = odbc.connect(connection_string)
print(conn)

cursor = conn.cursor()

cursor.execute("SELECT * FROM rentacar.cliente")    
res = cursor.fetchall()
print(res)
cursor.close()