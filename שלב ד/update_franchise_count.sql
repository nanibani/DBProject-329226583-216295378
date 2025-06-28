CREATE OR REPLACE FUNCTION update_franchise_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE franchise 
        SET number_of_titles = number_of_titles + 1
        WHERE franchise_id = NEW.franchise_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE franchise 
        SET number_of_titles = number_of_titles - 1
        WHERE franchise_id = OLD.franchise_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_franchise_count
    AFTER INSERT OR DELETE ON belongs_to
    FOR EACH ROW
    EXECUTE FUNCTION update_franchise_count();
