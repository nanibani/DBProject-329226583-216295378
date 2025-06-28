CREATE OR REPLACE PROCEDURE manage_franchise_titles(
    p_franchise_id INTEGER,
    p_action VARCHAR(10)
)
LANGUAGE plpgsql AS $$
DECLARE
    title_cursor CURSOR FOR 
        SELECT t.title_id, t.title_name 
        FROM title t
        JOIN belongs_to bt ON t.title_id = bt.title_id
        WHERE bt.franchise_id = p_franchise_id;
    
    title_rec RECORD;
    title_count INTEGER := 0;
BEGIN
    IF p_action = 'COUNT' THEN
        -- ספירה ועדכון מספר הכותרים בפרנצ'יז
        FOR title_rec IN title_cursor LOOP
            title_count := title_count + 1;
            RAISE NOTICE 'Title: % (ID: %)', title_rec.title_name, title_rec.title_id;
        END LOOP;
        
        UPDATE franchise 
        SET number_of_titles = title_count 
        WHERE franchise_id = p_franchise_id;
        
        RAISE NOTICE 'Updated franchise % with % titles', p_franchise_id, title_count;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error in manage_franchise_titles: %', SQLERRM;
END;
$$;
