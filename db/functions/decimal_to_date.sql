

CREATE OR REPLACE FUNCTION DECIMAL_TO_DATE (
	num	number
) RETURNS VARCHAR AS $$
declare 	retval 	varchar(32);
BEGIN
	select replace (trunc (num) || ':' || to_char (trunc (((num - trunc (num)) * 60)), '09'), ' ', '') into retval;
	return retval;
END;
$$ language plpgsql;

