-- RollbackCommit.sql

-- #####################################################################
-- Section 8: Demonstrating ROLLBACK
-- #####################################################################

-- Step 1: Start a new transaction
BEGIN TRANSACTION;

-- Step 2: Show the initial state of some data we plan to change.
-- Let's assume we'll update a Franchise name.
-- Replace 'Some Existing Franchise Name' with an actual franchise name from your DB for a real test,
-- or pick a Franchise_ID. For this example, let's pick Franchise_ID = 1 if it exists.
SELECT Franchise_ID, Franchise_Name, Number_of_titles
FROM Franchise
WHERE Franchise_ID = 1; -- Choose an existing Franchise_ID

-- Step 3: Perform an update
UPDATE Franchise
SET Franchise_Name = 'Temporary Name for Rollback Test', Number_of_titles = Number_of_titles + 10
WHERE Franchise_ID = 1; -- Use the same Franchise_ID

-- Step 4: Show the state of the data *within the current uncommitted transaction*
-- You should see 'Temporary Name for Rollback Test' and the updated Number_of_titles.
SELECT Franchise_ID, Franchise_Name, Number_of_titles
FROM Franchise
WHERE Franchise_ID = 1;

-- Step 5: Perform a ROLLBACK
ROLLBACK;

-- Step 6: Show the state of the data *after the ROLLBACK*
-- The data should have reverted to its state from before Step 3.
-- You should see the original Franchise_Name and original Number_of_titles.
SELECT Franchise_ID, Franchise_Name, Number_of_titles
FROM Franchise
WHERE Franchise_ID = 1;

-- End of Section 8 demonstration.
-- If you started the transaction with BEGIN TRANSACTION, it's now closed due to ROLLBACK.

-- #####################################################################
-- Section 9: Demonstrating COMMIT
-- #####################################################################

-- Step 1: Start a new transaction
BEGIN TRANSACTION;

-- Step 2: Show the initial state of some data we plan to change.
-- Let's use a different example, perhaps updating a Movie's release date.
-- Pick an existing Movie's Title_ID. For this example, let's use Title_ID = 101 (assuming it's a movie).
SELECT M.Title_ID, T.Title_Name, M.Release_Date
FROM Movie M
JOIN Title T ON M.Title_ID = T.Title_ID
WHERE M.Title_ID = 101; -- Choose an existing Movie Title_ID

-- Step 3: Perform an update
UPDATE Movie
SET Release_Date = '2025-12-31' -- Assign a new date
WHERE Title_ID = 101; -- Use the same Movie Title_ID

-- Step 4: Show the state of the data *within the current uncommitted transaction*
-- You should see the new Release_Date ('2025-12-31').
SELECT M.Title_ID, T.Title_Name, M.Release_Date
FROM Movie M
JOIN Title T ON M.Title_ID = T.Title_ID
WHERE M.Title_ID = 101;

-- Step 5: Perform a COMMIT
COMMIT;

-- Step 6: Show the state of the data *after the COMMIT*
-- The data should remain as it was in Step 4 because the changes were made permanent.
-- You should still see the new Release_Date ('2025-12-31').
SELECT M.Title_ID, T.Title_Name, M.Release_Date
FROM Movie M
JOIN Title T ON M.Title_ID = T.Title_ID
WHERE M.Title_ID = 101;

-- Step 7 (Optional): Verify in a *new, separate session/connection*
-- If you open a completely new connection to the database and run the SELECT query from Step 6,
-- you will also see the committed changes ('2025-12-31'). This confirms the change is persistent
-- and visible to other transactions/sessions.

-- End of Section 9 demonstration.
-- If you started the transaction with BEGIN TRANSACTION, it's now closed due to COMMIT.
