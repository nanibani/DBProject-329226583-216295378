-- Stage C: Integration Script
-- Merging the media content schema with the personnel and production schema.
-- Created: June 2025

------------------------------------------------------------
-- Step 1: Altering existing tables to add relationships
------------------------------------------------------------

-- Add columns to link tables from the different schemas
ALTER TABLE Title
ADD COLUMN ProductionID INT;

ALTER TABLE Title
ADD COLUMN CreatorID INT;

ALTER TABLE Contract
ADD COLUMN TitleID INT;

------------------------------------------------------------
-- Step 2: Creating Foreign Keys for Integration
------------------------------------------------------------

-- Link Title to Production
ALTER TABLE Title
ADD CONSTRAINT FK_Title_Production
FOREIGN KEY (ProductionID) REFERENCES Production(ProductionID);

-- Link Title to Content_Creator
ALTER TABLE Title
ADD CONSTRAINT FK_Title_Creator
FOREIGN KEY (CreatorID) REFERENCES Content_Creator(CreatorID);

-- Link Contract to a specific Title
ALTER TABLE Contract
ADD CONSTRAINT FK_Contract_Title
FOREIGN KEY (TitleID) REFERENCES Title(Title_ID);

------------------------------------------------------------
-- Step 3: Create a Unified Awards Table
------------------------------------------------------------

-- A new table to merge awards from both schemas
CREATE TABLE Unified_Award (
    UnifiedAwardID INT PRIMARY KEY,
    AwardName VARCHAR(100) NOT NULL,
    AwardYear DATE,
    AwardGivenBy VARCHAR(100),
    AwardResult VARCHAR(50),
    TitleID INT,
    CreatorID INT,
    AwardCategory VARCHAR(50) DEFAULT 'General',
    
    FOREIGN KEY (TitleID) REFERENCES Title(Title_ID),
    FOREIGN KEY (CreatorID) REFERENCES Content_Creator(CreatorID)
);

------------------------------------------------------------
-- Step 4: Create a Unified Title-Genre Link Table
------------------------------------------------------------

-- A new linking table to connect all titles (movies and TV shows) to genres
CREATE TABLE TitleGenre (
    TitleID INT NOT NULL,
    GenreID INT NOT NULL,
    PRIMARY KEY (TitleID, GenreID),
    FOREIGN KEY (TitleID) REFERENCES Title(Title_ID),
    FOREIGN KEY (GenreID) REFERENCES Genre(Genre_ID)
);

------------------------------------------------------------
-- Step 5: Augmenting the Production Table
------------------------------------------------------------

-- Add new columns to the Production table to match the unified schema
ALTER TABLE Production
ADD COLUMN Age_Rating INT;

ALTER TABLE Production
ADD COLUMN FranchiseID INT;

-- Link Production to a Franchise
ALTER TABLE Production
ADD CONSTRAINT FK_Production_Franchise
FOREIGN KEY (FranchiseID) REFERENCES Franchise(Franchise_ID);

------------------------------------------------------------
-- Step 6: Augmenting the Feedback Table
------------------------------------------------------------

-- Add a direct link from Feedback to a Title
ALTER TABLE Feedback
ADD COLUMN TitleID INT;

ALTER TABLE Feedback
ADD CONSTRAINT FK_Feedback_Title
FOREIGN KEY (TitleID) REFERENCES Title(Title_ID);

------------------------------------------------------------
-- Step 7: Create a Content Collaboration Table
------------------------------------------------------------

-- A new table to describe the work of creators on specific content
CREATE TABLE Content_Collaboration (
    CollaborationID INT PRIMARY KEY,
    CreatorID INT NOT NULL,
    TitleID INT NOT NULL,
    Role VARCHAR(100) NOT NULL,
    SeasonNumber INT NULL,
    EpisodeNumber INT NULL,
    StartDate DATE,
    EndDate DATE,
    
    FOREIGN KEY (CreatorID) REFERENCES Content_Creator(CreatorID),
    FOREIGN KEY (TitleID) REFERENCES Title(Title_ID),
    FOREIGN KEY (SeasonNumber, TitleID) REFERENCES Season(Season_Number, Title_ID),
    FOREIGN KEY (EpisodeNumber, SeasonNumber, TitleID) REFERENCES Episode(Episode_Number, Season_Number, Title_ID)
);

------------------------------------------------------------
-- Step 8: Integrated Constraints
------------------------------------------------------------

