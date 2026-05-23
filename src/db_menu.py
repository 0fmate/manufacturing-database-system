import os
import mysql.connector
from mysql.connector import Error
from tabulate import tabulate


def connect_to_database():
    try:
        connection = mysql.connector.connect(
            host=os.getenv("DB_HOST", "localhost"),
            user=os.getenv("DB_USER", "root"),
            password=os.getenv("DB_PASSWORD", ""),
            database=os.getenv("DB_NAME", "manufacturing_db"),
            auth_plugin=os.getenv("DB_AUTH_PLUGIN", "mysql_native_password"),
        )
        return connection
    except Error as err:
        print(f"Database connection error: {err}")
        return None


def show_tables(cursor):
    try:
        cursor.execute("SHOW TABLES;")
        tables = cursor.fetchall()

        if not tables:
            print("No tables found in the database.")
            return

        print("\nTables in the database:")
        for table in tables:
            print(f"- {table[0]}")
    except Error as err:
        print(f"Error while retrieving tables: {err}")


def create_table(cursor, connection):
    try:
        table_name = input("Enter the new table name: ").strip()
        table_definition = input("Enter the table definition: ").strip()

        query = f"CREATE TABLE {table_name} ({table_definition})"
        cursor.execute(query)
        connection.commit()

        print(f"Table '{table_name}' created successfully.")
    except Error as err:
        print(f"Error while creating the table: {err}")


def drop_table(cursor, connection):
    try:
        table_name = input("Enter the table name to delete: ").strip()
        query = f"DROP TABLE IF EXISTS {table_name}"
        cursor.execute(query)
        connection.commit()

        print(f"Table '{table_name}' deleted successfully.")
    except Error as err:
        print(f"Error while deleting the table: {err}")


def execute_custom_query(cursor, connection, query):
    try:
        cursor.execute(query)

        if cursor.with_rows:
            result = cursor.fetchall()
            columns = [col[0] for col in cursor.description]

            if not result:
                print("Query executed successfully, but no rows were returned.")
            else:
                print(tabulate(result, headers=columns, tablefmt="grid"))
        else:
            connection.commit()
            print("Query executed successfully.")
    except Error as err:
        print(f"Error while executing the query: {err}")


def main():
    connection = connect_to_database()

    if not connection:
        print("Database connection failed.")
        return

    cursor = connection.cursor()

    while True:
        print("\nMenu:")
        print("1. Show tables")
        print("2. Create a table")
        print("3. Drop a table")
        print("4. Execute a custom SQL query")
        print("5. Exit")

        choice = input("Select an option: ").strip()

        if choice == "1":
            show_tables(cursor)
        elif choice == "2":
            create_table(cursor, connection)
        elif choice == "3":
            drop_table(cursor, connection)
        elif choice == "4":
            query = input("Enter the SQL query to execute: ").strip()
            execute_custom_query(cursor, connection, query)
        elif choice == "5":
            cursor.close()
            connection.close()
            print("Database connection closed.")
            break
        else:
            print("Invalid option. Please try again.")


if __name__ == "__main__":
    main()