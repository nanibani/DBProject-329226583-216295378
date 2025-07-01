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
    -   [שאילתות SELECT](#שאילתות-select)
    -   [שאילתות DELETE](#שאילתות-delete)
    -   [שאילתות UPDATE](#שאילתות-update)
7.  [סיכום שלבים א' ו-ב'](#סיכום-שלבים-א-ו-ב)
8.  [שלב ג' - אינטגרציה ומבטים](#שלב-ג---אינטגרציה-ומבטים)
    -   [הנדוס לאחור: המערכת הנוספת](#הנדוס-לאחור-המערכת-הנוספת)
    -   [תהליך האינטגרציה](#תהליך-האינטגרציה)
    -   [מבטים (Views)](#מבטים-views)
    -   [גיבוי מסד נתונים משולב](#גיבוי-מסד-נתונים-משולב)
9.  [שלב ד' - תכנות בסיס נתונים מתקדם](#שלב-ד---תכנות-בסיס-נתונים-מתקדם)
    -   [פונקציות (Functions)](#פונקציות-functions)
    -   [פרוצדורות (Procedures)](#פרוצדורות-procedures)
    -   [טריגרים (Triggers)](#טריגרים-triggers)
    -   [תוכניות ראשיות (Main Programs)](#תוכניות-ראשיות-main-programs)
    -   [קוד בדיקה מקיף](#קוד-בדיקה-מקיף)
10. [סיכום כללי](#סיכום-כללי)

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

## שאילתות - שלב ב'

### שאילתות SELECT

1.  **כל סרטי האקשן, ההרפתקאות והמותחן שיצאו לפני שנת 2000**
    ![image](https://github.com/user-attachments/assets/f2097d12-0eb0-4ae0-b8ff-d7c433101aa3)

2.  **קיבוץ סרטים לפי פרסים**
    ![image](https://github.com/user-attachments/assets/825761b0-a56f-4a38-999f-7dbc53229c90)

3.  **סדרות עם אורך פרק ממוצע מעל 50 דקות**
    ![image](https://github.com/user-attachments/assets/feb199ef-7932-40f7-bd41-7a0cf2bea6e1)

4.  **סדרות עם זמן שידור כולל מתחת ל־5 שעות**
    ![image](https://github.com/user-attachments/assets/4a9108e5-431f-4288-b117-b881f5cf329f)

5.  **איתור סרטי המשך עם פער זמן גדול מהסרט המקורי**
    ![Screenshot 2025-06-18 121604](https://github.com/user-attachments/assets/d3656337-2220-4fc9-b3ad-651932346adc)

6.  **ניתוח זכיינויות: סרטים לעומת סדרות**
    ![image](https://github.com/user-attachments/assets/4df46d2c-9a10-484d-aae7-81ad4c11cd23)

7.  **הסרט שזכה במרב הפרסים בכל ז'אנר**
    ![image](https://github.com/user-attachments/assets/ebda9a3d-56cb-44fe-b8f9-7eec047b3413)

8.  **כותרים מקוריים ומספר פרסים**
    ![image](https://github.com/user-attachments/assets/8448484e-2b8f-47dd-97d2-117acb21a5a7)

### שאילתות DELETE

1.  **מחיקת כותרים לפני 1975 שלא זכו בפרסים**
    ![delete1](https://github.com/user-attachments/assets/593bd7ad-b053-4ea7-8bc9-5d0a92294954)

2.  **מחיקת עונות מעל עונה 20**
    ![delete2](https://github.com/user-attachments/assets/9e608139-aeb9-4134-9619-f0b04c13d0af)

3.  **מחיקת כותרים מסדרת "הארי פוטר"**
    ![delete3](https://github.com/user-attachments/assets/9a43d45e-3053-42e0-8663-7f25169f7ca7)

### שאילתות UPDATE

1.  **עדכון דירוג גיל לסרטים לפני 2000**
    ![update1](https://github.com/user-attachments/assets/949bdbd2-3aa1-430f-ab3a-9778e761829f)

2.  **עדכון עונה ל־"Completed" אם כל הפרקים שודרו**
    ![update2](https://github.com/user-attachments/assets/e131fedc-1c5c-4fdd-80a2-c52c350967e7)

3.  **עדכון שם פרנצ'ייז ל־"DCU" אם מתחיל ב־"GOTHAM UNIVERS"**
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

![ERD_Diagram](https://github.com/user-attachments/assets/3ae5be5d-6ba0-4764-8a28-284a411eaa48)

### תהליך האינטגרציה

תהליך האינטגרציה התמקד במיזוג טבלת `Production` ממערכת היוצרים לתוך טבלת `Title` הקיימת במערכת שלנו, כדי ליצור ישות מרכזית ואחידה לכלל התכנים.

#### החלטות עיצוביות בתהליך האינטגרציה

-   **החלטה 1: מניעת קונפליקט שמות** - שינוי שמות הטבלאות ל-`Creator_Award` ו-`Content_Award`
-   **החלטה 2: מיזוג ישויות תוכן** - איחוד `Production` עם `Title`
-   **החלטה 3: העברת נתונים והימנעות מכפילויות** - העברה חכמה של נתונים
-   **החלטה 4: עדכון קשרי גומלין** - עדכון Foreign Keys
-   **החלטה 5: הסרת ישויות מיותרות** - ניקוי המבנה

#### תרשים ERD משולב

![Screenshot 2025-06-27 190419](https://github.com/user-attachments/assets/34381df1-1217-4d8b-bd5e-bd5d2d7978fb)

#### תרשים DSD לאחר אינטגרציה

![image](https://github.com/user-attachments/assets/e0312dca-9f81-40cc-88de-7da3a6e73fdc)

### מבטים (Views)

#### מבט 1: `MovieGenreAnalysis` (אגף התוכן – ניתוח סרטים לפי ז'אנר)

**תיאור המבט**: מרכז מידע על סרטים, כולל זיהוי הז'אנר, משך הזמן, תאריך יציאה ומספר הפרסים.

![image](https://github.com/user-attachments/assets/8a30a633-9d9c-4ddd-9270-f12e016dd727)

**שאילתה 1.1: סרטי אקשן ארוכים שזכו בפרסים**
![image](https://github.com/user-attachments/assets/ba1c9c00-3d43-4557-a73f-acc23fe30425)

**שאילתה 2.1: סטטיסטיקה של ז'אנרים לפי משך זמן ממוצע**
![image](https://github.com/user-attachments/assets/3338f182-0e3e-45ca-b93c-e040d12b4a6e)

#### מבט 2: `ContentCreatorPerformance` (אגף היוצרים – ביצועי יוצרי תוכן)

**תיאור המבט**: משלב מידע אישי על יוצרי תוכן עם נתוני סוכנים, חוזים, תשלומים ופרסים אישיים.

![Screenshot 2025-06-25 164632](https://github.com/user-attachments/assets/ae18070b-fae8-4f5d-ad20-5425969f7d3f)

**שאילתה 1.2: יוצרי תוכן מנוסים עם תשלום גבוה מהממוצע**
![image](https://github.com/user-attachments/assets/39fedb90-09eb-4ddf-bbe4-b4a54a4746a1)

**שאילתה 2.2: השוואת ביצועי יוצרים בין מדינות**
![image](https://github.com/user-attachments/assets/359718b9-6479-42f4-b19f-4945e1d28001)

---

## שלב ד' - תכנות בסיס נתונים מתקדם

בשלב זה פיתחנו תוכניות מתקדמות בסיס נתונים הכוללות פונקציות, פרוצדורות, טריגרים ותוכניות ראשיות. התוכניות מממשות פונקציונליות מגוונת לניהול ובקרת נתונים במערכת Netflix המשולבת.

### פונקציות (Functions)

#### פונקציה 1: חישוב סטטיסטיקות יוצר תוכן

**תיאור מילולי**: פונקציה זו מחזירה סטטיסטיקות מפורטות עבור יוצר תוכן נתון. הפונקציה מקבלת מזהה יוצר ומחזירה מצביע לתוצאה (REF CURSOR) הכולל את השם המלא של היוצר, המדינה, מספר החוזים הכולל וממוצע התשלומים.

```sql
CREATE OR REPLACE FUNCTION get_creator_statistics(p_creator_id INTEGER)
RETURNS REFCURSOR AS $$
DECLARE
    result_cursor REFCURSOR := 'creator_stats';
    creator_rec RECORD;
    contract_count INTEGER;
BEGIN
    -- בדיקת קיום היוצר
    SELECT INTO creator_rec * FROM content_creator WHERE creatorid = p_creator_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Creator with ID % not found', p_creator_id;
    END IF;
    
    -- ספירת חוזים
    SELECT COUNT(*) INTO contract_count 
    FROM contract WHERE creatorid = p_creator_id;
    
    OPEN result_cursor FOR
        SELECT cc.content_creatorfullname, cc.country, 
               contract_count as total_contracts,
               AVG(c.payment) as avg_payment
        FROM content_creator cc
        LEFT JOIN contract c ON cc.creatorid = c.creatorid
        WHERE cc.creatorid = p_creator_id
        GROUP BY cc.creatorid, cc.content_creatorfullname, cc.country;
    
    RETURN result_cursor;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

**הוכחת פעולה**: 
![image](https://github.com/user-attachments/assets/ffabbe89-6a2d-4d86-a602-44defb0ed8e5)


#### פונקציה 2: עדכון מספר עונות בסדרה

**תיאור מילולי**: פונקציה זו מעדכנת אוטומטית את מספר העונות בטבלת tv_show על סמך מספר העונות הקיימות בפועל בטבלת season.

```sql
CREATE OR REPLACE FUNCTION update_season_count(p_title_id INTEGER)
RETURNS INTEGER AS $$
DECLARE
    season_count INTEGER;
    title_exists BOOLEAN;
BEGIN
    -- בדיקת קיום הכותר
    SELECT EXISTS(SELECT 1 FROM tv_show WHERE title_id = p_title_id) INTO title_exists;
    
    IF NOT title_exists THEN
        RAISE EXCEPTION 'TV Show with ID % not found', p_title_id;
    END IF;
    
    -- ספירת עונות
    SELECT COUNT(*) INTO season_count 
    FROM season WHERE title_id = p_title_id;
    
    -- עדכון מספר העונות
    UPDATE tv_show 
    SET number_of_seasons = season_count 
    WHERE title_id = p_title_id;
    
    RETURN season_count;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error updating season count: %', SQLERRM;
        RETURN -1;
END;
$$ LANGUAGE plpgsql;
```

**הוכחת פעולה**: ![image](https://github.com/user-attachments/assets/09df440e-ae85-46f1-abbd-6b2f314901f9)


### פרוצדורות (Procedures)

#### פרוצדורה 1: ניהול פרנצ'יז

**תיאור מילולי**: פרוצדורה זו מבצעת פעולות ניהול על פרנצ'יז נתון. כרגע מממשת פעולת COUNT שסופרת ומעדכנת את מספר הכותרים השייכים לפרנצ'יז.

```sql
CREATE OR REPLACE PROCEDURE manage_franchise_titles(
    p_franchise_id INTEGER,
    p_action VARCHAR(10)
)
LANGUAGE plpgsql AS $$
DECLARE
    title_cursor CURSOR FOR 
        SELECT t.title_id, t.title_name 
        FROM title t
        JOIN belongs_to bt ON t.title_id = bt.title_id
        WHERE bt.franchise_id = p_franchise_id;
    
    title_rec RECORD;
    title_count INTEGER := 0;
BEGIN
    IF p_action = 'COUNT' THEN
        -- ספירה ועדכון מספר הכותרים בפרנצ'יז
        FOR title_rec IN title_cursor LOOP
            title_count := title_count + 1;
            RAISE NOTICE 'Title: % (ID: %)', title_rec.title_name, title_rec.title_id;
        END LOOP;
        
        UPDATE franchise 
        SET number_of_titles = title_count 
        WHERE franchise_id = p_franchise_id;
        
        RAISE NOTICE 'Updated franchise % with % titles', p_franchise_id, title_count;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error in manage_franchise_titles: %', SQLERRM;
END;
$$;
```

**הוכחת פעולה**: 
![image](https://github.com/user-attachments/assets/f4f8bd9b-a860-410a-8bbc-561ddfa4e6b5)


#### פרוצדורה 2: עדכון סטטוס עונות

**תיאור מילולי**: פרוצדורה זו עוברת על כל העונות במערכת ומעדכנת את הסטטוס שלהן בהתאם למספר הפרקים הקיימים.

```sql
CREATE OR REPLACE PROCEDURE update_seasons_status()
LANGUAGE plpgsql AS $$
DECLARE
    season_rec RECORD;
    episode_count INTEGER;
BEGIN
    -- לולאה על כל העונות
    FOR season_rec IN 
        SELECT title_id, season_number, number_of_episodes, current_status
        FROM season
    LOOP
        -- ספירת פרקים בפועל
        SELECT COUNT(*) INTO episode_count
        FROM episode 
        WHERE title_id = season_rec.title_id 
        AND season_number = season_rec.season_number;
        
        -- עדכון סטטוס בהתאם למספר הפרקים
        IF episode_count = 0 THEN
            UPDATE season 
            SET current_status = 'Upcoming'
            WHERE title_id = season_rec.title_id 
            AND season_number = season_rec.season_number;
        ELSIF episode_count < season_rec.number_of_episodes THEN
            UPDATE season 
            SET current_status = 'Ongoing'
            WHERE title_id = season_rec.title_id 
            AND season_number = season_rec.season_number;
        ELSE
            UPDATE season 
            SET current_status = 'Completed'
            WHERE title_id = season_rec.title_id 
            AND season_number = season_rec.season_number;
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error updating seasons status: %', SQLERRM;
END;
$$;
```

**הוכחת פעולה**: 
![image](https://github.com/user-attachments/assets/1e0b7d20-c512-447b-aab9-a8f62fde65aa)


### טריגרים (Triggers)

#### טריגר 1: עדכון אוטומטי של מספר הכותרים בפרנצ'יז

**תיאור מילולי**: טריגר זה מופעל אוטומטית בכל פעם שמתווסף או נמחק כותר מפרנצ'יז (טבלת belongs_to). הטריגר מעדכן אוטומטי את השדה number_of_titles בטבלת franchise.

```sql
CREATE OR REPLACE FUNCTION update_franchise_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE franchise 
        SET number_of_titles = number_of_titles + 1
        WHERE franchise_id = NEW.franchise_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE franchise 
        SET number_of_titles = number_of_titles - 1
        WHERE franchise_id = OLD.franchise_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_franchise_count
    AFTER INSERT OR DELETE ON belongs_to
    FOR EACH ROW
    EXECUTE FUNCTION update_franchise_count();
```

**הוכחת פעולה**: 
![image](https://github.com/user-attachments/assets/d95e5ac4-a220-4558-98b6-efdf1846cbb2)


#### טריגר 2: בדיקת תקינות חוזה

**תיאור מילולי**: טריגר זה מופעל לפני הוספה או עדכון של חוזה ובודק את תקינות הנתונים.

```sql
CREATE OR REPLACE FUNCTION validate_contract()
RETURNS TRIGGER AS $$
BEGIN
    -- בדיקה שתאריך התחלה קודם לתאריך סיום
    IF NEW.startdate >= NEW.enddate THEN
        RAISE EXCEPTION 'Start date must be before end date';
    END IF;
    
    -- בדיקה שהתשלום חיובי
    IF NEW.payment <= 0 THEN
        RAISE EXCEPTION 'Payment must be positive';
    END IF;
    
    RETURN NEW;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Contract validation failed: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validate_contract
    BEFORE INSERT OR UPDATE ON contract
    FOR EACH ROW
    EXECUTE FUNCTION validate_contract();
```

**הוכחת פעולה**: 
![image](https://github.com/user-attachments/assets/0f961c0d-a020-4797-be69-3eee29efa1a3)


### תוכניות ראשיות (Main Programs)

#### תוכנית ראשית 1: ניתוח סטטיסטיקות וניהול פרנצ'יז

**תיאור מילולי**: תוכנית זו משלבת שימוש בפונקציה לקבלת סטטיסטיקות יוצר תוכן ובפרוצדורה לניהול פרנצ'יז.

```sql
DO $$
DECLARE
    stats_cursor REFCURSOR;
    creator_id INTEGER := 1;
    season_count INTEGER;
BEGIN
    -- קריאה לפונקציה
    stats_cursor := get_creator_statistics(creator_id);
    
    -- קריאה לפרוצדורה
    CALL manage_franchise_titles(1, 'COUNT');
    
    RAISE NOTICE 'Main program 1 completed successfully';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error in main program 1: %', SQLERRM;
END;
$$;
```

**הוכחת פעולה**: 
![image](https://github.com/user-attachments/assets/661de9a4-c8f4-4d96-8501-b264bb4679e5)


#### תוכנית ראשית 2: עדכון עונות וסטטוס

**תיאור מילולי**: תוכנית זו מבצעת עדכון מקיף של נתוני הסדרות והעונות.


```sql
DO $$
DECLARE
    title_id INTEGER := 1;
    updated_seasons INTEGER;
BEGIN
    -- קריאה לפונקציה
    updated_seasons := update_season_count(title_id);
    
    -- קריאה לפרוצדורה
    CALL update_seasons_status();
    
    RAISE NOTICE 'Main program 2 completed. Updated % seasons', updated_seasons;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error in main program 2: %', SQLERRM;
END;
$$;
```

**הוכחת פעולה**: 
![image](https://github.com/user-attachments/assets/f25eaa95-5315-4d91-b870-efff500abf04)

---

### קוד בדיקה מקיף

להלן קוד בדיקה מקיף שבודק את כל הרכיבים שפותחו בשלב ד' שאת תוצאותיו הצגנו כהוכחת נכונות הקוד:

```sql
-- ======================================
-- קוד בדיקה מקיף לכל תוכניות שלב ד'
-- ======================================

DO $$
DECLARE
    -- משתנים לבדיקות
    test_cursor REFCURSOR;
    test_result INTEGER;
    creator_record RECORD;
    franchise_before INTEGER;
    franchise_after INTEGER;
    season_before INTEGER;
    season_after INTEGER;
    
BEGIN
    RAISE NOTICE '=== התחלת בדיקות מקיפות לשלב ד ===';
    RAISE NOTICE '';
    
    -- ======================================
    -- בדיקת פונקציה 1: get_creator_statistics
    -- ======================================
    RAISE NOTICE '--- בדיקת פונקציה 1: get_creator_statistics ---';
    
    BEGIN
        -- קריאה לפונקציה
        test_cursor := get_creator_statistics(351377597);
        
        -- קריאת התוצאות
        FETCH test_cursor INTO creator_record;
        
        IF FOUND THEN
            RAISE NOTICE 'פונקציה 1 פעלה בהצלחה!';
            RAISE NOTICE 'שם היוצר: %', creator_record.content_creatorfullname;
            RAISE NOTICE 'מדינה: %', creator_record.country;
            RAISE NOTICE 'מספר חוזים: %', creator_record.total_contracts;
            RAISE NOTICE 'ממוצע תשלום: %', creator_record.avg_payment;
        ELSE
            RAISE NOTICE 'פונקציה 1: לא נמצאו תוצאות';
        END IF;
        
        CLOSE test_cursor;
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'שגיאה בפונקציה 1: %', SQLERRM;
    END;
    
    RAISE NOTICE '';
    
    -- ======================================
    -- בדיקת פונקציה 2: update_season_count
    -- ======================================
    RAISE NOTICE '--- בדיקת פונקציה 2: update_season_count ---';
    
    BEGIN
        -- בדיקת מצב לפני
        SELECT number_of_seasons INTO season_before 
        FROM tv_show WHERE title_id = 1500;
        
        RAISE NOTICE 'מספר עונות לפני העדכון: %', COALESCE(season_before, 0);
        
        -- קריאה לפונקציה
        test_result := update_season_count(1500);
        
        -- בדיקת מצב אחרי
        SELECT number_of_seasons INTO season_after 
        FROM tv_show WHERE title_id = 1500;
        
        RAISE NOTICE 'פונקציה 2 פעלה בהצלחה!';
        RAISE NOTICE 'מספר עונות שנמצאו: %', test_result;
        RAISE NOTICE 'מספר עונות אחרי העדכון: %', COALESCE(season_after, 0);
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'שגיאה בפונקציה 2: %', SQLERRM;
    END;
    
    RAISE NOTICE '';
    
    -- ======================================
    -- בדיקת פרוצדורה 1: manage_franchise_titles
    -- ======================================
    RAISE NOTICE '--- בדיקת פרוצדורה 1: manage_franchise_titles ---';
    
    BEGIN
        -- בדיקת מצב לפני
        SELECT number_of_titles INTO franchise_before 
        FROM franchise WHERE franchise_id = 1;
        
        RAISE NOTICE 'מספר כותרים בפרנצ''יז לפני: %', COALESCE(franchise_before, 0);
        
        -- קריאה לפרוצדורה
        CALL manage_franchise_titles(1, 'COUNT');
        
        -- בדיקת מצב אחרי
        SELECT number_of_titles INTO franchise_after 
        FROM franchise WHERE franchise_id = 1;
        
        RAISE NOTICE 'פרוצדורה 1 פעלה בהצלחה!';
        RAISE NOTICE 'מספר כותרים בפרנצ''יז אחרי: %', COALESCE(franchise_after, 0);
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'שגיאה בפרוצדורה 1: %', SQLERRM;
    END;
    
    RAISE NOTICE '';
    
    -- ======================================
    -- בדיקת פרוצדורה 2: update_seasons_status
    -- ======================================
    RAISE NOTICE '--- בדיקת פרוצדורה 2: update_seasons_status ---';
    
    BEGIN
        RAISE NOTICE 'מפעיל פרוצדורה לעדכון סטטוס עונות...';
        
        -- קריאה לפרוצדורה
        CALL update_seasons_status();
        
        RAISE NOTICE 'פרוצדורה 2 פעלה בהצלחה!';
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'שגיאה בפרוצדורה 2: %', SQLERRM;
    END;
    
    RAISE NOTICE '';
    
    -- ======================================
    -- בדיקת טריגר 1: update_franchise_count
    -- ======================================
    RAISE NOTICE '--- בדיקת טריגר 1: update_franchise_count ---';
    
    BEGIN
        -- בדיקת מצב לפני
        SELECT number_of_titles INTO franchise_before 
        FROM franchise WHERE franchise_id = 1;
        
        RAISE NOTICE 'מספר כותרים בפרנצ''יז לפני הוספה: %', COALESCE(franchise_before, 0);
        
        -- הוספת כותר לפרנצ'יז (זה יפעיל את הטריגר)
        INSERT INTO belongs_to (title_id, franchise_id) 
        VALUES (999, 1)
        ON CONFLICT DO NOTHING;
        
        -- בדיקת מצב אחרי
        SELECT number_of_titles INTO franchise_after 
        FROM franchise WHERE franchise_id = 1;
        
        RAISE NOTICE 'מספר כותרים בפרנצ''יז אחרי הוספה: %', COALESCE(franchise_after, 0);
        
        -- מחיקת הכותר (זה יפעיל שוב את הטריגר)
        DELETE FROM belongs_to WHERE title_id = 999 AND franchise_id = 1;
        
        -- בדיקת מצב אחרי מחיקה
        SELECT number_of_titles INTO franchise_before 
        FROM franchise WHERE franchise_id = 1;
        
        RAISE NOTICE 'טריגר 1 פעל בהצלחה!';
        RAISE NOTICE 'מספר כותרים בפרנצ''יז אחרי מחיקה: %', COALESCE(franchise_before, 0);
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'שגיאה בטריגר 1: %', SQLERRM;
    END;
    
    RAISE NOTICE '';
    
-- ======================================
-- בדיקת טריגר 2: validate_contract
-- ======================================
RAISE NOTICE '--- בדיקת טריגר 2: validate_contract ---';

-- קודם כל, נוודא שיש לנו נתונים בסיסיים לבדיקה
-- (התאם את השמות בהתאם למבנה הטבלאות שלך)

-- בדיקה 1: חוזה תקין
BEGIN
    INSERT INTO contract (contractid, creatorid, title_id, startdate, enddate, payment)
    VALUES (9999, 
            (SELECT MIN(creatorid) FROM content_creator WHERE creatorid IS NOT NULL),  
            (SELECT MIN(title_id) FROM title WHERE title_id IS NOT NULL), 
            '2024-01-01', '2024-12-31', 50000);
    
    RAISE NOTICE 'טריגר 2: חוזה תקין נוסף בהצלחה';
    
    -- מחיקת החוזה הבדיקה
    DELETE FROM contract WHERE contractid = 9999;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'שגיאה בהוספת חוזה תקין: %', SQLERRM;
END;

-- בדיקה 2: חוזה עם תאריכים שגויים
BEGIN
    INSERT INTO contract (contractid, creatorid, title_id, startdate, enddate, payment)
    VALUES (9998, 
            (SELECT MIN(creatorid) FROM content_creator WHERE creatorid IS NOT NULL),
            (SELECT MIN(title_id) FROM title WHERE title_id IS NOT NULL), 
            '2024-12-31', '2024-01-01', 50000);
    
    RAISE NOTICE 'טריגר 2: שגיאה - חוזה עם תאריכים שגויים לא נדחה!';
    
    -- אם הגענו לכאן, צריך למחוק את החוזה
    DELETE FROM contract WHERE contractid = 9998;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'טריגר 2 פעל בהצלחה! נדחה חוזה עם תאריכים שגויים: %', SQLERRM;
END;

-- בדיקה 3: חוזה עם תשלום שלילי
BEGIN
    INSERT INTO contract (contractid, creatorid, title_id, startdate, enddate, payment)
    VALUES (9997, 
            (SELECT MIN(creatorid) FROM content_creator WHERE creatorid IS NOT NULL),  
            (SELECT MIN(title_id) FROM title WHERE title_id IS NOT NULL), 
            '2024-01-01', '2024-12-31', -1000);
    
    RAISE NOTICE 'טריגר 2: שגיאה - חוזה עם תשלום שלילי לא נדחה!';
    
    -- אם הגענו לכאן, צריך למחוק את החוזה
    DELETE FROM contract WHERE contractid = 9997;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'טריגר 2 פעל בהצלחה! נדחה חוזה עם תשלום שלילי: %', SQLERRM;
END;

RAISE NOTICE '';

-- גרסה חלופית אם אתה יודע את השמות המדויקים של העמודות:
/*
-- אם השמות שונים, השתמש בזה במקום:
-- החלף את שמות העמודות בהתאם למבנה הטבלאות שלך:
-- creatorid -> creator_id (אם זה השם הנכון)
-- agentid -> agent_id (אם זה השם הנכון)  
-- title_id -> titleid (אם זה השם הנכון)

-- לדוגמה:
INSERT INTO contract (contractid, creator_id, agent_id, titleid, startdate, enddate, payment)
VALUES (9999, 1, 1, 1, '2024-01-01', '2024-12-31', 50000);
*/
    RAISE NOTICE '';
    
    -- ======================================
    -- בדיקת תוכנית ראשית 1
    -- ======================================
    RAISE NOTICE '--- בדיקת תוכנית ראשית 1 ---';
    
    BEGIN
        DECLARE
            stats_cursor REFCURSOR;
            creator_id INTEGER :=351377597;
        BEGIN
            -- קריאה לפונקציה
            stats_cursor := get_creator_statistics(creator_id);
            
            -- קריאה לפרוצדורה
            CALL manage_franchise_titles(1, 'COUNT');
            
            RAISE NOTICE 'תוכנית ראשית 1 הושלמה בהצלחה';
        END;
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'שגיאה בתוכנית ראשית 1: %', SQLERRM;
    END;
    
    RAISE NOTICE '';
    
    -- ======================================
    -- בדיקת תוכנית ראשית 2
    -- ======================================
    RAISE NOTICE '--- בדיקת תוכנית ראשית 2 ---';
    
    BEGIN
        DECLARE
            title_id INTEGER := 1500;
            updated_seasons INTEGER;
        BEGIN
            -- קריאה לפונקציה
            updated_seasons := update_season_count(title_id);
            
            -- קריאה לפרוצדורה
            CALL update_seasons_status();
            
            RAISE NOTICE 'תוכנית ראשית 2 הושלמה בהצלחה. עודכנו % עונות', updated_seasons;
        END;
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'שגיאה בתוכנית ראשית 2: %', SQLERRM;
    END;
    
    RAISE NOTICE '';
    RAISE NOTICE '=== סיום בדיקות - כל התוכניות נבדקו ===';
    
END $$;
```
---
## סיכום שלב ד' - תכנות בסיס נתונים מתקדם
בשלב ד' העשרנו את המערכת בלוגיקה עסקית מתקדמת באמצעות PL/pgSQL. פיתחנו פונקציות לחישובים מורכבים, פרוצדורות לאוטומציה של תהליכים, טריגרים לשמירה על תקינות ועקביות הנתונים, ותוכניות ראשיות המשלבות את כל היכולות הללו. בניית סקריפט בדיקה מקיף הבטיחה את אמינות כל הרכיבים. שלב זה הפך את בסיס הנתונים ממחסן נתונים סטטי למערכת דינמית, חכמה ויעילה.
---

# 🎬 מערכת ניהול מדיה – ממשק משתמש גרפי

## שלב ה׳ - GUI עם Tkinter

---

### 🧰 דרישות והתקנה

-   **Python 3.6+**
-   **PostgreSQL 12+**
-   **psycopg2**: `pip install psycopg2-binary`

---

### 🗄️ מבנה בסיס הנתונים

האפליקציה מתחברת לבסיס הנתונים ודורשת את הטבלאות שנוצרו בשלבים הקודמים, ובפרט: **title**, **franchise**, ו-**belongs_to** לניהול הבסיסי, וכן טבלאות נוספות (**movie**, **tv_show**, **genre** וכו') לצורך הרצת השאילתות המתקדמות.

---

### ▶️ הוראות הפעלה

1.  **הגדרת חיבור**: בקובץ `app.py`, יש לעדכן את פרטי החיבור למסד הנתונים של PostgreSQL.
    ```python
    self.conn = psycopg2.connect(
        dbname="your_db",
        user="your_user",
        password="your_password",
        host="localhost",
        port="5432"
    )
    ```
2.  **הרצת האפליקציה**:
    ```bash
    python app.py
    ```

---

### 🛠️ כלים וטכנולוגיות

-   **שפת תכנות**: Python 3.8
-   **ממשק משתמש**: Tkinter
-   **בסיס נתונים**: PostgreSQL 12
-   **ספריית חיבור**: psycopg2
-   **שפת תכנות בבסיס הנתונים**: PL/pgSQL

---

### 🖼️ ממשק גרפי – מבנה האפליקציה

האפליקציה מורכבת ממסך ראשי המאפשר ניווט למסכים ייעודיים:
![image](https://github.com/user-attachments/assets/0d8f35e9-54b7-426c-8445-1b7a3ccabea8)


-   **ניהול כותרים (Titles)**: הוספה, עדכון, מחיקה וצפייה בכותרים.
  ![image](https://github.com/user-attachments/assets/440c8957-1564-4dea-8859-9a3b1d051d0f)

-   **ניהול פרנצ'ייזים (Franchises)**: ניהול מלא (CRUD) של פרנצ'ייזים.
   ![image](https://github.com/user-attachments/assets/5c7cf055-4b28-4d7a-88e6-8407420dec5d)

-   **ניהול קישורים (Belongs To)**: יצירה ומחיקה של קשרים בין כותר לפרנצ'ייז.
   ![image](https://github.com/user-attachments/assets/08b419ca-5dca-4a30-9b3f-676800d7f8bf)

-   **שאילתות ופונקציות מתקדמות**: הרצת שאילתות מורכבות ופונקציות שהוגדרו בשלב ב' וד'.
  ### השאילתות משלב ב':

    ![image](https://github.com/user-attachments/assets/4d18ba36-1bb0-41b3-adbb-78899b4d4370)


### הפונקציה והפרוצדורה משלב ד':
![image](https://github.com/user-attachments/assets/270e2e92-951b-40dc-98ff-4a5f9fb7407e)



---

## סיכום כללי

פרויקט זה מדגים פיתוח מערכת מקיפה לניהול תוכן מדיה, החל מתכנון בסיס הנתונים ועד למימוש ממשק משתמש גרפי מלא.

### הישגים עיקריים:

-   **שלב א' - תשתית נתונים**: תכנון ERD/DSD, יצירת טבלאות והזנת נתונים.
-   **שלב ב' - שאילתות מתקדמות**: מימוש שאילתות SELECT, DELETE, UPDATE מורכבות.
-   **שלב ג' - אינטגרציה**: שילוב מוצלח של שתי מערכות נפרדות ויצירת מבטים (Views).
-   **שלב ד' - תכנות מתקדם**: שימוש בפונקציות, פרוצדורות וטריגרים למימוש לוגיקה עסקית.
-   **שלב ה' - ממשק משתמש**: בניית GUI מלא וידידותי ב-Python ו-Tkinter.
