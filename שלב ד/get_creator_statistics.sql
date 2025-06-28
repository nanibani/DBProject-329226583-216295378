CREATE OR REPLACE FUNCTION get_creator_statistics(p_creator_id INTEGER)
RETURNS REFCURSOR AS $$
DECLARE
    result_cursor REFCURSOR := 'creator_stats';
    creator_rec RECORD;
    contract_count INTEGER;
BEGIN
    -- בדיקת קיום היוצר
    SELECT INTO creator_rec * FROM content_creator WHERE creatorid = p_creator_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Creator with ID % not found', p_creator_id;
    END IF;
    
    -- ספירת חוזים
    SELECT COUNT(*) INTO contract_count 
    FROM contract WHERE creatorid = p_creator_id;
    
    OPEN result_cursor FOR
        SELECT cc.content_creatorfullname, cc.country, 
               contract_count as total_contracts,
               AVG(c.payment) as avg_payment
        FROM content_creator cc
        LEFT JOIN contract c ON cc.creatorid = c.creatorid
        WHERE cc.creatorid = p_creator_id
        GROUP BY cc.creatorid, cc.content_creatorfullname, cc.country;
    
    RETURN result_cursor;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;
