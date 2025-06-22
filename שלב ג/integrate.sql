-- Simple Database Integration Script
-- Transfer Production data to Title table and update dependencies

-- =========================================
-- STEP 1: Transfer Production data to Title table (avoid duplicates)
-- =========================================

-- Insert new titles from Production that don't already exist in Title
INSERT INTO Title (Title_ID, Title_Name, Age_Rating, Sequel_ID)
SELECT 
    (SELECT COALESCE(MAX(Title_ID), 0) FROM Title) + ROW_NUMBER() OVER (ORDER BY p.ProductionID) AS New_Title_ID,
    p.Title AS Title_Name,
    0 AS Age_Rating,      -- Default value
    NULL AS Sequel_ID     -- Default value
FROM Production p
WHERE p.Title IS NOT NULL 
  AND NOT EXISTS (
      SELECT 1 FROM Title t 
      WHERE LOWER(TRIM(t.Title_Name)) = LOWER(TRIM(p.Title))
  );

-- =========================================
-- STEP 2: Update Contract table to reference Title_ID
-- =========================================

-- Add Title_ID column to Contract
ALTER TABLE Contract ADD COLUMN Title_ID INT;

-- Update Contract with Title_ID based on title name matching
UPDATE Contract
SET Title_ID = (
    SELECT t.Title_ID 
    FROM Production p 
    JOIN Title t ON LOWER(TRIM(t.Title_Name)) = LOWER(TRIM(p.Title))
    WHERE p.ProductionID = Contract.ProductionID
    LIMIT 1
);

-- Add foreign key constraint
ALTER TABLE Contract
ADD CONSTRAINT fk_contract_title
FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID);

-- =========================================
-- STEP 3: Update Feedback table to reference Title_ID
-- =========================================

-- Add Title_ID column to Feedback
ALTER TABLE Feedback ADD COLUMN Title_ID INT;

-- Update Feedback with Title_ID based on title name matching
UPDATE Feedback
SET Title_ID = (
    SELECT t.Title_ID 
    FROM Production p 
    JOIN Title t ON LOWER(TRIM(t.Title_Name)) = LOWER(TRIM(p.Title))
    WHERE p.ProductionID = Feedback.ProductionID
    LIMIT 1
);

-- Add foreign key constraint
ALTER TABLE Feedback
ADD CONSTRAINT fk_feedback_title
FOREIGN KEY (Title_ID) REFERENCES Title(Title_ID);

-- =========================================
-- STEP 4: Remove old dependencies and drop Production table
-- =========================================

-- Remove ProductionID foreign key constraints
ALTER TABLE Contract DROP CONSTRAINT IF EXISTS Contract_ProductionID_fkey;
ALTER TABLE Contract DROP CONSTRAINT IF EXISTS fk_contract_production;
ALTER TABLE Feedback DROP CONSTRAINT IF EXISTS Feedback_ProductionID_fkey;
ALTER TABLE Feedback DROP CONSTRAINT IF EXISTS fk_feedback_production;

-- Drop ProductionID columns
ALTER TABLE Contract DROP COLUMN ProductionID;
ALTER TABLE Feedback DROP COLUMN ProductionID;

-- Drop the Production table
DROP TABLE Production;
