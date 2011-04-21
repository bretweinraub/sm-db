
CREATE or REPLACE FUNCTION timestamp_insert() RETURNS trigger AS $timestamp_insert$
    BEGIN
        -- Check that empname and salary are given
        IF NEW.created_at IS NULL THEN
	   NEW.created_at := now();
        END IF;
        RETURN NEW;
    END;
$timestamp_insert$ LANGUAGE plpgsql;
