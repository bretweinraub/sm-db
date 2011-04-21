
CREATE or REPLACE FUNCTION timestamp_update() RETURNS trigger AS $timestamp_update$
    BEGIN
        -- Check that empname and salary are given
        IF NEW.updated_at IS NULL THEN
	   NEW.updated_at := now();
        END IF;
        RETURN NEW;
    END;
$timestamp_update$ LANGUAGE plpgsql;
