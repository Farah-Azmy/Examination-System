create Database ExaminationSystemDB
-----------------------------------------------------------------------------1
CREATE TABLE Branch(
	 BranchID INT PRIMARY KEY NOT NULL,
	 BranchLocation VARCHAR(50),
	 BranchManager VARCHAR(50)
);
------------------------------------------------------------------------------9
CREATE TABLE Course(
	CourseID INT PRIMARY KEY NOT NULL,
	InstructorID INT,
	CourseName VARCHAR(255),
	CourseDuration INT,

CONSTRAINT FK_Course_Instructor FOREIGN KEY(InstructorID) REFERENCES Instructor(InstructorID)
 );

---------------------------------------------------------------------------------------2
CREATE TABLE Topic(
	TopicID INT PRIMARY KEY NOT NULL,
	TopicName VARCHAR(50) NOT NULL
);
------------------------------------------------------------------------------------8
CREATE TABLE Track(
	TrackID INT PRIMARY KEY NOT NULL ,
	InstructorID INT,
	TrackName VARCHAR(50),
	HiringDate DateTime,

CONSTRAINT FK_Track_Instructor FOREIGN KEY(InstructorID) REFERENCES Instructor(InstructorID)
);
ALTER TABLE Track ADD HiringDate DATETIME;
--------------------------------------------------------------------------------------10
CREATE TABLE TrackCourse(
	TrackID INT NOT NULL,
	CourseID INT NOT NULL,
	HiringDate DateTime,
CONSTRAINT FK_TrackCourse_Course FOREIGN KEY(CourseID) REFERENCES Course(CourseID),
CONSTRAINT FK_TrackCourse_Track FOREIGN KEY(TrackID) REFERENCES Track(TrackID),
CONSTRAINT PK_TrackCourse PRIMARY KEY(TrackID,CourseID)
);
ALTER TABLE TrackCourse DROP COLUMN HiringDate;

--------------------------------------------------------------------------------11
CREATE TABLE CourseTopic(
	TopicID INT NOT NULL,
	CourseID INT PRIMARY KEY  NOT NULL,

CONSTRAINT FK_CourseTopic_Topic FOREIGN KEY(TopicID) REFERENCES Topic(TopicID)
);
--------------------------------------------------------------------------------4
CREATE TABLE Student(
	StudentID INT PRIMARY KEY  NOT NULL,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Age INT CHECK (Age BETWEEN 22 AND 35),
	Gender VARCHAR(50),
	Phone int,
	[Location] VARCHAR(50),
	Faculty VARCHAR(50),
	GraduationYear INT,
	Email VARCHAR(50) NOT NULL CHECK (EMAIL LIKE '%_@%.%'), 
    [Password] VARCHAR(50) NOT NULL);
ALTER TABLE Student
ADD TrackID INT,
CONSTRAINT Fk_TrackIDStudent FOREIGN kEY (TrackID) REFERENCES Track(TrackID);

---------------------------------------------------------------------------3
CREATE TABLE Instructor(
	InstructorID INT PRIMARY KEY  NOT NULL,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Age INT,
	Gender VARCHAR(6),
	Phone int,
	[Location] VARCHAR(50),
	WorkingStatus VARCHAR(50) CHECK (WorkingStatus IN ('Onsite','Remote','Hybrid')),
	Salary INT,
	HiringDate datetime,
);
-------------------------------------------------------------------------5
CREATE TABLE CertificationKPI(
 CertificationID INT NOT NULL,
 StudentID  INT NOT NULL,
 CertificationName VARCHAR(50),
 Duration INT,
 Platform  VARCHAR(50)
 
CONSTRAINT Fk_StudentID FOREIGN kEY (StudentID) REFERENCES Student(StudentID)
CONSTRAINT PK_CertificationKPI PRIMARY KEY(CertificationID,StudentID)
 );
