-- =================================================================================
--  קובץ SQL לשינוי סכמה קיימת לסכמה משולבת באמצעות פקודות ALTER TABLE
--  יש להריץ סקריפט זה על בסיס הנתונים המכיל את כל הטבלאות משני המקורות.
-- =================================================================================

-- שלב 1: איחוד וסידור טבלת הפרסים (Award)
-- ---------------------------------------------------------------------------------
-- התהליך: מחיקת הגרסה של נטפליקס והרחבת הגרסה של יוצרי התוכן.

-- 1.1: מחיקת טבלת Award של נטפליקס (זו עם המפתח המורכב).
DROP TABLE Award;

-- 1.2: שינוי שמה של טבלת הפרסים של יוצרי התוכן לשם הרשמי "Award"
-- הערה: אם יצרת את הטבלה השנייה בשם אחר (למשל Award_Creator), שנה את הפקודה בהתאם.
-- ALTER TABLE Award_Creator RENAME TO Award;

-- 1.3: הוספת עמודות חדשות לטבלת Award כדי שתכיל את כל המידע הנדרש
ALTER TABLE Award
    ADD COLUMN Given_By VARCHAR(50),
    ADD COLUMN Result VARCHAR(50),
    ADD COLUMN Title_ID INT;

-- 1.4: הפיכת העמודה CreatorID לאופציונלית (NULLABLE) כדי לאפשר פרס ליצירה בלבד
-- שימו לב: התחביר עשוי להשתנות מעט בין מערכות SQL. זהו תחביר סטנדרטי / MySQL.
ALTER TABLE Award MODIFY COLUMN CreatorID INT NULL;

-- 1.5: שינוי סוג הנתונים של שנת הפרס מ-DATE ל-INT
ALTER TABLE Award MODIFY COLUMN AwardYear INT;

-- 1.6: הוספת המפתח הזר המקשר לטבלת Title
ALTER TABLE Award ADD CONSTRAINT FK_Award_Title
    FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID);


-- שלב 2: התאמת טבלאות שהיו תלויות ב-Production
-- ---------------------------------------------------------------------------------
-- התהליך: שינוי טבלאות Contract ו-Feedback כך שיקושרו ל-Title במקום ל-Production.

-- 2.1: התאמת טבלת Contract
-- א. מחיקת המפתח הזר הישן המקשר ל-ProductionID. שם האילוץ עשוי להיות שונה במערכת שלך.
--    ב-MySQL, שם האילוץ הוא בדרך כלל 'Contract_ibfk_2'.
ALTER TABLE Contract DROP FOREIGN KEY Contract_ibfk_2; -- יש להתאים את שם האילוץ במידת הצורך
-- ב. שינוי שם העמודה ProductionID ל-Title_ID וסוג הנתונים שלה
ALTER TABLE Contract CHANGE COLUMN ProductionID Title_ID INT NOT NULL;
-- ג. הוספת המפתח הזר החדש המקשר ל-Title
ALTER TABLE Contract ADD CONSTRAINT FK_Contract_Title
    FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID);


-- 2.2: התאמת טבלת Feedback (אותו תהליך כמו ב-Contract)
-- א. מחיקת המפתח הזר הישן
ALTER TABLE Feedback DROP FOREIGN KEY Feedback_ibfk_1; -- יש להתאים את שם האילוץ במידת הצורך
-- ב. שינוי שם העמודה וסוגה
ALTER TABLE Feedback CHANGE COLUMN ProductionID Title_ID INT NOT NULL;
-- ג. הוספת המפתח הזר החדש
ALTER TABLE Feedback ADD CONSTRAINT FK_Feedback_Title
    FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID);


-- שלב 3: מחיקת טבלת Production שהפכה למיותרת
-- ---------------------------------------------------------------------------------
DROP TABLE Production;


-- שלב 4: תיקון מבני קטן בטבלאות נטפליקס
-- ---------------------------------------------------------------------------------
-- קוד ה-CREATE המקורי של Tv_show היה חסר הגדרת מפתח ראשי. פקודה זו מתקנת זאת.
ALTER TABLE Tv_show ADD PRIMARY KEY (Title_ID);


-- =================================================================================
--  סיום הסקריפט. הסכמה עודכנה למודל המשולב.
-- =================================================================================
