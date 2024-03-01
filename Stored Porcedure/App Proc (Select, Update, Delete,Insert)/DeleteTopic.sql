CREATE PROCEDURE DeleteTopic 
    @topicname VARCHAR(50)
AS
BEGIN
    -- Update the Topic table for the specified old TopicName
    DELETE FROM Topic 
    WHERE TopicName = @topicname
END;
