-- BONUS PROBLEMS
-- QUERY 1
CREATE OR REPLACE FUNCTION swap_num( INOUT x int, INOUT y int)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT x, y INTO y, x;
END;
$$;
SELECT * FROM swap_num(2, 3)
