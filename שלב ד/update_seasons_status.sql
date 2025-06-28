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
