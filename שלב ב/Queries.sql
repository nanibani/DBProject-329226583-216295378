-- ====================================================================
--      Final Consolidated File of All Updated SELECT Queries
-- ====================================================================


-- 1. Selects action, adventure, and thriller movies before 2000
--    (Simple version showing each genre match in a separate row)
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
    T.Title_Name, M.Release_Date;


-- 2. Groups movies by awards won
--    (Simple version showing counts of movies and award givers)
SELECT
    A.Award_Name,
    COUNT(DISTINCT T.Title_ID) AS Number_of_Movies_Won,
    COUNT(DISTINCT A.Given_By) AS Number_of_Award_Givers
FROM
    Award A
JOIN
    Title T ON A.Title_ID = T.Title_ID
WHERE
    A.Result = 'Won' AND T.Title_ID IN (SELECT Title_ID FROM Movie)
GROUP BY
    A.Award_Name
ORDER BY
    Number_of_Movies_Won DESC;


-- 3. Selects TV shows with an average episode length over 50 minutes
--    (Includes the fix for the ROUND function error)
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
    AVG(E.Duration) > 50
ORDER BY
    Average_Episode_Duration DESC;


-- 4. Selects TV shows with a total runtime under 5 hours
SELECT
    T.Title_Name,
    SUM(E.Duration) AS Total_Runtime_Minutes,
    TV.number_of_seasons AS Declared_Seasons
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
    SUM(E.Duration) < 300
ORDER BY
    Total_Runtime_Minutes ASC;


-- 5. Selects movies that are a sequel to a TV show
SELECT
    T1.Title_Name AS Movie_Title,
    T2.Title_Name AS Prequel_TV_Show,
    M.Release_Date AS Movie_Release_Date,
    M.Duration AS Movie_Duration
FROM
    Title T1
JOIN
    Movie M ON T1.Title_ID = M.Title_ID
JOIN
    Title T2 ON T1.Sequel_ID = T2.Title_ID
JOIN
    TV_show TV ON T2.Title_ID = TV.Title_ID
ORDER BY
    Movie_Release_Date;


-- 6. Displays a summary for each franchise
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
    Total_Titles DESC, F.Franchise_Name;


-- 7. Finds TV shows with at least one completed season
SELECT
    T.Title_Name,
    TV.number_of_seasons AS Declared_Total_Seasons,
    COUNT(DISTINCT S.Season_Number) AS Seasons_In_DB,
    SUM(S.Number_of_episodes) AS Total_Episodes_In_DB
FROM
    Title T
JOIN
    Tv_show TV ON T.Title_ID = TV.Title_ID
JOIN
    Season S ON TV.Title_ID = S.Title_ID
WHERE
    T.Title_ID IN (SELECT DISTINCT S_inner.Title_ID FROM Season S_inner WHERE S_inner.current_Status = 'Completed')
GROUP BY
    T.Title_ID, T.Title_Name, TV.number_of_seasons
ORDER BY
    Total_Episodes_In_DB DESC, T.Title_Name;


-- 8. Displays titles that are not sequels, sorted by the number of awards won
SELECT
    T.Title_Name,
    T.Age_Rating,
    COUNT(A.Title_ID) AS Total_Award_Mentions,
    SUM(CASE WHEN A.Result = 'Won' THEN 1 ELSE 0 END) AS Awards_Won
FROM
    Title T
LEFT JOIN
    Award A ON T.Title_ID = A.Title_ID
WHERE
    T.Sequel_ID IS NULL
GROUP BY
    T.Title_ID, T.Title_Name, T.Age_Rating
ORDER BY
    Awards_Won DESC, Total_Award_Mentions DESC, T.Title_Name;

--delete queries
--Delete all titles from before the year 1975 that have not won any awards
DELETE FROM Movie
WHERE Title_ID IN (
    SELECT M.Title_ID
    FROM Movie M
    JOIN Title T ON M.Title_ID = T.Title_ID
    WHERE M.Release_Date < '1975-01-01'
      AND NOT EXISTS (
          SELECT 1 FROM Award A
          WHERE A.Title_ID = M.Title_ID AND A.Result = 'Won'
      )
);
DELETE FROM TV_show
WHERE Title_ID IN (
    SELECT TV.Title_ID
    FROM TV_show TV
    JOIN Title T ON TV.Title_ID = T.Title_ID
    WHERE NOT EXISTS (
        SELECT 1 FROM Award A
        WHERE A.Title_ID = TV.Title_ID AND A.Result = 'Won'
    )
    AND NOT EXISTS (
        SELECT 1 FROM Episode E
        WHERE E.Title_ID = TV.Title_ID AND E.Date_Aired >= '1975-01-01'
    )
);
DELETE FROM Title
WHERE Title_ID NOT IN (SELECT Title_ID FROM Movie)
  AND Title_ID NOT IN (SELECT Title_ID FROM TV_show);

  --Delete all tv seasons numbered above 20
  DELETE FROM Episode