----------------------------------------------------------------6
CREATE TABLE FreelancingKPI(
 FreelanceID INT NOT NULL,
 StudentID INT NOT NULL,
 TrackName  VARCHAR(50),
 JobDescription  VARCHAR(255),
 Tool  VARCHAR(50),
 [Platform]  VARCHAR(50),
 Duration INT,
 Cost INT,

CONSTRAINT FK_FreelancingKPI FOREIGN kEY (StudentID) REFERENCES Student(StudentID),
CONSTRAINT PK_FreelancingKPI PRIMARY KEY(FreelanceID,StudentID)
);
---------------------------------------------------------------------7
CREATE TABLE JobKPI(
 HiringID INT  NOT NULL,
 StudentID INT,
 [Position] VARCHAR(50),
 CompanyName VARCHAR(50),
 HiringDate DATETIME,

CONSTRAINT Fk_StudentID_JobKPI FOREIGN kEY (StudentID) REFERENCES Student(StudentID),
CONSTRAINT PK_JobKPI PRIMARY KEY(HiringID,StudentID)
);
---------------------------------------------------------------------------12
CREATE TABLE StudentCourse(
 StudentID INT NOT NULL,
 CourseID INT NOT NULL,

CONSTRAINT Fk_StudentID_StudentCourse FOREIGN kEY (StudentID) REFERENCES Student(StudentID),
CONSTRAINT FK_CourseID_StudentCourse FOREIGN kEY (CourseID)  REFERENCES  Course(CourseID),
CONSTRAINT PK_StudentCourse PRIMARY KEY( StudentID,CourseID)
);
---------------------------------------------------------------------------13
CREATE TABLE TrackBranch(
  TrackID INT NOT NULL,
  BranchID INT NOT NULL,

CONSTRAINT Fk_TrackID FOREIGN kEY (TrackID) REFERENCES Track(TrackID),
CONSTRAINT FK_BranchID FOREIGN kEY (BranchID)  REFERENCES Branch(BranchID),
CONSTRAINT PK_TrackBranch PRIMARY kEY (TrackID ,BranchID)
);
----------------------------------------------------------------------------------14
CREATE TABLE Questions(
QuestionID INT PRIMARY kEY NOT NULL,
CourseID INT  NOT NULL, 
QuestionType VARCHAR(50),
QuestionTitle VARCHAR(255),
CorrectAnswer VARCHAR(255),

CONSTRAINT FK_CourseID_Questions FOREIGN kEY (CourseID) REFERENCES Course(CourseID),
CONSTRAINT CHK_QuestionType CHECK (QuestionType IN ('TF', 'MCQ'))
);
-------------------------------------------------------------------------------------------15
CREATE TABLE BranchInstructor(
BranchID INT NOT NULL,
InstructorID INT NOT NULL,

CONSTRAINT Fk_BranchID_BranchInstructor FOREIGN kEY (BranchID) REFERENCES Branch(BranchID),
CONSTRAINT FK_InstructorID_BranchInstructor FOREIGN kEY (InstructorID) REFERENCES Instructor(InstructorID),
CONSTRAINT PK_BranchInstructor PRIMARY kEY (BranchID,InstructorID)
);
----------------------------------------------------------------------------------------------16
CREATE TABLE TrackInstructor(
InstructorID INT NOT NULL,
TrackID INT  NOT NULL,

CONSTRAINT FK_InstructorID_TrackInstructor FOREIGN kEY (InstructorID)  REFERENCES Instructor(InstructorID),
CONSTRAINT Fk_TrackID_TrackInstructor FOREIGN kEY (TrackID) REFERENCES Track(TrackID),
CONSTRAINT PK_TrackInstructor PRIMARY kEY (InstructorID ,TrackID)
);
-----------------------------------------------------------------------------------------17
CREATE TABLE Exam(
	ExamID INT PRIMARY KEY NOT NULL,
	Date DateTime ,
	TotalScore INT NOT NULL
);
-----------------------------------------------------------------------------------------18
CREATE TABLE Choices(
	QuestionID INT NOT NULL,
	Choices VARCHAR(255) NOT NULL,

CONSTRAINT FK_QuestionID FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
CONSTRAINT PK_Choices PRIMARY kEY (QuestionID,Choices)
);
------------------------------------------------------------------------------------------------------19
CREATE TABLE TakesExam(
	StudentID INT NOT NULL,
	ExamID INT NOT NULL,
	QuestionID INT NOT NULL,
	StudentAnswer VARCHAR(255) NOT NULL ,
	Score INT NOT NULL,

	 CONSTRAINT PK_TakesExam  PRIMARY kEY (StudentID,QuestionID,ExamID),
	 CONSTRAINT FK_StudentID_TakesExam FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
	 CONSTRAINT FK_QuestionID_TakesExam FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
	 CONSTRAINT FK_ExamID_TakesExam FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
	 CONSTRAINT CHK_Score CHECK (Score IN (0, 1))
);

