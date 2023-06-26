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
