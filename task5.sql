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

