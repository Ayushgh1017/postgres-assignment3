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
