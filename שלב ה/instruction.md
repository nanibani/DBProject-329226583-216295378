כמובן, הנה גרסת README.md מעוצבת של ההוראות. ניתן להעתיק ולהדביק את התוכן הבא ישירות לקובץ README.md בפרויקט שלך.

מערכת ניהול תוכן ומדיה
מערכת זו מספקת ממשק משתמש גרפי (GUI) לניהול בסיס נתונים של תוכן ומדיה המבוסס על PostgreSQL. הממשק מאפשר לבצע פעולות CRUD (Create, Read, Update, Delete) על טבלאות המידע, לנהל קשרים ביניהן, ולהריץ שאילתות ופונקציות מתקדמות.

תוכן עניינים
⚙️ דרישות קדם

🔧 התקנה והגדרה

▶️ הפעלה

🚀 שימוש במערכת

תפריט ראשי

מסכי ניהול (כותרים ופרנצייזים)

מסך ניהול קישורים

מסך שאילתות ופונקציות מתקדמות

🚪 יציאה מהמערכת

⚙️ דרישות קדם
לפני השימוש, יש לוודא שהרכיבים הבאים מותקנים ומוגדרים בסביבת העבודה שלך:

Python 3: גרסה עדכנית של Python.

PostgreSQL Server: שרת בסיסי נתונים של PostgreSQL פועל ונגיש.

בסיס נתונים וטבלאות: בסיס נתונים קיים עם הסכמה (Schema) המתאימה (טבלאות title, franchise, belongs_to וכו').

ספריית psycopg2: ספריה לחיבור בין Python ל-PostgreSQL.

🔧 התקנה והגדרה
1. התקנת ספריות
כדי להתקין את הספרייה הנדרשת, יש להריץ את הפקודה הבאה בשורת הפקודה (Terminal/CMD):

Bash

pip install psycopg2-binary
2. הגדרת חיבור לבסיס הנתונים
יש לעדכן את פרטי החיבור לבסיס הנתונים ישירות בקוד המקור.

פתח את קובץ ה-Python (.py) בעורך קוד.

נווט לפונקציה connect_to_db.

שנה את הפרמטרים הבאים כך שיתאימו להגדרות השרת שלך:

Python

def connect_to_db(self):
    """חיבור לבסיס הנתונים PostgreSQL"""
    try:
        self.conn = psycopg2.connect(
            dbname="your_db_name",      #  <-- עדכן לשם בסיס הנתונים שלך
            user="your_username",      #  <-- עדכן לשם המשתמש שלך
            password="your_password",  #  <-- עדכן לסיסמה שלך
            host="localhost",          #  <-- עדכן לכתובת השרת שלך
            port="5432"
        )
        messagebox.showinfo("הצלחה", "התחברנו בהצלחה לבסיס הנתונים!")
    except Exception as e:
        messagebox.showerror("שגיאה", f"שגיאה בחיבור לבסיס הנתונים:\n{str(e)}")
        sys.exit()
▶️ הפעלה
לאחר סיום ההגדרה, הרץ את הסקריפט מה-Terminal או CMD באמצעות הפקודה:

Bash

python your_script_name.py
(החלף את your_script_name.py בשם הקובץ)

אם החיבור הצליח, יופיע חלון התפריט הראשי.

🚀 שימוש במערכת
תפריט ראשי
המסך הראשי הוא מרכז הניווט של המערכת. כל כפתור מוביל למסך ניהול ייעודי.

מסכי ניהול (כותרים ופרנצ'ייזים)
מסכים אלו מאפשרים ניהול מלא של רשומות ומורכבים משני חלקים: טופס פעולות וטבלת נתונים.

הוספה: מלא את השדות בטופס ולחץ על "הוסף".

עדכון:

בחר רשומה מהטבלה כדי למלא את הטופס בנתונים קיימים.

שנה את הנתונים הרצויים ולחץ על "עדכן". (לא ניתן לשנות מזהה).

מחיקה: בחר רשומה מהטבלה ולחץ על "מחק".

ניקוי: לחץ על "נקה" כדי לרוקן את שדות הטופס.

מסך ניהול קישורים (Belongs To)
מסך זה משמש ליצירה ומחיקה של קשרים בין כותרים ופרנצ'ייזים.

להוספת קישור: הזן מזהה פרנצ'ייז ו-מזהה כותר ולחץ על "הוסף קישור".

למחיקת קישור: בחר את הקישור מהטבלה ולחץ על "מחק קישור".

מסך שאילתות ופונקציות מתקדמות
מסך זה מחולק לשתי לשוניות:

לשונית "שאילתות מורכבות":

לחץ על אחד מהכפתורים כדי להריץ שאילתת SQL מוגדרת מראש.

התוצאות יוצגו באופן מיידי בטבלה.

לשונית "פונקציות ופרוצדורות":

סטטיסטיקות יוצר: הזן מזהה יוצר, לחץ על "הרץ פונקציה" וצפה בתוצאה בתיבת הטקסט.

ניהול כותרי פרנצ'ייז: הזן מזהה פרנצ'ייז, לחץ על "הרץ פרוצדורה" כדי לעדכן את ספירת הכותרים בבסיס הנתונים ולקבל משוב.

בכל מסך קיים כפתור "חזרה לתפריט הראשי" לחזרה נוחה למסך הבית.

🚪 יציאה מהמערכת
לחץ על כפתור "יציאה" בתפריט הראשי. תתבקש לאשר את הפעולה לפני שהתוכנה תיסגר.
