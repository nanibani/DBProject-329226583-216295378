# פרויקט: מערכת לניהול תוכן מדיה - Netflix

**שמות מגישים**: יוסף נאור חסון, אושר מגר
**המערכת**: Netflix
**היחידה הנבחרת**: תוכן וסוגי מדיה

---

## תוכן עניינים

1.  [מבוא](#מבוא)
2.  [פירוט הישויות](#פירוט-הישויות)
3.  [תרשים ERD מקורי](#תרשים-erd-מקורי)
4.  [תרשים DSD וטבלאות SQL](#תרשים-dsd-וטבלאות-sql)
5.  [הזנת נתונים](#הזנת-נתונים)
6.  [שאילתות - שלב ב'](#שאילתות---שלב-ב)
    * [שאילתות SELECT](#שאילתות-select)
    * [שאילתות DELETE](#שאילתות-delete)
    * [שאילתות UPDATE](#שאילתות-update)
7.  [סיכום שלבים א' ו-ב'](#סיכום-שלבים-א-ו-ב)
8.  [שלב ג' - אינטגרציה ומבטים](#שלב-ג---אינטגרציה-ומבטים)
    * [הנדוס לאחור: המערכת הנוספת](#הנדוס-לאחור-המערכת-הנוספת)
    * [תהליך האינטגרציה](#תהליך-האינטגרציה)
    * [מבטים (Views)](#מבטים-views)
    * [גיבוי מסד נתונים משולב](#גיבוי-מסד-נתונים-משולב)
9.  [סיכום כללי](#סיכום-כללי)

---

## מבוא

בפרויקט זה אנו עוסקים במערכת לניהול תוכן במדיה דיגיטלית, בדגש על פלטפורמה בסגנון Netflix. המערכת שומרת מידע מגוון הקשור לתכנים הזמינים לצפייה – סרטים, סדרות, פרקים, עונות, ז'אנרים, כותרים ומותגים. כמו כן, נשמרים גם פרסים בתחום הקולנוע והטלוויזיה והשייכות שלהם ליצירות השונות.

---

## פירוט הישויות

כל כותר (Title) משתייך או לסרט (Movie) או לסדרת טלוויזיה (TV Show). סרטים כוללים מידע על תאריך, משך וסוג, בעוד שסדרות כוללות מספר עונות ועונות מכילות פרקים. ישויות נוספות כוללות ז'אנרים, פרסים, פרנצ'ייזים. נעשה שימוש בהתמחויות, קשרים מזהים וישויות חלשות.

---

## תרשים ERD מקורי

![ERD Diagram](https://github.com/user-attachments/assets/a5274f2d-9730-4993-8dea-9ecb0d8ca351)

---

## תרשים DSD וטבלאות SQL

![DSD Diagram](https://github.com/user-attachments/assets/fbf1b545-afff-4f8d-a616-11a244a8d56e)

---

## הזנת נתונים
... (התוכן הקיים שלכם נשאר פה) ...
---

## שאילתות - שלב ב'
... (התוכן הקיים שלכם נשאר פה) ...
---

## סיכום שלבים א' ו-ב'

בשלב א' הגדרנו תשתית נתונים מלאה למערכת מדיה, כולל ERD, DSD, טבלאות, והזנת נתונים. בשלב ב' הראינו שאילתות מתקדמות מסוג SELECT, DELETE ו־UPDATE. התקדמנו לבניית מערכת ניתוח וניהול תוכן בפלטפורמה מתקדמת לניהול מדיה דיגיטלית.

---

## שלב ג' - אינטגרציה ומבטים

בשלב זה ביצענו אינטגרציה של מערכת ניהול התוכן שלנו (אגף תוכן וסוגי מדיה) עם מערכת ניהול יוצרים והפקות. התהליך כלל הנדוס לאחור, יצירת מודל נתונים משולב, שינוי סכמת בסיס הנתונים הקיים והגדרת מבטים (Views) לניתוח הנתונים המאוחדים.

### הנדוס לאחור: המערכת הנוספת

קיבלנו גיבוי של בסיס נתונים של אגף ניהול יוצרים, סוכנים, חוזים והפקות. ביצענו הנדוס לאחור כדי להבין את מבנה הנתונים שלו.

#### תרשים DSD של המערכת הנוספת

**(כאן יש להוסיף תמונה של תרשים ה-DSD שיצרתם עבור מערכת היוצרים)**
`![DSD Diagram - New System](קישור_לתמונת_ה-DSD_החדש)`

#### תרשים ERD של המערכת הנוספת

מתוך ה-DSD, יצרנו את תרשים ה-ERD המייצג את הישויות והקשרים במערכת ניהול היוצרים.

**(כאן יש להוסיף תמונה של תרשים ה-ERD שיצרתם)**
`![ERD Diagram - New System](קישור_לתמונת_ה-ERD_החדש)`

---

### תהליך האינטגרציה

תהליך האינטגרציה התמקד במיזוג טבלת `Production` ממערכת היוצרים לתוך טבלת `Title` הקיימת במערכת שלנו, כדי ליצור ישות מרכזית ואחידה לכלל התכנים.

#### החלטות עיצוביות בתהליך האינטגרציה

* **החלטה 1: מניעת קונפליקט שמות** - במערכת היוצרים הייתה טבלה בשם `Award`. כדי למנוע התנגשות עם טבלת הפרסים של התוכן, שינינו את שמה ל-`Creator_Award`, המייצגת פרסים אישיים של יוצרים.
* **החלטה 2: מיזוג ישויות תוכן** - הוחלט לאחד את ישות `Production` מיחידת היוצרים עם ישות `Title` ביחידת התוכן. `Title` תשמש כישות העל המרכזית לכל סוגי התוכן (סרטים, סדרות, הפקות), ותכיל את המידע המשותף.
* **החלטה 3: העברת נתונים והימנעות מכפילויות** - הנתונים מטבלת `Production` הועברו ל-`Title`. התהליך כלל בדיקה למניעת כפילויות: הפקה חדשה נוספה רק אם לא קיים כבר כותר עם שם זהה בטבלת `Title`.
* **החלטה 4: עדכון קשרי גומלין (Foreign Keys)** - לאחר מיזוג הנתונים, טבלאות שהיו תלויות ב-`Production` (כמו `Contract` ו-`Feedback`) עודכנו. הוספנו להן עמודת `Title_ID` וקישרנו אותן לטבלת `Title` המאוחדת.
* **החלטה 5: הסרת ישויות ועמודות מיותרות** - לאחר וידוא שההעברה והקישורים החדשים בוצעו בהצלחה, הסרנו את התלות ב-`ProductionID` מטבלאות `Contract` ו-`Feedback`, ולבסוף מחקנו את טבלת `Production` שהפכה למיותרת.

#### תרשים ERD משולב

ה-ERD הבא מציג את המודל המאוחד של שתי המערכות לאחר האינטגרציה.

**(כאן יש להוסיף תמונה של תרשים ה-ERD המשולב)**
`![Combined ERD Diagram](קישור_לתמונת_ה-ERD_המשולב)`

#### תרשים DSD לאחר אינטגרציה

זהו תרשים ה-DSD הסופי לאחר ביצוע שינויי האינטגרציה על בסיס הנתונים שלנו.

**(כאן יש להוסיף תמונה של תרשים ה-DSD המעודכן)**
`![Integrated DSD Diagram](קישור_לתמונת_ה-DSD_המעודכן)`

#### שינוי מבנה בסיס הנתונים (Integrate.sql)

במקום ליצור מחדש את בסיס הנתונים, השתמשנו בפקודות `ALTER TABLE`, `INSERT INTO` ו-`UPDATE` כדי לעדכן את הסכמה הקיימת. להלן תיאור התהליך כפי שבוצע בקוד:

```sql
-- שינוי שם טבלת הפרסים של היוצרים למניעת קונפליקט
ALTER TABLE award RENAME TO creator_award;

-- שלב 1: העברת נתונים מטבלת Production ל-Title, תוך מניעת כפילויות
INSERT INTO Title (Title_ID, Title_Name, Age_Rating, Sequel_ID)
SELECT 
    (SELECT COALESCE(MAX(Title_ID), 0) FROM Title) + ROW_NUMBER() OVER (ORDER BY p.ProductionID) AS New_Title_ID,
    p.Title AS Title_Name,
    0 AS Age_Rating, -- Default value
    NULL AS Sequel_ID -- Default value
FROM Production p
WHERE p.Title IS NOT NULL 
  AND NOT EXISTS (
      SELECT 1 FROM Title t 
      WHERE LOWER(TRIM(t.Title_Name)) = LOWER(TRIM(p.Title))
  );

-- שלב 2: עדכון טבלת Contract כדי שתקשר ל-Title_ID
ALTER TABLE Contract ADD COLUMN Title_ID INT;
UPDATE Contract
SET Title_ID = (
    SELECT t.Title_ID 
    FROM Production p 
    JOIN Title t ON LOWER(TRIM(t.Title_Name)) = LOWER(TRIM(p.Title))
    WHERE p.ProductionID = Contract.ProductionID
    LIMIT 1
);
ALTER TABLE Contract
ADD CONSTRAINT fk_contract_title
FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID);

-- שלב 3: עדכון טבלת Feedback כדי שתקשר ל-Title_ID
ALTER TABLE Feedback ADD COLUMN Title_ID INT;
UPDATE Feedback
SET Title_ID = (
    SELECT t.Title_ID 
    FROM Production p 
    JOIN Title t ON LOWER(TRIM(t.Title_Name)) = LOWER(TRIM(p.Title))
    WHERE p.ProductionID = Feedback.ProductionID
    LIMIT 1
);
ALTER TABLE Feedback
ADD CONSTRAINT fk_feedback_title
FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID);

-- שלב 4: הסרת תלויות ישנות ומחיקת טבלת Production
ALTER TABLE Contract DROP CONSTRAINT IF EXISTS Contract_ProductionID_fkey;
ALTER TABLE Feedback DROP CONSTRAINT IF EXISTS Feedback_ProductionID_fkey;
ALTER TABLE Contract DROP COLUMN ProductionID;
ALTER TABLE Feedback DROP COLUMN ProductionID;
DROP TABLE Production;
