CREATE TRIGGER we_like_money
on DATABASE
FOR CREATE_TABLE, DROP_TABLE
AS
BEGIN
	PRINT 'Stop messing with our stuff please';
	ROLLBACK;
END;
