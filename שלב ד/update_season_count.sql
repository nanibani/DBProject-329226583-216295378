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