-- Add a default role for new collaborations
ALTER TABLE Content_Collaboration
ALTER COLUMN Role SET DEFAULT 'General Contributor';

-- Add a check constraint for collaboration dates
ALTER TABLE Content_Collaboration
ADD CONSTRAINT chk_Collaboration_Dates
CHECK (EndDate IS NULL OR EndDate >= StartDate);

-- Add a check constraint to ensure an award is associated with a title or a creator
ALTER TABLE Unified_Award
ADD CONSTRAINT chk_Award_Association
CHECK (TitleID IS NOT NULL OR CreatorID IS NOT NULL);

------------------------------------------------------------
-- Step 9: Data Migration Logic (Example Stubs)
------------------------------------------------------------

-- NOTE: The following INSERT statements are examples.
-- They should be adapted based on the existing data and table names after the merge.
-- It's recommended to rename old tables (e.g., 'ALTER TABLE Award RENAME TO Old_Award;') before migration.

/*
-- Example migration from an old media-related award table
INSERT INTO Unified_Award (UnifiedAwardID, AwardName, AwardGivenBy, AwardResult, TitleID, AwardCategory)
SELECT 
    ROW_NUMBER() OVER (ORDER BY Award_Name) as UnifiedAwardID,
    Award_Name,
    Given_By,
    Result,
    Title_ID,
    'Player Award'
FROM Old_Media_Award;

-- Example migration from an old creator-related award table
INSERT INTO Unified_Award (UnifiedAwardID, AwardName, AwardYear, CreatorID, AwardCategory)
SELECT 
    (SELECT COALESCE(MAX(UnifiedAwardID), 0) FROM Unified_Award) + ROW_NUMBER() OVER (ORDER BY AwardID) as UnifiedAwardID,
    AwardName,
    AwardYear,
    CreatorID,
    'Creator Award'
FROM Old_Creator_Award;
*/

------------------------------------------------------------
-- Step 10: Creating Views for easier data access
------------------------------------------------------------

-- A comprehensive view for all content-related information
CREATE VIEW Complete_Content_View AS
SELECT 
    t.Title_ID,
    t.Title_Name,
    t.Age_Rating,
    p.ProductionType,
    p.ReleaseDate,
    p.ProductionRating,
    cc.Content_CreatorFullName as Creator_Name,
    a.AgencyName,
    f.Franchise_Name,
    STRING_AGG(g.Genre_Name, ', ') as Genres
FROM Title t
LEFT JOIN Production p ON t.ProductionID = p.ProductionID
LEFT JOIN Content_Creator cc ON t.CreatorID = cc.CreatorID
LEFT JOIN Agent a ON cc.AgentID = a.AgentID
LEFT JOIN Belongs_to bt ON t.Title_ID = bt.Title_ID
LEFT JOIN Franchise f ON bt.Franchise_ID = f.Franchise_ID
LEFT JOIN TitleGenre tg ON t.Title_ID = tg.TitleID
LEFT JOIN Genre g ON tg.GenreID = g.Genre_ID
GROUP BY t.Title_ID, t.Title_Name, t.Age_Rating, p.ProductionType, 
         p.ReleaseDate, p.ProductionRating, cc.Content_CreatorFullName, 
         a.AgencyName, f.Franchise_Name;

-- A view for the unified awards data
CREATE VIEW All_Awards_View AS
SELECT 
    ua.UnifiedAwardID,
    ua.AwardName,
    ua.AwardYear,
    ua.AwardGivenBy,
    ua.AwardResult,
    ua.AwardCategory,
    t.Title_Name,
    cc.Content_CreatorFullName as Creator_Name
FROM Unified_Award ua
LEFT JOIN Title t ON ua.TitleID = t.Title_ID
LEFT JOIN Content_Creator cc ON ua.CreatorID = cc.CreatorID;

------------------------------------------------------------
-- Step 11: Adding Indexes for better performance
------------------------------------------------------------

-- Indexes on new foreign key columns to speed up joins
CREATE INDEX idx_title_production ON Title(ProductionID);
CREATE INDEX idx_title_creator ON Title(CreatorID);
CREATE INDEX idx_contract_title ON Contract(TitleID);
CREATE INDEX idx_feedback_title ON Feedback(TitleID);
CREATE INDEX idx_collaboration_creator_title ON Content_Collaboration(CreatorID, TitleID);
