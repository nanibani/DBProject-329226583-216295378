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
.### שימוש בכלי Mockaroo



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

## סיכום שלבים א' ו-ב'

בשלב א' הגדרנו תשתית נתונים מלאה למערכת מדיה, כולל ERD, DSD, טבלאות, והזנת נתונים. בשלב ב' הראינו שאילתות מתקדמות מסוג SELECT, DELETE ו־UPDATE. התקדמנו לבניית מערכת ניתוח וניהול תוכן בפלטפורמה מתקדמת לניהול מדיה דיגיטלית.

---

## שלב ג' - אינטגרציה ומבטים

בשלב זה ביצענו אינטגרציה של מערכת ניהול התוכן שלנו (אגף תוכן וסוגי מדיה) עם מערכת ניהול יוצרים והפקות. התהליך כלל הנדוס לאחור, יצירת מודל נתונים משולב, שינוי סכמת בסיס הנתונים הקיים והגדרת מבטים (Views) לניתוח הנתונים המאוחדים.

### הנדוס לאחור: המערכת הנוספת

קיבלנו גיבוי של בסיס נתונים של אגף ניהול יוצרים, סוכנים, חוזים והפקות. ביצענו הנדוס לאחור כדי להבין את מבנה הנתונים שלו.

#### תרשים DSD של המערכת הנוספת
![DSD_Diagram](https://github.com/user-attachments/assets/bd248f24-a1b6-4704-9c1e-918e421178d0)



#### תרשים ERD של המערכת הנוספת

מתוך ה-DSD, יצרנו את תרשים ה-ERD המייצג את הישויות והקשרים במערכת ניהול היוצרים.

![ERD_Diagram](https://github.com/user-attachments/assets/3ae5be5d-6ba0-4764-8a28-284a411eaa48)

---

### תהליך האינטגרציה

תהליך האינטגרציה התמקד במיזוג טבלת `Production` ממערכת היוצרים לתוך טבלת `Title` הקיימת במערכת שלנו, כדי ליצור ישות מרכזית ואחידה לכלל התכנים.

#### החלטות עיצוביות בתהליך האינטגרציה

* **החלטה 1: מניעת קונפליקט שמות** - במערכת היוצרים הייתה טבלה בשם `Award`, אך גם במערכת התוכן ישנה טבלה כזו. ולכן כדי למנוע התנגשות, שינינו את שמות הטבלאות ל-`Creator_Award` שמייצגת את הפרסים ליוצרים, ול-`Content_Award` המייצגת את הפרסים שקיבלו הסרטים.
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

![image](https://github.com/user-attachments/assets/94568426-f408-4324-9b65-02f3dd9f3a53)


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

```
# מבטים (Views) וניתוח נתונים

מסמך זה מציג שני מבטים שנוצרו על סמך שילוב נתונים בין מערכות שונות (אגף תוכן ואגף יוצרי תוכן), כולל שאילתות ניתוח עיקריות.

---

## מבט 1: `MovieGenreAnalysis`  
**(אגף התוכן – ניתוח סרטים לפי ז'אנר)**

### תיאור המבט  
מבט זה מרכז מידע על סרטים, כולל זיהוי הז'אנר, משך הזמן, תאריך יציאה ומספר הפרסים שהסרט זכה בהם. בנוסף, כל סרט מקבל סיווג לפי קטגוריית משך זמן: `קצר`, `בינוני` או `ארוך`.  

המטרה: לספק כלי ניתוח השוואתי בין ז'אנרים לפי אורך סרטים, הצלחה בפרסים ועוד.

---
### שליפת נתונים:
![image](https://github.com/user-attachments/assets/8a30a633-9d9c-4ddd-9270-f12e016dd727)

### שאילתה 1.1: סרטי אקשן ארוכים שזכו בפרסים
**תיאור**
השאילתה מאתרת סרטי אקשן שזמן ההקרנה שלהם מוגדר כ"ארוך" (מעל 150 דקות), ושזכו בלפחות פרס אחד. התוצאות ממוינות לפי מספר הפרסים (מהרב לפחות), ובתוך זה לפי אורך הסרט.
![image](https://github.com/user-attachments/assets/ba1c9c00-3d43-4557-a73f-acc23fe30425)

### שאילתה 2.1: סטטיסטיקה של ז'אנרים לפי משך זמן ממוצע
**תיאור**
השאילתה מספקת סיכום סטטיסטי לכל ז'אנר – כולל מספר הסרטים, משך זמן ממוצע לסרט, ומקסימום פרסים לסרט בז'אנר. מוצגים רק ז'אנרים שבהם יש לפחות שני סרטים.
![image](https://github.com/user-attachments/assets/3338f182-0e3e-45ca-b93c-e040d12b4a6e)

_ _ _

## מבט 2: ContentCreatorPerformance
**(אגף היוצרים – ביצועי יוצרי תוכן)**

### תיאור המבט
מבט זה משלב מידע אישי על יוצרי תוכן עם נתוני סוכנים, חוזים, תשלומים ופרסים אישיים. כל יוצר מקבל דירוג ניסיון לפי מספר החוזים: מתחיל, בינוני או מנוסה.

המטרה: לספק תשתית לניתוח מקצועי של ביצועי יוצרים והשוואה בין מדינות וסוכנויות.

### שליפת נתונים:
![image](https://github.com/user-attachments/assets/a564f840-1922-418f-9346-16ccebce1577)

### שאילתה 1.2: יוצרי תוכן מנוסים עם תשלום גבוה מהממוצע
**תיאור**
השאילתה מאתרת יוצרי תוכן שמדורגים כ־"מנוסים" (לפחות 5 חוזים) ושקיבלו בממוצע תשלום גבוה מהממוצע של כלל היוצרים. המטרה היא לאתר יוצרי תוכן בולטים ומשתלמים במיוחד.
![image](https://github.com/user-attachments/assets/39fedb90-09eb-4ddf-bbe4-b4a54a4746a1)

### שאילתה 2.2: השוואת ביצועי יוצרים בין מדינות
**תיאור**
השאילתה מספקת ניתוח השוואתי של מדינות לפי יוצרי תוכן פעילים בלבד – כולל מספר יוצרים, ממוצע חוזים, ממוצע תשלום וסה"כ פרסים. מוצגות רק מדינות עם לפחות שני יוצרים פעילים.
![image](https://github.com/user-attachments/assets/359718b9-6479-42f4-b19f-4945e1d28001)

