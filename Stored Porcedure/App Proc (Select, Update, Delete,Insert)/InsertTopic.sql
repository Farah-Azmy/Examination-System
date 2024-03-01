CREATE PROCEDURE InsertTopic 
    @topicid INT,  -- assuming @topicid is provided
    @topicname VARCHAR(50)
AS
BEGIN
    -- Enable identity insert for the Topic table
    SET IDENTITY_INSERT Topic ON;

    -- Insert a new topic into the Topic table with the provided TopicID
    INSERT INTO Topic (TopicID, TopicName)
    VALUES (@topicid, @topicname);

    -- Disable identity insert after the operation
    SET IDENTITY_INSERT Topic OFF;
END;