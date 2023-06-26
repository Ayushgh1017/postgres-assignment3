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
