SET IDENTITY_INSERT Quizzes ON
SET IDENTITY_INSERT Formats ON

INSERT INTO Formats (format_id, format_title, format_abbreviation, format_html_review, format_html_create)
VALUES (0, 'True False', 'TF', '', ''),
	   (1, 'Multiple Choice', 'MC', '', ''),
	   (2, 'Multiple Answer', 'MA', '', ''),
	   (3, 'Short Response', 'St', '', ''),
	   (4, 'Long Response', 'Lg', '', '')
PRINT 'Created Formats (5)'

INSERT INTO Quizzes (quiz_id, cluster_id, lecturer_id, quiz_title, quiz_timer, quiz_due_date, quiz_creation_date)
VALUES (0, '0001', '040000000', 'Test Quiz', 120, '20150524 12:00:00 AM', '20150518 12:00:00 AM')
PRINT 'Created Quizzes (1)'

INSERT INTO Questions (question_id, quiz_id, format_id, question_question, question_answers)
VALUES (0, 0, 0, 'TF Title', '<ANS>true</ANS>'),
	   (1, 0, 1, 'MC Title', '<ANS>Correct</ANS><WRONG>Incorrect</WRONG>'),
	   (2, 0, 2, 'MA Title', '<ANS>Correct</ANS><WRONG>Incorrect</WRONG><ANS>2Correct</ANS><WRONG>2Incorrect</WRONG>'),
	   (3, 0, 3, 'St Title', '<ANS></ANS>'),
	   (4, 0, 4, 'Lg Title', '<ANS></ANS>')
PRINT 'Created Questions (5)'

SET IDENTITY_INSERT Formats OFF
SET IDENTITY_INSERT Quizzes OFF