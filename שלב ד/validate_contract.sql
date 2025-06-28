CREATE OR REPLACE FUNCTION validate_contract()
RETURNS TRIGGER AS $$
BEGIN
    -- בדיקה שתאריך התחלה קודם לתאריך סיום
    IF NEW.startdate >= NEW.enddate THEN
        RAISE EXCEPTION 'Start date must be before end date';
    END IF;
    
    -- בדיקה שהתשלום חיובי
    IF NEW.payment <= 0 THEN
        RAISE EXCEPTION 'Payment must be positive';
    END IF;
    
    RETURN NEW;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Contract validation failed: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validate_contract
    BEFORE INSERT OR UPDATE ON contract
    FOR EACH ROW
    EXECUTE FUNCTION validate_contract();
