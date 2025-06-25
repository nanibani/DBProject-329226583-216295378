-- =========================================
-- VIEW 1: Movie Genre Analysis (אגף מקורי - סרטים/טלוויזיה)
-- =========================================
-- מבט המשלב מידע על סרטים עם הז'אנרים שלהם, כולל פרטי משך זמן ופרסים
CREATE VIEW MovieGenreAnalysis AS
SELECT 
    t.Title_ID,
    t.Title_Name,
    t.Age_Rating,
    m.Release_Date,
    m.Duration,
    m.Movie_Type,
    g.Genre_Name,
    COUNT(ca.Award_Name) AS Total_Awards,
    CASE 
        WHEN m.Duration > 150 THEN 'ארוך'
        WHEN m.Duration BETWEEN 90 AND 150 THEN 'בינוני'
        ELSE 'קצר'
    END AS Duration_Category
FROM Title t
JOIN Movie m ON t.Title_ID = m.Title_ID
JOIN MovieGenre mg ON t.Title_ID = mg.Title_ID
JOIN Genre g ON mg.Genre_ID = g.Genre_ID
LEFT JOIN Content_Award ca ON t.Title_ID = ca.Title_ID
GROUP BY t.Title_ID, t.Title_Name, t.Age_Rating, m.Release_Date, 
         m.Duration, m.Movie_Type, g.Genre_Name;

-- =========================================
-- VIEW 2: Content Creator Performance (אגף חדש - יוצרי תוכן)
-- =========================================
-- מבט המשלב מידע על יוצרי תוכן עם החוזים שלהם ופרסים
CREATE VIEW ContentCreatorPerformance AS
SELECT 
    cc.CreatorID,
    cc.Content_CreatorFullName,
    cc.Country,
    cc.IsActive,
    a.AgencyName,
    a.Email AS Agent_Email,
    COUNT(DISTINCT c.ContractID) AS Total_Contracts,
    AVG(c.Payment) AS Average_Payment,
    COUNT(DISTINCT caw.AwardID) AS Total_Awards,
    CASE 
        WHEN COUNT(DISTINCT c.ContractID) >= 5 THEN 'יוצר מנוסה'
        WHEN COUNT(DISTINCT c.ContractID) >= 2 THEN 'יוצר בינוני'
        ELSE 'יוצר מתחיל'
    END AS Experience_Level
FROM Content_Creator cc
LEFT JOIN Agent a ON cc.AgentID = a.AgentID
LEFT JOIN Contract c ON cc.CreatorID = c.CreatorID
LEFT JOIN Creator_Award caw ON cc.CreatorID = caw.CreatorID
GROUP BY cc.CreatorID, cc.Content_CreatorFullName, cc.Country, 
         cc.IsActive, a.AgencyName, a.Email;

-- =========================================
-- QUERIES FOR VIEW 1: MovieGenreAnalysis
-- =========================================

-- Query 1.1: סרטי אקשן ארוכים שזכו בפרסים
SELECT 
    Title_Name,
    Duration,
    Release_Date,
    Total_Awards
FROM MovieGenreAnalysis
WHERE Genre_Name = 'Action' 
  AND Duration_Category = 'ארוך'
  AND Total_Awards > 0
ORDER BY Total_Awards DESC, Duration DESC;

-- Query 1.2: סטטיסטיקה של ז'אנרים לפי משך זמן ממוצע
SELECT 
    Genre_Name,
    COUNT(*) AS Movies_Count,
    AVG(Duration) AS Average_Duration,
    MAX(Total_Awards) AS Max_Awards_Won
FROM MovieGenreAnalysis
GROUP BY Genre_Name
HAVING COUNT(*) >= 2
ORDER BY Average_Duration DESC;

-- =========================================
-- QUERIES FOR VIEW 2: ContentCreatorPerformance
-- =========================================

-- Query 2.1: יוצרי תוכן מנוסים עם תשלום גבוה
SELECT 
    Content_CreatorFullName,
    Country,
    AgencyName,
    Total_Contracts,
    Average_Payment,
    Total_Awards,
    Experience_Level
FROM ContentCreatorPerformance
WHERE Experience_Level = 'יוצר בינוני'
  AND Average_Payment > (SELECT AVG(Average_Payment) FROM ContentCreatorPerformance)
ORDER BY Average_Payment DESC;

-- Query 2.2: השוואה בין מדינות - ביצועי יוצרים
SELECT 
    Country,
    COUNT(*) AS Creators_Count,
    AVG(Total_Contracts) AS Avg_Contracts_Per_Creator,
    AVG(Average_Payment) AS Avg_Payment_Per_Creator,
    SUM(Total_Awards) AS Total_Country_Awards
FROM ContentCreatorPerformance
WHERE IsActive = TRUE
GROUP BY Country
HAVING COUNT(*) >= 2
ORDER BY Avg_Payment_Per_Creator DESC;