WHERE (Season_Number, Title_ID) IN (
    SELECT Season_Number, Title_ID
    FROM Season
    WHERE Season_Number > 20
);

DELETE FROM Season
WHERE Season_Number > 20;


--Delete all titles that belong to the Harry Potter franchise
-- Delete from Award
DELETE FROM Award
WHERE Title_ID IN (
    SELECT B.Title_ID
    FROM Belongs_to B
    JOIN Franchise F ON B.Franchise_ID = F.Franchise_ID
    WHERE F.Franchise_Name = 'Harry Potter'
);

-- Delete from MovieGenre
DELETE FROM MovieGenre
WHERE Title_ID IN (
    SELECT B.Title_ID
    FROM Belongs_to B
    JOIN Franchise F ON B.Franchise_ID = F.Franchise_ID
    WHERE F.Franchise_Name = 'Harry Potter'
);

-- Delete from Season
DELETE FROM Season
WHERE Title_ID IN (
    SELECT B.Title_ID
    FROM Belongs_to B
    JOIN Franchise F ON B.Franchise_ID = F.Franchise_ID
    WHERE F.Franchise_Name = 'Harry Potter'
);

-- Delete from Episode
DELETE FROM Episode
WHERE Title_ID IN (
    SELECT B.Title_ID
    FROM Belongs_to B
    JOIN Franchise F ON B.Franchise_ID = F.Franchise_ID
    WHERE F.Franchise_Name = 'Harry Potter'
);

-- Delete from Movie
DELETE FROM Movie
WHERE Title_ID IN (
    SELECT B.Title_ID
    FROM Belongs_to B
    JOIN Franchise F ON B.Franchise_ID = F.Franchise_ID
    WHERE F.Franchise_Name = 'Harry Potter'
);

-- Delete from TV_show
DELETE FROM TV_show
WHERE Title_ID IN (
    SELECT B.Title_ID
    FROM Belongs_to B
    JOIN Franchise F ON B.Franchise_ID = F.Franchise_ID
    WHERE F.Franchise_Name = 'Harry Potter'
);

-- Delete from Belongs_to (association table)
DELETE FROM Belongs_to
WHERE Franchise_ID = (
    SELECT Franchise_ID FROM Franchise WHERE Franchise_Name = 'Harry Potter'
);

DELETE FROM Title
WHERE Title_ID IN (
    SELECT B.Title_ID
    FROM Belongs_to B
    JOIN Franchise F ON B.Franchise_ID = F.Franchise_ID
    WHERE F.Franchise_Name = 'Harry Potter'
);

--Update queries
-- Updating a film released before 2000 for a more stringent age rating, because the content is no longer appropriate according to modern age standards. 
UPDATE Title
SET Age_Rating = 18
WHERE Title_ID IN (
  SELECT T.Title_ID
  FROM Title T
  JOIN Movie M ON T.Title_ID = M.Title_ID
  WHERE M.Release_Date < '2000-01-01'
);

--Updating the status of season to complite when all the episode already brodcasted
UPDATE Season
SET Status = 'Completed'
WHERE EXISTS (
  SELECT 1
  FROM Episode E
  WHERE E.Title_ID = Season.Title_ID
    AND E.Season_Number = Season.Season_Number
    AND E.Date_Aired < CURRENT_DATE
  GROUP BY E.Season_Number, E.Title_ID
  HAVING COUNT(*) = (
    SELECT S.Number_of_episodes
    FROM Season S
    WHERE S.Title_ID = E.Title_ID AND S.Season_Number = E.Season_Number
  )
);

--updatding the name of the franchise if his branded was changed
UPDATE Franchise
SET Franchise_Name = 'The Adventures Reborn'
WHERE Franchise_ID IN (
  SELECT Franchise_ID
  FROM Belongs_to
  JOIN Title ON Belongs_to.Title_ID = Title.Title_ID
  WHERE Title.Title_Name LIKE 'The Adventures%'
);
