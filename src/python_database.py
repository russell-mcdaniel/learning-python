import pyodbc

# Python Driver for SQL Server
# https://docs.microsoft.com/en-us/sql/connect/python/python-driver-for-sql-server
# https://github.com/mkleehammer/pyodbc/

driver = 'ODBC Driver 17 for SQL Server'
server = '(local)'
database = 'PythonDatabase'
login = 'sa'
password = 'sqlserver1!'

connection_string = f'Driver={driver};Server={server};Database={database};UID={login};PWD={password}'

with pyodbc.connect(connection_string) as connection:
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM dbo.Company;")
        rows = cursor.fetchall()
        for row in rows:
            print(str(row[0]), str(row[1]))

max_cursors = connection.getinfo(pyodbc.SQL_MAX_CONCURRENT_ACTIVITIES)
print(f'The maximum cursors supported per connection is {max_cursors}.')

connection.close()
