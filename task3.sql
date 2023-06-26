-- QUERY 3

CREATE OR REPLACE FUNCTION yearly_tournament(t_year int) 
RETURNS table (tournament_name varchar,
			   tour_type varchar,
			   is_open boolean,
			   country varchar
			   )  
LANGUAGE plpgsql  
AS  
$$  
BEGIN 
    RETURN QUERY
    SELECT t1.name,t1.tour_type,t1.is_open,t1.country
	FROM tournament t1 JOIN tournament_entry t2 on t1.tourid = t2.tourid
	WHERE t2.year = t_year;
End;  
$$;  
SELECT * from yearly_tournament(2023);
