-- Section 1: Creating the New Tables
-- These are the tables you provided that need to be added to your existing schema.

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

CREATE TABLE Production (
    ProductionID INT PRIMARY KEY,
    Title VARCHAR(100), -- Note: This 'Title' column in Production is a string name, not a foreign key to Title.Title_ID yet.
    ProductionType VARCHAR(50),
    ReleaseDate DATE,
    Genre VARCHAR(50),
    ProductionRating DECIMAL(3,1)
);

CREATE TABLE Contract (
    ContractID INT PRIMARY KEY,
    CreatorID INT,
    ProductionID INT,
    StartDate DATE,
    EndDate DATE,
    Payment DECIMAL(10,2),
    RoleContract VARCHAR(50),
    FOREIGN KEY (CreatorID) REFERENCES Content_Creator(CreatorID),
    FOREIGN KEY (ProductionID) REFERENCES Production(ProductionID)
);

-- IMPORTANT: You already have an 'Award' table in your existing schema.
-- The new 'Award' table has a different primary key and structure.
-- To avoid naming conflicts, we will rename this new Award table to 'Creator_Award'
-- to distinguish it as awards specifically for Content_Creators.
CREATE TABLE Creator_Award (
    AwardID INT PRIMARY KEY,
    CreatorID INT,
    AwardName VARCHAR(100),
    AwardYear DATE,
    FOREIGN KEY (CreatorID) REFERENCES Content_Creator(CreatorID)
);

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY,
    ProductionID INT,
    FeedbackDate DATE,
    FeedbackRating DECIMAL(2,1),
    FeedbackComment TEXT,
    FOREIGN KEY (ProductionID) REFERENCES Production(ProductionID)
);

---

-- Section 2: Establishing Relationships between Existing and New Tables
-- The most logical link is between your existing 'Title' table and the new 'Production' table.
-- We assume that a 'Production' can correspond to a 'Title' in your existing system.

-- Add a foreign key column to the Production table to link it to the existing Title table.
-- This allows a 'Production' to be associated with a 'Title' (Movie or TV Show) in your main system.
ALTER TABLE Production
ADD COLUMN Title_ID INT;

-- Add the foreign key constraint. We make it nullable in case some productions
-- don't directly map to an existing 'Title' (e.g., internal productions not released yet).
ALTER TABLE Production
ADD CONSTRAINT FK_Production_Title_ID
FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID);

-- 'Award' table can also be given to a Content_Creator,
ALTER TABLE Award
ADD COLUMN CreatorID INT;
ALTER TABLE Award
ADD CONSTRAINT FK_Award_Creator
FOREIGN KEY (CreatorID) REFERENCES Content_Creator(CreatorID);
---

-- Section 3: Applying Constraints to the New Tables
-- These constraints were specified for the new tables.

-- Constraint 1: NOT NULL on Agent.Email
-- Ensure existing NULL values are updated before applying NOT NULL constraint
UPDATE Agent
SET Email = 'default@email.com'
WHERE Email IS NULL;
ALTER TABLE Agent
ALTER COLUMN Email SET NOT NULL;

-- Constraint 2: CHECK on Production.ProductionRating between 0 and 10
-- Ensure existing values are within range before applying CHECK constraint
UPDATE Production
SET ProductionRating = 5.0
WHERE ProductionRating < 0 OR ProductionRating > 10;
ALTER TABLE Production
ADD CONSTRAINT chk_ProductionRating
CHECK (ProductionRating >= 0 AND ProductionRating <= 10);

-- Constraint 3: DEFAULT on Feedback.FeedbackRating
-- Update existing NULLs (though DEFAULT only applies to new inserts without value)
UPDATE Feedback
SET FeedbackRating = 5.0
WHERE FeedbackRating IS NULL;
ALTER TABLE Feedback
ALTER COLUMN FeedbackRating SET DEFAULT 5.0;

-- Constraint 4: CHECK on FeedbackRating between 1 and 10
-- Ensure existing values are within range before applying CHECK constraint
UPDATE Feedback
SET FeedbackRating = 5.0
WHERE FeedbackRating < 1 OR FeedbackRating > 10;
ALTER TABLE Feedback
ADD CONSTRAINT chk_FeedbackRating
CHECK (FeedbackRating >= 1 AND FeedbackRating <= 10);

-- Constraint 5: DEFAULT on Feedback.FeedbackDate
-- Update existing NULLs (though DEFAULT only applies to new inserts without value)
UPDATE Feedback
SET FeedbackDate = CURRENT_DATE
WHERE FeedbackDate IS NULL;
ALTER TABLE Feedback
ALTER COLUMN FeedbackDate SET DEFAULT CURRENT_DATE;

-- Constraint 6: CHECK on Contract.Payment must be positive
-- Ensure existing values are non-negative before applying CHECK constraint
UPDATE Contract
SET Payment = 0
WHERE Payment < 0;
ALTER TABLE Contract
ADD CONSTRAINT chk_PaymentPositive
CHECK (Payment >= 0);

-- Constraint 7: CHECK on Contract.EndDate must be after StartDate
-- Ensure existing dates are valid before applying CHECK constraint
UPDATE Contract
SET EndDate = StartDate + INTERVAL '30 days' -- Adjust this logic if needed for existing invalid data
WHERE EndDate <= StartDate;
ALTER TABLE Contract
ADD CONSTRAINT chk_ContractDates
CHECK (EndDate > StartDate);

-- Constraint 8: CHECK on Creator_Award.AwardYear between 1900 and today
-- Ensure existing values are valid before applying CHECK constraint
UPDATE Creator_Award
SET AwardYear = CURRENT_DATE
WHERE AwardYear < '1900-01-01' OR AwardYear > CURRENT_DATE;
ALTER TABLE Creator_Award
ADD CONSTRAINT chk_AwardYear
CHECK (AwardYear BETWEEN '1900-01-01' AND CURRENT_DATE);
