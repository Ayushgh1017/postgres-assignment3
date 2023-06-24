---------------ASSIGNMENT 3--------------------------------

-- QUERY 1

CREATE OR REPLACE PROCEDURE entry(member_name varchar, tournament_name varchar, tyear INT)
LANGUAGE plpgsql
AS $$
DECLARE
    memid INT;
    tid INT;
BEGIN
    SELECT memberid INTO memid FROM member where firstname=member_name;
    SELECT tourid INTO tid FROM tournament where name = tournament_name;
    
    INSERT INTO tournament_entry (memberid, tourid, year)
    VALUES (memid, tid, tyear);
END;
$$;
call entry('Sachin','Tournament 2',2022)
select * from member;
select * from tournament_entry

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

-- QUERY 4

create or replace procedure manager_details1(manager_name varchar(100),team_name varchar(100))
language plpgsql
as $$
-- declare firstname int;
-- declare teamname int;
begin
    update member set firstname = manager_name where teamid = 
	(select teamid from team where teamname = team_name and memberid = manager);
end; $$
CALL manager_details1('Ameya', 'Team A');
CALL manager_details1('Aman', 'Team B');
select * from member;

-- QUERY 5
CREATE OR REPLACE FUNCTION team_details(team_name varchar) 
RETURNS table (member_firstname varchar,member_lastname varchar,
			   membershiptype varchar,joindate date,gender varchar)  
LANGUAGE plpgsql
AS  
$$  
BEGIN 
    RETURN QUERY
    SELECT m1.firstname,m1.lastname,m2.type,m1.joindate,m1.gender
	FROM member m1 JOIN membertype m2 on m1.membertypeid = m2.id
	JOIN team m3 on m1.teamid = m3.teamid
	where m3.teamname = team_name;
End;  
$$;  

select * from member join team on team.manager = member.memberid;
SELECT * from team_details('Team A');
select * from member

-- QUERY 6

create or replace procedure coach_details(coach_name varchar(100), member_name varchar(100))
language plpgsql
as $$
begin
    if not exists(select * from member where firstname=member_name)
	then
	raise 'Member name doesnt exist';
    else
        update member set firstname = coach_name where memberid
		= (select coachid from member where firstname = member_name );
    end if;
end; $$
-- Member doesn't exist
call coach_details('Ameya','Anuj');
select m.memberid,m.firstname, c.firstname as coach ,c.memberid , c.teamid from member m left join member c on m.coachid = c.memberid;

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

--QUERY 2
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

drop function currentdate()