-- QUERY 7
CREATE OR REPLACE FUNCTION no_participants(in t_year int,OUT nums int)
LANGUAGE plpgsql
AS
$$ 
BEGIN
  SELECT
      COUNT(*) INTO nums
  FROM tournament_entry
  WHERE tournament_entry.year=t_year;
END;
$$;
select * from no_participants(2022);
select * from tournament
