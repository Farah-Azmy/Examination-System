ALTER PROCEDURE UpdateTopic 
    @oldtopicname VARCHAR(50),
    @newtopicname VARCHAR(50)
AS
BEGIN
    -- Update the Topic table for the specified old TopicName
    UPDATE Topic 
    SET TopicName = @newtopicname
    WHERE TopicName = @oldtopicname;
END;