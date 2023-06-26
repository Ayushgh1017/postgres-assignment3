-- QUERY 2

CREATE OR REPLACE FUNCTION tournament(IN tour_year int, OUT no_of_t int) 
--RETURNS int  
LANGUAGE plpgsql  
AS  
$$  
DECLARE  
    --number_of_tournaments integer;  
BEGIN  
    select COUNT(*) into no_of_t from tournament_entry  where 
	tour_year = year GROUP BY year;
    --RETURN number_of_tournaments;  
End;  
$$; 
SELECT * from tournament(2023);
select * from tournament_entry;
