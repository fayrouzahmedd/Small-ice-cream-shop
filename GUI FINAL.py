import tkinter as tk
from tkinter import messagebox
import cx_Oracle

class DatabaseManager:
    def __init__(self, connection_string):
        self.conn = cx_Oracle.connect(connection_string)
        self.cursor = self.conn.cursor()

    def execute_query(self, query, values=None):
        try:
            if values:
                self.cursor.execute(query, values)
            else:
                self.cursor.execute(query)
            self.conn.commit()
            return True
        except Exception as e:
            messagebox.showerror("Error", f"Error: {str(e)}")
            return False

    def fetch_all(self, query):
        self.cursor.execute(query)
        return self.cursor.fetchall()

class DatabaseGUI:
    def __init__(self, master, table_name, db_manager):
        self.master = master
        self.table_name = table_name
        self.db_manager = db_manager

        self.frame = tk.Frame(self.master)
        self.frame.pack()

        self.entry_values = []
        self.create_entry_fields()
        self.create_buttons()

    def create_entry_fields(self):
        tk.Label(self.frame, text=f"{self.table_name.capitalize()} Table").grid(row=0, column=1, columnspan=2)

        columns = self.get_columns()
        for i, column in enumerate(columns, start=1):
            tk.Label(self.frame, text=column).grid(row=i, column=1)
            entry = tk.Entry(self.frame)
            entry.grid(row=i, column=2)
            self.entry_values.append(entry)

    def create_buttons(self):
        tk.Button(self.frame, text="Insert", command=self.insert_record).grid(row=10, column=1, columnspan=2)
        tk.Button(self.frame, text="Update", command=self.update_record).grid(row=11, column=1, columnspan=2)
        tk.Button(self.frame, text="Delete", command=self.delete_record).grid(row=12, column=1, columnspan=2)

    def get_columns(self):
        query = f"SELECT column_name FROM all_tab_columns WHERE table_name = '{self.table_name.upper()}'"
        columns = self.db_manager.fetch_all(query)
        return [column[0] for column in columns]

    def get_entry_values(self):
        return [entry.get() for entry in self.entry_values]

    def insert_record(self):
        columns = self.get_columns()
        values = self.get_entry_values()

    # Convert numeric values to appropriate types
        for i, value in enumerate(values):
            if i == 0 or i == 1:  # Assuming the first two columns are numeric (DELIVERY_ID and ORDER_ID)
                values[i] = int(value)

        placeholders = ', '.join([':' + col for col in columns])
        query = f"INSERT INTO {self.table_name} ({', '.join(columns)}) VALUES ({placeholders})"
        data = dict(zip(columns, values))

    # Print data for debugging
        for col, value in data.items():
            print(f"Column: {col}, Value: {value}, Type: {type(value)}")
            print(f"Inserting into {self.table_name}:")
        for col, value in zip(columns, values):
            print(f"{col}: {value}")

        self.db_manager.execute_query(query, data)


    def update_record(self):
        columns = self.get_columns()
        values = self.get_entry_values()
        primary_key = columns[0]  # Assuming the first column is the primary key
        set_clause = ', '.join([f'{col}=:new_{col}' for col in columns if col != primary_key])
        query = f"UPDATE {self.table_name} SET {set_clause} WHERE {primary_key}=:old_{primary_key}"
    
    # Create a dictionary to bind values to placeholders
        bind_values = {f'new_{col}': val for col, val in zip(columns, values) if col != primary_key}
        bind_values[f'old_{primary_key}'] = values[0]  # Assuming the primary key value is in the first position
    
        self.db_manager.execute_query(query, bind_values)


    def delete_record(self):
        columns = self.get_columns()
        values = self.get_entry_values()
        primary_key = columns[0]
        query = f"DELETE FROM {self.table_name} WHERE {primary_key}=:del_{primary_key}"
        values = {f'del_{primary_key}': self.entry_values[0].get()}
        self.db_manager.execute_query(query, values)


def main():
    root = tk.Tk()

    # Replace 'your_username', 'your_password', 'your_host:your_port/your_service' with your actual database credentials
    connection_string = 'system/lara@localhost:1521/xe'
    db_manager = DatabaseManager(connection_string)

    # Create instances of the DatabaseGUI for each table
    delivery_gui = DatabaseGUI(root, "Delivery", db_manager)
    order_gui = DatabaseGUI(root, "Orders", db_manager)
    products_gui = DatabaseGUI(root, "Products", db_manager)
    offers_gui = DatabaseGUI(root, "Offers", db_manager)
    suppliers_gui = DatabaseGUI(root, "Suppliers", db_manager)
    inventory_gui = DatabaseGUI(root, "Inventory", db_manager)
    transaction_gui = DatabaseGUI(root, "Transaction", db_manager)
    CUSTOMERS_gui = DatabaseGUI(root, "CUSTOMERS", db_manager)
    employees_gui = DatabaseGUI(root, "Employees", db_manager)

    root.mainloop()

if __name__ == "__main__":
    main()
