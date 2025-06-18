## פרויקט: מערכת לניהול תוכן מדיה - Netflix

**שמות מגישים**: יוסף נאור חסון, אושר מגר
**המערכת**: Netflix
**היחידה הנבחרת**: תוכן וסוגי מדיה

---

## תוכן עניינים

1. [מבוא](#מבוא)
2. [פירוט הישויות](#פירוט-הישויות)
3. [תרשים ERD](#תרשים-erd)
4. [תרשים DSD וטבלאות SQL](#תרשים-dsd-וטבלאות-sql)
5. [הזנת נתונים](#הזנת-נתונים)
6. [שאילתות - שלב ב'](#שאילתות---שלב-ב)

   * [שאילתות SELECT](#שאילתות-select)
   * [שאילתות DELETE](#שאילתות-delete)
   * [שאילתות UPDATE](#שאילתות-update)
7. [סיכום](#סיכום)

---

## מבוא

בפרויקט זה אנו עוסקים במערכת לניהול תוכן במדיה דיגיטלית, בדגש על פלטפורמה בסגנון Netflix. המערכת שומרת מידע מגוון הקשור לתכנים הזמינים לצפייה – סרטים, סדרות, פרקים, עונות, ז'אנרים, כותרים ומותגים. כמו כן, נשמרים גם פרסים בתחום הקולנוע והטלוויזיה והשייכות שלהם ליצירות השונות.



* שמירה וניהול מידע עשיר על כותרים מסוגים שונים.
* ניהול קשרים בין ישויות כמו ז'אנרים, פרסים, פרנצ'ייזים ועוד.
* תמיכה בפונקציונליות מתקדמת כמו ניתוח תוכן, קשרים בין המשכים, סינון לפי קריטריונים.

---

## פירוט הישויות

כל כותר (Title) משתייך או לסרט (Movie) או לסדרת טלוויזיה (TV Show). סרטים כוללים מידע על תאריך, משך וסוג, בעוד שסדרות כוללות מספר עונות ועונות מכילות פרקים. ישויות נוספות כוללות ז'אנרים, פרסים, פרנצ'ייזים. נעשה שימוש בהתמחויות, קשרים מזהים וישויות חלשות.

---

## תרשים ERD

![ERD Diagram](https://github.com/user-attachments/assets/a5274f2d-9730-4993-8dea-9ecb0d8ca351)

---

## תרשים DSD וטבלאות SQL

![DSD Diagram](https://github.com/user-attachments/assets/fbf1b545-afff-4f8d-a616-11a244a8d56e)

דיאגרמה זו מתארת את מבנה בסיס הנתונים, תוך שימוש בטבלאות, מפתחות ראשיים וזרים, וקשרים רבים-לרבים לשמירה על שלמות נתונים.

---

## הזנת נתונים

### שימוש בכלי Mockaroo

![Mockaroo Example](https://github.com/user-attachments/assets/aa995b80-6291-41a1-b140-0f07b395800b)

### הזנת נתונים באמצעות קוד פייתון

![Python Insertion](https://github.com/user-attachments/assets/fe20fbbd-6f65-49f1-ad64-08cb97c4798a)

### הזנה ידנית בקובץ CSV

![CSV Input](https://github.com/user-attachments/assets/a741d760-ea89-4f17-98b5-63e136b4d79b)

### יצירת גיבוי ו-restore

![Backup Screenshot](https://github.com/user-attachments/assets/200b11cd-a49a-4369-a242-23f8fa52557b)
![Restore Screenshot](https://github.com/user-attachments/assets/bbd31e64-3a0f-4b06-b05c-180a7b03aab7)

---

## שאילתות - שלב ב

### שאילתות SELECT

1. כל סרטי האקשן, ההרפתקאות והמותחן שיצאו לפני שנת 2000
![image](https://github.com/user-attachments/assets/f2097d12-0eb0-4ae0-b8ff-d7c433101aa3)

2. קיבוץ סרטים לפי פרסים
   ![image](https://github.com/user-attachments/assets/825761b0-a56f-4a38-999f-7dbc53229c90)

3. סדרות עם אורך פרק ממוצע מעל 50 דקות
   ![image](https://github.com/user-attachments/assets/feb199ef-7932-40f7-bd41-7a0cf2bea6e1)

4. סדרות עם זמן שידור כולל מתחת ל־5 שעות
   ![image](https://github.com/user-attachments/assets/4a9108e5-431f-4288-b117-b881f5cf329f)

5. איתור סרטי המשך עם פער זמן גדול מהסרט המקורי

![Screenshot 2025-06-18 121604](https://github.com/user-attachments/assets/d3656337-2220-4fc9-b3ad-651932346adc)

6. ניתוח זכיינויות: סרטים לעומת סדרות
   ![image](https://github.com/user-attachments/assets/4df46d2c-9a10-484d-aae7-81ad4c11cd23)

7.הסרט שזכה במרב הפרסים בכל ז'אנר
   ![image](https://github.com/user-attachments/assets/ebda9a3d-56cb-44fe-b8f9-7eec047b3413)

8. כותרים מקוריים ומספר פרסים
   ![image](https://github.com/user-attachments/assets/8448484e-2b8f-47dd-97d2-117acb21a5a7)


### שאילתות DELETE

1. מחיקת כותרים לפני 1975 שלא זכו בפרסים
   ![delete1](https://github.com/user-attachments/assets/593bd7ad-b053-4ea7-8bc9-5d0a92294954)

2. מחיקת עונות מעל עונה 20
   ![delete2](https://github.com/user-attachments/assets/9e608139-aeb9-4134-9619-f0b04c13d0af)

3. מחיקת כותרים מסדרת "הארי פוטר"
   ![delete3](https://github.com/user-attachments/assets/9a43d45e-3053-42e0-8663-7f25169f7ca7)

### שאילתות UPDATE

1. עדכון דירוג גיל לסרטים לפני 2000
   ![update1](https://github.com/user-attachments/assets/949bdbd2-3aa1-430f-ab3a-9778e761829f)

2. עדכון עונה ל־"Completed" אם כל הפרקים שודרו
   ![update2](https://github.com/user-attachments/assets/e131fedc-1c5c-4fdd-80a2-c52c350967e7)

3. עדכון שם פרנצ'ייז ל־"DCU" אם מתחיל ב־"GOTHAM UNIVERS"
   ![update3](https://github.com/user-attachments/assets/126c6513-75da-4e37-b08f-360bd3c86d4f)

---

## סיכום

בשלב א' הגדרנו תשתית נתונים מלאה למערכת מדיה, כולל ERD, DSD, טבלאות, הזנת נתונים וביצוע גיבוי. בשלב ב' הראינו שאילתות מתקדמות מסוג SELECT, DELETE ו־UPDATE. התקדמנו לבניית מערכת ניתוח וניהול תוכן בפלטפורמה מתקדמת לניהול מדיה דיגיטלית.
