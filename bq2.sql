DROP FUNCTION IF EXISTS get_date(date);

CREATE OR REPLACE FUNCTION get_date (p_date IN DATE)
RETURNS TABLE (day TEXT, month TEXT, year TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        SUBSTRING(TO_CHAR(p_date, 'YYYY-MM-DD'), 9, 2) AS day,
        SUBSTRING(TO_CHAR(p_date, 'YYYY-MM-DD'), 6, 2) AS month,
        SUBSTRING(TO_CHAR(p_date, 'YYYY-MM-DD'), 1, 4) AS year;
END;
$$;
select * from get_date('2023-06-24');
