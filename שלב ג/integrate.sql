-- Step 1: Create new unified schema
CREATE SCHEMA integrated;

SET search_path TO integrated;

-- --- UNIFIED TABLES ---

CREATE TABLE Title (
    Title_ID INT PRIMARY KEY,
    Title_Name VARCHAR(200) NOT NULL,
    Age_Rating INT NOT NULL,
    Sequel_ID INT,
    ProductionType VARCHAR(50),
    Release_Date DATE,
    ProductionRating DECIMAL(3,1)
);

CREATE TABLE Genre (
    Genre_ID INT PRIMARY KEY,
    Genre_Name VARCHAR(50) NOT NULL
);

CREATE TABLE MovieGenre (
    Title_ID INT,
    Genre_ID INT,
    PRIMARY KEY (Title_ID, Genre_ID),
    FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID),
    FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
);

CREATE TABLE Movie (
    Title_ID INT PRIMARY KEY,
    Duration INT NOT NULL,
    Movie_Type VARCHAR(50) NOT NULL,
    FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID)
);

CREATE TABLE Tv_show (
    Title_ID INT PRIMARY KEY,
    number_of_seasons INT NOT NULL,
    FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID)
);

CREATE TABLE Season (
    Title_ID INT,
    Season_Number INT,
    Number_of_episodes INT,
    current_Status VARCHAR(10),
    PRIMARY KEY (Season_Number, Title_ID),
    FOREIGN KEY (Title_ID) REFERENCES Tv_show(Title_ID)
);

CREATE TABLE Episode (
    Title_ID INT,
    Season_Number INT,
    Episode_Number INT,
    Duration INT,
    Date_Aired DATE,
    PRIMARY KEY (Episode_Number, Season_Number, Title_ID),
    FOREIGN KEY (Season_Number, Title_ID) REFERENCES Season(Season_Number, Title_ID)
);

CREATE TABLE Franchise (
    Franchise_ID INT PRIMARY KEY,
    Franchise_Name VARCHAR(50) NOT NULL,
    Number_of_titles INT NOT NULL
);

CREATE TABLE Belongs_to (
    Franchise_ID INT,
    Title_ID INT,
    PRIMARY KEY (Franchise_ID, Title_ID),
    FOREIGN KEY (Franchise_ID) REFERENCES Franchise(Franchise_ID),
    FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID)
);

-- Unified Award table
CREATE TABLE Award (
    AwardID INT PRIMARY KEY,
    AwardName VARCHAR(100),
    AwardYear DATE,
    Result VARCHAR(50),
    CreatorID INT,
    Title_ID INT,
    FOREIGN KEY (CreatorID) REFERENCES Content_Creator(CreatorID),
    FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID)
);

-- Personnel system
CREATE TABLE Agent (
    AgentID INT PRIMARY KEY,
    AgentFullName VARCHAR(100),
    AgencyName VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100)
);

CREATE TABLE Content_Creator (
    CreatorID INT PRIMARY KEY,
    Content_CreatorFullName VARCHAR(100),
    BirthDate DATE,
    Country VARCHAR(50),
    IsActive BOOLEAN,
    JoinDate DATE,
    AgentID INT,
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID)
);

CREATE TABLE Contract (
    ContractID INT PRIMARY KEY,
    CreatorID INT,
    Title_ID INT,
    StartDate DATE,
    EndDate DATE,
    Payment DECIMAL(10,2),
    RoleContract VARCHAR(50),
    FOREIGN KEY (CreatorID) REFERENCES Content_Creator(CreatorID),
    FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID)
);

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY,
    Title_ID INT,
    FeedbackDate DATE,
    FeedbackRating DECIMAL(2,1),
    FeedbackComment TEXT,
    FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID)
);

-- === MIGRATE DATA ===

-- Merge Title + Production
INSERT INTO integrated.Title (Title_ID, Title_Name, Age_Rating, Sequel_ID, ProductionType, Release_Date, ProductionRating)
SELECT 
    t.Title_ID,
    t.Title_Name,
    t.Age_Rating,
    t.Sequel_ID,
    p."ProductionType",
    p."ReleaseDate",
    p."ProductionRating"
FROM media_db."Title" t
LEFT JOIN personnel_db."Production" p ON t.Title_ID = p."ProductionID";

-- Genres
INSERT INTO integrated.Genre SELECT * FROM media_db."Genre";
INSERT INTO integrated.MovieGenre SELECT * FROM media_db."MovieGenre";

-- Movies
INSERT INTO integrated.Movie SELECT Title_ID, Duration, Movie_Type FROM media_db."Movie";

-- TV Shows
INSERT INTO integrated.Tv_show SELECT * FROM media_db."Tv_show";
INSERT INTO integrated.Season SELECT * FROM media_db."Season";
INSERT INTO integrated.Episode SELECT * FROM media_db."Episode";

-- Franchise
INSERT INTO integrated.Franchise SELECT * FROM media_db."Franchise";
INSERT INTO integrated.Belongs_to SELECT * FROM media_db."Belongs_to";

-- Agents & Creators
INSERT INTO integrated.Agent SELECT * FROM personnel_db."Agent";
INSERT INTO integrated.Content_Creator SELECT * FROM personnel_db."Content_Creator";

-- Contract (maps to Title_ID)
INSERT INTO integrated.Contract (ContractID, CreatorID, Title_ID, StartDate, EndDate, Payment, RoleContract)
SELECT ContractID, CreatorID, "ProductionID", "StartDate", "EndDate", Payment, "RoleContract"
FROM personnel_db."Contract";

-- Feedback (maps to Title_ID)
INSERT INTO integrated.Feedback (FeedbackID, Title_ID, FeedbackDate, FeedbackRating, FeedbackComment)
SELECT FeedbackID, "ProductionID", FeedbackDate, FeedbackRating, FeedbackComment
FROM personnel_db."Feedback";

-- Unified Award Table
-- Awards from creators
INSERT INTO integrated.Award (AwardID, AwardName, AwardYear, Result, CreatorID, Title_ID)
SELECT 
    AwardID,
    AwardName,
    AwardYear,
    'Won', -- assuming all were won
    CreatorID,
    NULL -- no associated title
FROM personnel_db."Award";

-- Awards from media titles
-- Generate new Award IDs to avoid conflict
INSERT INTO integrated.Award (AwardID, AwardName, AwardYear, Result, CreatorID, Title_ID)
SELECT 
    nextval('award_id_seq'), -- requires: CREATE SEQUENCE award_id_seq START 100000;
    "Award_Name",
    CURRENT_DATE, -- replace with actual award year if available
    "Result",
    NULL,
    "Title_ID"
FROM media_db."Award";
