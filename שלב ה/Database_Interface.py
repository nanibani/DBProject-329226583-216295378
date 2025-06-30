import tkinter as tk
from tkinter import ttk, messagebox, scrolledtext
import psycopg2
from psycopg2 import sql
from datetime import datetime
import sys


class DatabaseGUI:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("ממשק ניהול בסיס נתונים - תוכן ומדיה")
        self.root.geometry("1200x700")
        self.root.configure(bg='#f0f0f0')

        # חיבור לבסיס הנתונים
        self.conn = None
        self.connect_to_db()

        # יצירת מסך הכניסה
        self.create_main_menu()

    def connect_to_db(self):
        """חיבור לבסיס הנתונים PostgreSQL"""
        try:
            self.conn = psycopg2.connect(
                dbname="mydatabase",  # החלף בשם בסיס הנתונים שלך
                user="mynaoruser",  # החלף בשם המשתמש שלך
                password="Yukhnxyukh1!",  # החלף בסיסמה שלך
                host="localhost",
                port="5432"
            )
            messagebox.showinfo("הצלחה", "התחברנו בהצלחה לבסיס הנתונים!")
        except Exception as e:
            messagebox.showerror("שגיאה", f"שגיאה בחיבור לבסיס הנתונים:\n{str(e)}")
            sys.exit()

    def create_main_menu(self):
        """יצירת מסך הכניסה הראשי"""
        # ניקוי המסך
        for widget in self.root.winfo_children():
            widget.destroy()

        # כותרת ראשית
        title_frame = tk.Frame(self.root, bg='#2c3e50', height=100)
        title_frame.pack(fill=tk.X)

        title_label = tk.Label(title_frame, text="מערכת ניהול תוכן ומדיה",
                               font=("Arial", 24, "bold"), fg='white', bg='#2c3e50')
        title_label.pack(pady=30)

        # מסגרת לכפתורים
        button_frame = tk.Frame(self.root, bg='#f0f0f0')
        button_frame.pack(expand=True, fill=tk.BOTH, padx=50, pady=50)

        # סגנון לכפתורים
        button_style = {
            'font': ("Arial", 14),
            'width': 25,
            'height': 2,
            'bg': '#3498db',
            'fg': 'white',
            'relief': tk.RAISED,
            'bd': 3,
            'cursor': 'hand2'
        }

        # כפתורי ניווט
        tk.Button(button_frame, text="ניהול כותרים (Titles)",
                  command=self.open_titles_screen, **button_style).pack(pady=10)

        tk.Button(button_frame, text="ניהול פרנצ'ייזים (Franchises)",
                  command=self.open_franchises_screen, **button_style).pack(pady=10)

        tk.Button(button_frame, text="ניהול קישורים (Belongs To)",
                  command=self.open_belongs_to_screen, **button_style).pack(pady=10)

        tk.Button(button_frame, text="שאילתות ופונקציות מתקדמות",
                  command=self.open_queries_screen, **button_style).pack(pady=10)

        tk.Button(button_frame, text="יציאה",
                  command=self.quit_app, bg='#e74c3c', **{k: v for k, v in button_style.items() if k != 'bg'}).pack(
            pady=20)

    def open_titles_screen(self):
        """מסך ניהול כותרים"""
        for widget in self.root.winfo_children():
            widget.destroy()

        # כותרת
        self.create_screen_header("ניהול כותרים")

        # מסגרת ראשית
        main_frame = tk.Frame(self.root, bg='#f0f0f0')
        main_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)

        # חלק עליון - טופס הוספה/עדכון
        form_frame = tk.LabelFrame(main_frame, text="הוספה/עדכון כותר", font=("Arial", 12, "bold"))
        form_frame.pack(fill=tk.X, padx=10, pady=10)

        # שדות הטופס
        fields = [
            ("מזהה כותר:", "title_id"),
            ("שם הכותר:", "title_name"),
            ("דירוג גיל:", "age_rating"),
            ("מזהה סרט המשך:", "sequel_id")
        ]

        self.title_entries = {}
        for i, (label_text, field_name) in enumerate(fields):
            tk.Label(form_frame, text=label_text, font=("Arial", 10)).grid(row=i // 2, column=(i % 2) * 2, padx=10,
                                                                           pady=5, sticky="e")
            entry = tk.Entry(form_frame, font=("Arial", 10), width=20)
            entry.grid(row=i // 2, column=(i % 2) * 2 + 1, padx=10, pady=5)
            self.title_entries[field_name] = entry

        # כפתורי פעולה
        button_frame = tk.Frame(form_frame)
        button_frame.grid(row=2, column=0, columnspan=4, pady=10)

        tk.Button(button_frame, text="הוסף", command=self.add_title,
                  bg='#27ae60', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)
        tk.Button(button_frame, text="עדכן", command=self.update_title,
                  bg='#f39c12', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)
        tk.Button(button_frame, text="מחק", command=self.delete_title,
                  bg='#e74c3c', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)
        tk.Button(button_frame, text="נקה", command=self.clear_title_form,
                  bg='#95a5a6', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)

        # חלק תחתון - טבלת נתונים
        table_frame = tk.LabelFrame(main_frame, text="רשימת כותרים", font=("Arial", 12, "bold"))
        table_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        # יצירת Treeview
        columns = ("מזהה", "שם", "דירוג גיל", "מזהה סרט המשך")
        self.titles_tree = ttk.Treeview(table_frame, columns=columns, show='headings', height=15)

        # הגדרת כותרות העמודות
        for col in columns:
            self.titles_tree.heading(col, text=col)
            self.titles_tree.column(col, width=150)

        # סרגל גלילה
        scrollbar = ttk.Scrollbar(table_frame, orient=tk.VERTICAL, command=self.titles_tree.yview)
        self.titles_tree.configure(yscrollcommand=scrollbar.set)

        self.titles_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

        # טעינת נתונים
        self.load_titles()

        # חיבור לאירוע בחירה
        self.titles_tree.bind('<<TreeviewSelect>>', self.on_title_select)

        # כפתור חזרה
        tk.Button(main_frame, text="חזרה לתפריט הראשי", command=self.create_main_menu,
                  bg='#34495e', fg='white', font=("Arial", 12)).pack(pady=10)

    def load_titles(self):
        """טעינת כותרים מבסיס הנתונים"""
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT title_id, title_name, age_rating, sequel_id FROM title ORDER BY title_id")

            # ניקוי הטבלה
            for item in self.titles_tree.get_children():
                self.titles_tree.delete(item)

            # הוספת הנתונים
            for row in cursor.fetchall():
                self.titles_tree.insert("", tk.END, values=row)

            cursor.close()
        except Exception as e:
            messagebox.showerror("שגיאה", f"שגיאה בטעינת נתונים:\n{str(e)}")

    def on_title_select(self, event):
        """טיפול בבחירת כותר מהטבלה"""
        selection = self.titles_tree.selection()
        if selection:
            item = self.titles_tree.item(selection[0])
            values = item['values']

            self.title_entries['title_id'].delete(0, tk.END)
            self.title_entries['title_id'].insert(0, values[0])

            self.title_entries['title_name'].delete(0, tk.END)
            self.title_entries['title_name'].insert(0, values[1])

            self.title_entries['age_rating'].delete(0, tk.END)
            self.title_entries['age_rating'].insert(0, values[2])

            if values[3]:
                self.title_entries['sequel_id'].delete(0, tk.END)
                self.title_entries['sequel_id'].insert(0, values[3])

    def add_title(self):
        """הוספת כותר חדש"""
        try:
            cursor = self.conn.cursor()

            sequel_id = self.title_entries['sequel_id'].get()
            sequel_id = int(sequel_id) if sequel_id else None

            cursor.execute("""
                INSERT INTO title (title_id, title_name, age_rating, sequel_id)
                VALUES (%s, %s, %s, %s)
            """, (
                int(self.title_entries['title_id'].get()),
                self.title_entries['title_name'].get(),
                int(self.title_entries['age_rating'].get()),
                sequel_id
            ))

            self.conn.commit()
            cursor.close()

            messagebox.showinfo("הצלחה", "הכותר נוסף בהצלחה!")
            self.load_titles()
            self.clear_title_form()

        except Exception as e:
            self.conn.rollback()
            messagebox.showerror("שגיאה", f"שגיאה בהוספת כותר:\n{str(e)}")

    def update_title(self):
        """עדכון כותר קיים"""
        try:
            cursor = self.conn.cursor()

            sequel_id = self.title_entries['sequel_id'].get()
            sequel_id = int(sequel_id) if sequel_id else None

            cursor.execute("""
                UPDATE title 
                SET title_name = %s, age_rating = %s, sequel_id = %s
                WHERE title_id = %s
            """, (
                self.title_entries['title_name'].get(),
                int(self.title_entries['age_rating'].get()),
                sequel_id,
                int(self.title_entries['title_id'].get())
            ))

            self.conn.commit()
            cursor.close()

            messagebox.showinfo("הצלחה", "הכותר עודכן בהצלחה!")
            self.load_titles()

        except Exception as e:
            self.conn.rollback()
            messagebox.showerror("שגיאה", f"שגיאה בעדכון כותר:\n{str(e)}")

    def delete_title(self):
        """מחיקת כותר"""
        try:
            title_id = self.title_entries['title_id'].get()
            if not title_id:
                messagebox.showwarning("אזהרה", "אנא בחר כותר למחיקה")
                return

            if messagebox.askyesno("אישור", "האם אתה בטוח שברצונך למחוק את הכותר?"):
                cursor = self.conn.cursor()
                cursor.execute("DELETE FROM title WHERE title_id = %s", (int(title_id),))
                self.conn.commit()
                cursor.close()

                messagebox.showinfo("הצלחה", "הכותר נמחק בהצלחה!")
                self.load_titles()
                self.clear_title_form()

        except Exception as e:
            self.conn.rollback()
            messagebox.showerror("שגיאה", f"שגיאה במחיקת כותר:\n{str(e)}")

    def clear_title_form(self):
        """ניקוי טופס הכותרים"""
        for entry in self.title_entries.values():
            entry.delete(0, tk.END)

    def open_franchises_screen(self):
        """מסך ניהול פרנצ'ייזים"""
        for widget in self.root.winfo_children():
            widget.destroy()

        # כותרת
        self.create_screen_header("ניהול פרנצ'ייזים")

        # מסגרת ראשית
        main_frame = tk.Frame(self.root, bg='#f0f0f0')
        main_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)

        # טופס הוספה/עדכון
        form_frame = tk.LabelFrame(main_frame, text="הוספה/עדכון פרנצ'ייז", font=("Arial", 12, "bold"))
        form_frame.pack(fill=tk.X, padx=10, pady=10)

        # שדות הטופס
        tk.Label(form_frame, text="מזהה פרנצ'ייז:", font=("Arial", 10)).grid(row=0, column=0, padx=10, pady=5,
                                                                             sticky="e")
        self.franchise_id_entry = tk.Entry(form_frame, font=("Arial", 10), width=20)
        self.franchise_id_entry.grid(row=0, column=1, padx=10, pady=5)

        tk.Label(form_frame, text="שם פרנצ'ייז:", font=("Arial", 10)).grid(row=0, column=2, padx=10, pady=5, sticky="e")
        self.franchise_name_entry = tk.Entry(form_frame, font=("Arial", 10), width=30)
        self.franchise_name_entry.grid(row=0, column=3, padx=10, pady=5)

        tk.Label(form_frame, text="מספר כותרים:", font=("Arial", 10)).grid(row=1, column=0, padx=10, pady=5, sticky="e")
        self.number_of_titles_entry = tk.Entry(form_frame, font=("Arial", 10), width=20)
        self.number_of_titles_entry.grid(row=1, column=1, padx=10, pady=5)

        # כפתורי פעולה
        button_frame = tk.Frame(form_frame)
        button_frame.grid(row=2, column=0, columnspan=4, pady=10)

        tk.Button(button_frame, text="הוסף", command=self.add_franchise,
                  bg='#27ae60', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)
        tk.Button(button_frame, text="עדכן", command=self.update_franchise,
                  bg='#f39c12', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)
        tk.Button(button_frame, text="מחק", command=self.delete_franchise,
                  bg='#e74c3c', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)
        tk.Button(button_frame, text="נקה", command=self.clear_franchise_form,
                  bg='#95a5a6', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)

        # טבלת נתונים
        table_frame = tk.LabelFrame(main_frame, text="רשימת פרנצ'ייזים", font=("Arial", 12, "bold"))
        table_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        columns = ("מזהה", "שם", "מספר כותרים")
        self.franchises_tree = ttk.Treeview(table_frame, columns=columns, show='headings', height=15)

        for col in columns:
            self.franchises_tree.heading(col, text=col)
            self.franchises_tree.column(col, width=200)

        scrollbar = ttk.Scrollbar(table_frame, orient=tk.VERTICAL, command=self.franchises_tree.yview)
        self.franchises_tree.configure(yscrollcommand=scrollbar.set)

        self.franchises_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

        self.load_franchises()
        self.franchises_tree.bind('<<TreeviewSelect>>', self.on_franchise_select)

        tk.Button(main_frame, text="חזרה לתפריט הראשי", command=self.create_main_menu,
                  bg='#34495e', fg='white', font=("Arial", 12)).pack(pady=10)

    def load_franchises(self):
        """טעינת פרנצ'ייזים מבסיס הנתונים"""
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT franchise_id, franchise_name, number_of_titles FROM franchise ORDER BY franchise_id")

            for item in self.franchises_tree.get_children():
                self.franchises_tree.delete(item)

            for row in cursor.fetchall():
                self.franchises_tree.insert("", tk.END, values=row)

            cursor.close()
        except Exception as e:
            messagebox.showerror("שגיאה", f"שגיאה בטעינת נתונים:\n{str(e)}")

    def on_franchise_select(self, event):
        """טיפול בבחירת פרנצ'ייז מהטבלה"""
        selection = self.franchises_tree.selection()
        if selection:
            item = self.franchises_tree.item(selection[0])
            values = item['values']

            self.franchise_id_entry.delete(0, tk.END)
            self.franchise_id_entry.insert(0, values[0])

            self.franchise_name_entry.delete(0, tk.END)
            self.franchise_name_entry.insert(0, values[1])

            self.number_of_titles_entry.delete(0, tk.END)
            self.number_of_titles_entry.insert(0, values[2])

    def add_franchise(self):
        """הוספת פרנצ'ייז חדש"""
        try:
            cursor = self.conn.cursor()
            cursor.execute("""
                INSERT INTO franchise (franchise_id, franchise_name, number_of_titles)
                VALUES (%s, %s, %s)
            """, (
                int(self.franchise_id_entry.get()),
                self.franchise_name_entry.get(),
                int(self.number_of_titles_entry.get())
            ))

            self.conn.commit()
            cursor.close()

            messagebox.showinfo("הצלחה", "הפרנצ'ייז נוסף בהצלחה!")
            self.load_franchises()
            self.clear_franchise_form()

        except Exception as e:
            self.conn.rollback()
            messagebox.showerror("שגיאה", f"שגיאה בהוספת פרנצ'ייז:\n{str(e)}")

    def update_franchise(self):
        """עדכון פרנצ'ייז קיים"""
        try:
            cursor = self.conn.cursor()
            cursor.execute("""
                UPDATE franchise 
                SET franchise_name = %s, number_of_titles = %s
                WHERE franchise_id = %s
            """, (
                self.franchise_name_entry.get(),
                int(self.number_of_titles_entry.get()),
                int(self.franchise_id_entry.get())
            ))

            self.conn.commit()
            cursor.close()

            messagebox.showinfo("הצלחה", "הפרנצ'ייז עודכן בהצלחה!")
            self.load_franchises()

        except Exception as e:
            self.conn.rollback()
            messagebox.showerror("שגיאה", f"שגיאה בעדכון פרנצ'ייז:\n{str(e)}")

    def delete_franchise(self):
        """מחיקת פרנצ'ייז"""
        try:
            franchise_id = self.franchise_id_entry.get()
            if not franchise_id:
                messagebox.showwarning("אזהרה", "אנא בחר פרנצ'ייז למחיקה")
                return

            if messagebox.askyesno("אישור", "האם אתה בטוח שברצונך למחוק את הפרנצ'ייז?"):
                cursor = self.conn.cursor()
                cursor.execute("DELETE FROM franchise WHERE franchise_id = %s", (int(franchise_id),))
                self.conn.commit()
                cursor.close()

                messagebox.showinfo("הצלחה", "הפרנצ'ייז נמחק בהצלחה!")
                self.load_franchises()
                self.clear_franchise_form()

        except Exception as e:
            self.conn.rollback()
            messagebox.showerror("שגיאה", f"שגיאה במחיקת פרנצ'ייז:\n{str(e)}")

    def clear_franchise_form(self):
        """ניקוי טופס הפרנצ'ייזים"""
        self.franchise_id_entry.delete(0, tk.END)
        self.franchise_name_entry.delete(0, tk.END)
        self.number_of_titles_entry.delete(0, tk.END)

    def open_belongs_to_screen(self):
        """מסך ניהול קישורים בין כותרים לפרנצ'ייזים"""
        for widget in self.root.winfo_children():
            widget.destroy()

        self.create_screen_header("ניהול קישורים - Belongs To")

        main_frame = tk.Frame(self.root, bg='#f0f0f0')
        main_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)

        # טופס הוספה/מחיקה
        form_frame = tk.LabelFrame(main_frame, text="הוספה/מחיקת קישור", font=("Arial", 12, "bold"))
        form_frame.pack(fill=tk.X, padx=10, pady=10)

        tk.Label(form_frame, text="מזהה פרנצ'ייז:", font=("Arial", 10)).grid(row=0, column=0, padx=10, pady=5,
                                                                             sticky="e")
        self.bt_franchise_id_entry = tk.Entry(form_frame, font=("Arial", 10), width=20)
        self.bt_franchise_id_entry.grid(row=0, column=1, padx=10, pady=5)

        tk.Label(form_frame, text="מזהה כותר:", font=("Arial", 10)).grid(row=0, column=2, padx=10, pady=5, sticky="e")
        self.bt_title_id_entry = tk.Entry(form_frame, font=("Arial", 10), width=20)
        self.bt_title_id_entry.grid(row=0, column=3, padx=10, pady=5)

        button_frame = tk.Frame(form_frame)
        button_frame.grid(row=1, column=0, columnspan=4, pady=10)

        tk.Button(button_frame, text="הוסף קישור", command=self.add_belongs_to,
                  bg='#27ae60', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)
        tk.Button(button_frame, text="מחק קישור", command=self.delete_belongs_to,
                  bg='#e74c3c', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)
        tk.Button(button_frame, text="נקה", command=self.clear_belongs_to_form,
                  bg='#95a5a6', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)

        # טבלת נתונים
        table_frame = tk.LabelFrame(main_frame, text="רשימת קישורים", font=("Arial", 12, "bold"))
        table_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        columns = ("מזהה פרנצ'ייז", "שם פרנצ'ייז", "מזהה כותר", "שם כותר")
        self.belongs_to_tree = ttk.Treeview(table_frame, columns=columns, show='headings', height=15)

        for col in columns:
            self.belongs_to_tree.heading(col, text=col)
            self.belongs_to_tree.column(col, width=150)

        scrollbar = ttk.Scrollbar(table_frame, orient=tk.VERTICAL, command=self.belongs_to_tree.yview)
        self.belongs_to_tree.configure(yscrollcommand=scrollbar.set)

        self.belongs_to_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

        self.load_belongs_to()
        self.belongs_to_tree.bind('<<TreeviewSelect>>', self.on_belongs_to_select)

        tk.Button(main_frame, text="חזרה לתפריט הראשי", command=self.create_main_menu,
                  bg='#34495e', fg='white', font=("Arial", 12)).pack(pady=10)

    def load_belongs_to(self):
        """טעינת קישורים מבסיס הנתונים"""
        try:
            cursor = self.conn.cursor()
            cursor.execute("""
                SELECT bt.franchise_id, f.franchise_name, bt.title_id, t.title_name
                FROM belongs_to bt
                JOIN franchise f ON bt.franchise_id = f.franchise_id
                JOIN title t ON bt.title_id = t.title_id
                ORDER BY bt.franchise_id, bt.title_id
            """)

            for item in self.belongs_to_tree.get_children():
                self.belongs_to_tree.delete(item)

            for row in cursor.fetchall():
                self.belongs_to_tree.insert("", tk.END, values=row)

            cursor.close()
        except Exception as e:
            messagebox.showerror("שגיאה", f"שגיאה בטעינת נתונים:\n{str(e)}")

    def on_belongs_to_select(self, event):
        """טיפול בבחירת קישור מהטבלה"""
        selection = self.belongs_to_tree.selection()
        if selection:
            item = self.belongs_to_tree.item(selection[0])
            values = item['values']

            self.bt_franchise_id_entry.delete(0, tk.END)
            self.bt_franchise_id_entry.insert(0, values[0])

            self.bt_title_id_entry.delete(0, tk.END)
            self.bt_title_id_entry.insert(0, values[2])

    def add_belongs_to(self):
        """הוספת קישור חדש"""
        try:
            cursor = self.conn.cursor()
            cursor.execute("""
                INSERT INTO belongs_to (franchise_id, title_id)
                VALUES (%s, %s)
            """, (
                int(self.bt_franchise_id_entry.get()),
                int(self.bt_title_id_entry.get())
            ))

            self.conn.commit()
            cursor.close()

            messagebox.showinfo("הצלחה", "הקישור נוסף בהצלחה!")
            self.load_belongs_to()
            self.clear_belongs_to_form()

        except Exception as e:
            self.conn.rollback()
            messagebox.showerror("שגיאה", f"שגיאה בהוספת קישור:\n{str(e)}")

    def delete_belongs_to(self):
        """מחיקת קישור"""
        try:
            franchise_id = self.bt_franchise_id_entry.get()
            title_id = self.bt_title_id_entry.get()

            if not franchise_id or not title_id:
                messagebox.showwarning("אזהרה", "אנא בחר קישור למחיקה")
                return

            if messagebox.askyesno("אישור", "האם אתה בטוח שברצונך למחוק את הקישור?"):
                cursor = self.conn.cursor()
                cursor.execute("""
                    DELETE FROM belongs_to 
                    WHERE franchise_id = %s AND title_id = %s
                """, (int(franchise_id), int(title_id)))
                self.conn.commit()
                cursor.close()

                messagebox.showinfo("הצלחה", "הקישור נמחק בהצלחה!")
                self.load_belongs_to()
                self.clear_belongs_to_form()

        except Exception as e:
            self.conn.rollback()
            messagebox.showerror("שגיאה", f"שגיאה במחיקת קישור:\n{str(e)}")

    def clear_belongs_to_form(self):
        """ניקוי טופס הקישורים"""
        self.bt_franchise_id_entry.delete(0, tk.END)
        self.bt_title_id_entry.delete(0, tk.END)

    def open_queries_screen(self):
        """מסך שאילתות ופונקציות מתקדמות"""
        for widget in self.root.winfo_children():
            widget.destroy()

        self.create_screen_header("שאילתות ופונקציות מתקדמות")

        # מסגרת ראשית
        main_frame = tk.Frame(self.root, bg='#f0f0f0')
        main_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)

        # יצירת טאבים
        notebook = ttk.Notebook(main_frame)
        notebook.pack(fill=tk.BOTH, expand=True)

        # טאב שאילתות
        queries_tab = tk.Frame(notebook)
        notebook.add(queries_tab, text="שאילתות מורכבות")

        # טאב פונקציות ופרוצדורות
        functions_tab = tk.Frame(notebook)
        notebook.add(functions_tab, text="פונקציות ופרוצדורות")

        # תוכן טאב שאילתות
        self.create_queries_tab(queries_tab)

        # תוכן טאב פונקציות
        self.create_functions_tab(functions_tab)

        # כפתור חזרה
        tk.Button(main_frame, text="חזרה לתפריט הראשי", command=self.create_main_menu,
                  bg='#34495e', fg='white', font=("Arial", 12)).pack(pady=10)

    def create_queries_tab(self, parent):
        """יצירת טאב השאילתות"""
        # רשימת שאילתות
        queries_frame = tk.LabelFrame(parent, text="בחר שאילתה להרצה", font=("Arial", 12, "bold"))
        queries_frame.pack(fill=tk.X, padx=10, pady=10)

        # כפתורי שאילתות
        tk.Button(queries_frame, text="סרטי פעולה/הרפתקאות/מתח לפני 2000",
                  command=self.run_query1, bg='#3498db', fg='white',
                  font=("Arial", 10), width=40).pack(pady=5)

        tk.Button(queries_frame, text="קיבוץ סרטים לפי פרסים שזכו",
                  command=self.run_query2, bg='#3498db', fg='white',
                  font=("Arial", 10), width=40).pack(pady=5)

        tk.Button(queries_frame, text="תוכניות טלוויזיה עם משך פרק ממוצע מעל 42 דקות",
                  command=self.run_query3, bg='#3498db', fg='white',
                  font=("Arial", 10), width=40).pack(pady=5)

        tk.Button(queries_frame, text="סיכום פרנצ'ייזים",
                  command=self.run_query6, bg='#3498db', fg='white',
                  font=("Arial", 10), width=40).pack(pady=5)

        # אזור תוצאות
        results_frame = tk.LabelFrame(parent, text="תוצאות", font=("Arial", 12, "bold"))
        results_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        # Treeview לתוצאות
        self.query_results_tree = ttk.Treeview(results_frame, show='headings', height=15)

        scrollbar_y = ttk.Scrollbar(results_frame, orient=tk.VERTICAL, command=self.query_results_tree.yview)
        scrollbar_x = ttk.Scrollbar(results_frame, orient=tk.HORIZONTAL, command=self.query_results_tree.xview)

        self.query_results_tree.configure(yscrollcommand=scrollbar_y.set, xscrollcommand=scrollbar_x.set)

        self.query_results_tree.grid(row=0, column=0, sticky='nsew')
        scrollbar_y.grid(row=0, column=1, sticky='ns')
        scrollbar_x.grid(row=1, column=0, sticky='ew')

        results_frame.grid_rowconfigure(0, weight=1)
        results_frame.grid_columnconfigure(0, weight=1)

    def create_functions_tab(self, parent):
        """יצירת טאב הפונקציות והפרוצדורות"""
        # פונקציות
        functions_frame = tk.LabelFrame(parent, text="פונקציות", font=("Arial", 12, "bold"))
        functions_frame.pack(fill=tk.X, padx=10, pady=10)

        # פונקציה 1 - סטטיסטיקות יוצר
        func1_frame = tk.Frame(functions_frame)
        func1_frame.pack(pady=10)

        tk.Label(func1_frame, text="סטטיסטיקות יוצר - הזן מזהה יוצר:",
                 font=("Arial", 10)).pack(side=tk.LEFT, padx=5)
        self.creator_id_entry = tk.Entry(func1_frame, font=("Arial", 10), width=10)
        self.creator_id_entry.pack(side=tk.LEFT, padx=5)
        tk.Button(func1_frame, text="הרץ פונקציה", command=self.run_creator_stats_function,
                  bg='#27ae60', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)

        # פרוצדורות
        procedures_frame = tk.LabelFrame(parent, text="פרוצדורות", font=("Arial", 12, "bold"))
        procedures_frame.pack(fill=tk.X, padx=10, pady=10)

        # פרוצדורה 1 - ניהול כותרי פרנצ'ייז
        proc1_frame = tk.Frame(procedures_frame)
        proc1_frame.pack(pady=10)

        tk.Label(proc1_frame, text="עדכון מספר כותרים בפרנצ'ייז - הזן מזהה פרנצ'ייז:",
                 font=("Arial", 10)).pack(side=tk.LEFT, padx=5)
        self.proc_franchise_id_entry = tk.Entry(proc1_frame, font=("Arial", 10), width=10)
        self.proc_franchise_id_entry.pack(side=tk.LEFT, padx=5)
        tk.Button(proc1_frame, text="הרץ פרוצדורה", command=self.run_manage_franchise_procedure,
                  bg='#9b59b6', fg='white', font=("Arial", 10)).pack(side=tk.LEFT, padx=5)

        # אזור תוצאות
        results_frame = tk.LabelFrame(parent, text="תוצאות", font=("Arial", 12, "bold"))
        results_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        self.function_results_text = scrolledtext.ScrolledText(results_frame, font=("Courier", 10), height=10)
        self.function_results_text.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

    def run_query1(self):
        """הרצת שאילתה 1 - סרטי פעולה/הרפתקאות/מתח לפני 2000"""
        query = """
            SELECT
                T.Title_Name,
                M.Release_Date,
                M.Duration,
                G.Genre_Name
            FROM
                Title T
            JOIN
                Movie M ON T.Title_ID = M.Title_ID
            JOIN
                MovieGenre MG ON T.Title_ID = MG.Title_ID
            JOIN
                Genre G ON MG.Genre_ID = G.Genre_ID
            WHERE
                G.Genre_Name IN ('Action', 'Adventure', 'Thriller')
                AND M.Release_Date < '2000-01-01'
            ORDER BY
                T.Title_Name, M.Release_Date
        """
        self.execute_and_display_query(query, ["שם הסרט", "תאריך יציאה", "משך", "ז'אנר"])

    def run_query2(self):
        """הרצת שאילתה 2 - קיבוץ סרטים לפי פרסים"""
        query = """
            SELECT
                CA.Award_Name,
                COUNT(DISTINCT T.Title_ID) AS Number_of_Movies_Won,
                COUNT(DISTINCT CA.Given_By) AS Number_of_Award_Givers
            FROM
                content_award CA
            JOIN
                Title T ON CA.Title_ID = T.Title_ID
            WHERE
                CA.Result = 'Won' AND T.Title_ID IN (SELECT Title_ID FROM Movie)
            GROUP BY
                CA.Award_Name
            ORDER BY
                Number_of_Movies_Won DESC
        """
        self.execute_and_display_query(query, ["שם הפרס", "מספר סרטים שזכו", "מספר מעניקי הפרס"])

    def run_query3(self):
        """הרצת שאילתה 3 - תוכניות טלוויזיה עם משך פרק ממוצע מעל 42 דקות"""
        query = """
            SELECT
                T.Title_Name,
                TV.number_of_seasons AS Declared_Seasons,
                COUNT(E.Episode_Number) AS Episodes_In_DB,
                ROUND(CAST(AVG(E.Duration) AS NUMERIC), 2) AS Average_Episode_Duration
            FROM
                TV_show TV
            JOIN
                Title T ON TV.Title_ID = T.Title_ID
            JOIN
                Season S ON TV.Title_ID = S.Title_ID
            JOIN
                Episode E ON S.Season_Number = E.Season_Number AND S.Title_ID = E.Title_ID
            GROUP BY
                T.Title_ID, T.Title_Name, TV.number_of_seasons
            HAVING
                AVG(E.Duration) > 42
            ORDER BY
                Average_Episode_Duration DESC
        """
        self.execute_and_display_query(query, ["שם התוכנית", "מספר עונות", "מספר פרקים", "משך פרק ממוצע"])

    def run_query6(self):
        """הרצת שאילתה 6 - סיכום פרנצ'ייזים"""
        query = """
            SELECT
                F.Franchise_Name,
                COUNT(T.Title_ID) AS Total_Titles,
                SUM(CASE WHEN M.Title_ID IS NOT NULL THEN 1 ELSE 0 END) AS Number_of_Movies,
                SUM(CASE WHEN TV.Title_ID IS NOT NULL THEN 1 ELSE 0 END) AS Number_of_TV_Shows
            FROM
                Franchise F
            JOIN
                Belongs_to BT ON F.Franchise_ID = BT.Franchise_ID
            JOIN
                Title T ON BT.Title_ID = T.Title_ID
            LEFT JOIN
                Movie M ON T.Title_ID = M.Title_ID
            LEFT JOIN
                Tv_show TV ON T.Title_ID = TV.Title_ID
            GROUP BY
                F.Franchise_ID, F.Franchise_Name
            ORDER BY
                Total_Titles DESC, F.Franchise_Name
        """
        self.execute_and_display_query(query, ["שם פרנצ'ייז", "סה\"כ כותרים", "מספר סרטים", "מספר תוכניות TV"])

    def execute_and_display_query(self, query, columns):
        """הרצת שאילתה והצגת התוצאות"""
        try:
            cursor = self.conn.cursor()
            cursor.execute(query)
            results = cursor.fetchall()

            # ניקוי התוצאות הקודמות
            for item in self.query_results_tree.get_children():
                self.query_results_tree.delete(item)

            # הגדרת עמודות
            self.query_results_tree['columns'] = columns
            for col in columns:
                self.query_results_tree.heading(col, text=col)
                self.query_results_tree.column(col, width=150)

            # הוספת התוצאות
            for row in results:
                self.query_results_tree.insert("", tk.END, values=row)

            cursor.close()
            messagebox.showinfo("הצלחה", f"השאילתה הושלמה בהצלחה! נמצאו {len(results)} תוצאות")

        except Exception as e:
            messagebox.showerror("שגיאה", f"שגיאה בהרצת השאילתה:\n{str(e)}")

    def run_creator_stats_function(self):
        """הרצת פונקציית סטטיסטיקות יוצר"""
        try:
            creator_id = self.creator_id_entry.get().strip()

            # בדיקת תקינות
            if not creator_id:
                messagebox.showwarning("אזהרה", "אנא הזן מזהה יוצר")
                return

            # בדיקה שזה מספר
            try:
                creator_id_int = int(creator_id)
            except ValueError:
                messagebox.showerror("שגיאה", "מזהה יוצר חייב להיות מספר שלם")
                return

            cursor = self.conn.cursor()

            # קריאה לפונקציה
            cursor.execute("SELECT get_creator_statistics(%s)", (creator_id_int,))
            result = cursor.fetchone()

            if result and result[0]:
                cursor_name = result[0]

                # קריאת התוצאות מהקורסור
                cursor.execute(f'FETCH ALL FROM "{cursor_name}"')
                results = cursor.fetchall()

                # הצגת התוצאות
                self.function_results_text.delete(1.0, tk.END)

                if results:
                    for row in results:
                        text = f"שם יוצר: {row[0] if row[0] else 'לא ידוע'}\n"
                        text += f"מדינה: {row[1] if row[1] else 'לא ידועה'}\n"
                        text += f"סה\"כ חוזים: {row[2] if row[2] else 0}\n"

                        # טיפול בתשלום ממוצע
                        if row[3] is not None:
                            try:
                                avg_payment = float(row[3])
                                text += f"תשלום ממוצע: {avg_payment:.2f}\n"
                            except (ValueError, TypeError):
                                text += f"תשלום ממוצע: {row[3]}\n"
                        else:
                            text += "תשלום ממוצע: 0.00\n"

                        text += "-" * 50 + "\n"
                        self.function_results_text.insert(tk.END, text)
                else:
                    self.function_results_text.insert(tk.END, f"לא נמצאו תוצאות עבור יוצר מספר {creator_id_int}")

                # סגירת הקורסור
                cursor.execute(f'CLOSE "{cursor_name}"')
            else:
                self.function_results_text.delete(1.0, tk.END)
                self.function_results_text.insert(tk.END, f"לא נמצאו נתונים עבור יוצר מספר {creator_id_int}")

            self.conn.commit()
            cursor.close()

        except Exception as e:
            self.conn.rollback()
            messagebox.showerror("שגיאה", f"שגיאה בהרצת הפונקציה:\n{str(e)}")
            # הדפסת השגיאה המלאה לקונסול לצורך דיבוג
            import traceback
            traceback.print_exc()
    def run_manage_franchise_procedure(self):
        """הרצת פרוצדורת ניהול כותרי פרנצ'ייז"""
        try:
            franchise_id = self.proc_franchise_id_entry.get()
            if not franchise_id:
                messagebox.showwarning("אזהרה", "אנא הזן מזהה פרנצ'ייז")
                return

            cursor = self.conn.cursor()
            cursor.execute("CALL manage_franchise_titles(%s, %s)", (int(franchise_id), 'COUNT'))

            self.function_results_text.delete(1.0, tk.END)
            self.function_results_text.insert(tk.END, "הפרוצדורה הופעלה בהצלחה!\n\n")

            cursor.execute("""
                   SELECT f.franchise_name, f.number_of_titles, COUNT(bt.title_id) as actual_count
                   FROM franchise f
                   LEFT JOIN belongs_to bt ON f.franchise_id = bt.franchise_id
                   WHERE f.franchise_id = %s
                   GROUP BY f.franchise_id, f.franchise_name, f.number_of_titles
               """, (int(franchise_id),))

            result = cursor.fetchone()
            if result:
                self.function_results_text.insert(tk.END,
                                                  f"שם פרנצ'ייז: {result[0]}\n"
                                                  f"מספר כותרים מעודכן: {result[1]}\n"
                                                  f"מספר כותרים בפועל: {result[2]}\n")

            self.conn.commit()
            cursor.close()
            messagebox.showinfo("הצלחה", "הפרוצדורה הושלמה בהצלחה!")

        except Exception as e:
            self.conn.rollback()
            messagebox.showerror("שגיאה", f"שגיאה בהרצת הפרוצדורה:\n{str(e)}")

    def create_screen_header(self, title):
        """יצירת כותרת למסך"""
        header_frame = tk.Frame(self.root, bg='#2c3e50', height=80)
        header_frame.pack(fill=tk.X)

        header_label = tk.Label(header_frame, text=title,
                                font=("Arial", 20, "bold"), fg='white', bg='#2c3e50')
        header_label.pack(pady=20)

    def quit_app(self):
        """יציאה מהאפליקציה"""
        if messagebox.askyesno("יציאה", "האם אתה בטוח שברצונך לצאת?"):
            if self.conn:
                self.conn.close()
            self.root.quit()

    def run(self):
        """הרצת האפליקציה"""
        self.root.mainloop()
# בסוף הקובץ:
if __name__ == "__main__":
    app = DatabaseGUI()
    app.root.mainloop()
