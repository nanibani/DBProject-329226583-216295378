-- Constraints.sql

-- Constraint 1: CHECK constraint on the Episode table
-- Ensures that the duration of an episode is a positive number.
ALTER TABLE Episode
ADD CONSTRAINT CK_Episode_Duration CHECK (Duration > 0);

-- Constraint 2: DEFAULT constraint on the Season table
-- Sets a default status for a new season, e.g., 'Upcoming', if no status is provided.
ALTER TABLE Season
ALTER COLUMN current_Status SET DEFAULT 'Upcoming';
-- Note: For some SQL dialects like MySQL, the syntax might be:
-- ALTER TABLE Season
-- MODIFY current_Status VARCHAR(10) DEFAULT 'Upcoming';
-- Or if the column already has NOT NULL and you only want to add DEFAULT:
-- ALTER TABLE Season
-- ALTER current_Status SET DEFAULT 'Upcoming';
-- Please use the syntax appropriate for your specific RDBMS. The one above is common for PostgreSQL/SQL Server.

-- Constraint 3: UNIQUE constraint on the Franchise table
-- Ensures that franchise names are unique, in addition to Franchise_ID being the primary key.
ALTER TABLE Franchise
ADD CONSTRAINT UQ_Franchise_Name UNIQUE (Franchise_Name);
