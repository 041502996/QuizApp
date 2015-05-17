/* Database Creation Script
   
   Code begins by checking for if the database is currently created, 
   if so drops it and re-creates it as a new, empty database.
   
   Code then generates tables completely void of Foreign Keys,
   but still implementing other constraints.
   
   Finally code implements all Foreign Keys to tables.
   */

PRINT 'Begin Creation of Tables'
PRINT ''

-- 'quizzes' table holds information about quiz in general
-- Holds foreign key to 'lecturer' and 'cluster' table
CREATE TABLE quizzes
	(quiz_id 			INT			NOT NULL	PRIMARY KEY,
	cluster_id	 		INT			NOT NULL,
	lecturer_id			INT			NOT NULL,
	quiz_title 			NVARCHAR(50)	NOT NULL,
    quiz_timer			INT				NULL,
	quiz_due_date 		DATETIME	NOT NULL,
	quiz_creation_date 	DATETIME		NULL
	);
PRINT 'Created quizzes'
	
-- 'questions' table holds information about question format and order
-- Holds foreign key to 'quizzes' and 'format' table
CREATE TABLE questions
	(question_id 		INT			NOT NULL	PRIMARY KEY,
	quiz_id 			INT			NOT NULL,
	format_id		 	INT			NOT NULL,
	question_position 	INT			NOT NULL
	);
PRINT 'Created questions'

-- 'formats' table holds html information about question formats
CREATE TABLE formats
	(format_id 			INT			NOT NULL	PRIMARY KEY,
	format_title 		NVARCHAR(25)	NOT NULL,
	format_abbreviation NVARCHAR(2)	NOT NULL,
	format_html_review	TEXT		NOT NULL,
    format_html_create	TEXT		NOT NULL
	);
PRINT 'Created formats'

CREATE TABLE student_answers
	(
	student_answer_id	INT			NOT NULL	PRIMARY KEY,
	question_id			INT			NOT NULL,
	student_id			INT			NOT NULL,
	student_answer_text	NVARCHAR(max)	NOT NULL
	);
PRINT 'Created student_answers'

/*
CREATING DIFFERENT QUESTION TABLES
*/

-- MULTIPLE CHOICE requires two tables
-- 'multiple_choice' table holds all multiple choice questions, and correct answer
-- Holds foreign key to 'questions' table
CREATE TABLE multiple_choice
	(mc_id 				INT			NOT NULL	PRIMARY KEY,
	question_id 		INT			NOT NULL,
    mc_question			NVARCHAR(75)	NOT NULL,
    mc_answer			NVARCHAR(25)	NOT NULL
	);
PRINT 'Created multiple_choice'
-- 'mc_wrong' table holds all multiple choice incorrect answers
-- Holds foreign key to 'multiple_choice' table
CREATE TABLE mc_wrong
	(mc_wrong_id 		INT			NOT NULL	PRIMARY KEY,
	mc_id 				INT			NOT NULL,
    mc_wrong_answer		NVARCHAR(25)	NOT NULL
	);
PRINT '--Created mc_wrong'
    
-- MULTIPLE ANSWER requires three tables
-- 'multiple_answer' table holds all multiple answer questions, with no answers
-- Holds foreign key to 'questions' table
CREATE TABLE multiple_answer
	(ma_id 				INT			NOT NULL	PRIMARY KEY,
	question_id 		INT			NOT NULL,
    ma_question			NVARCHAR(75)	NOT NULL
	);
PRINT 'Created multiple_answer'
-- 'ma_answers' table holds all multiple answer answers
-- Holds foreign key to 'multiple_answer' table
CREATE TABLE ma_answers
	(ma_answer_id 		INT			NOT NULL	PRIMARY KEY,
	ma_id 				INT			NOT NULL,
    ma_answer_answer	NVARCHAR(25)	NOT NULL,
	ma_answer_correct	NVARCHAR(1)	NOT NULL
	);
PRINT '--Created ma_answers'
    
-- TRUE/FALSE requires one table
-- 'true_false' table holds all true/false questions
-- Holds foreign key to 'questions' table
CREATE TABLE true_false
	(tf_id 				INT			NOT NULL	PRIMARY KEY,
	question_id 		INT			NOT NULL,
    tf_question			NVARCHAR(75)	NOT NULL,
    tf_answer			NVARCHAR(1)		NOT NULL
	);
PRINT 'Created true_false'

-- LONG RESPONSE requires one table
-- 'long_response' table holds all long answer questions
-- Holds foreign key to 'questions' table
CREATE TABLE long_response
	(long_id 			INT			NOT NULL	PRIMARY KEY,
	question_id 		INT			NOT NULL,
    long_question		NVARCHAR(75)	NOT NULL
	);
PRINT 'Created long_response'

-- SHORT RESPONSE requires one table
-- 'short_response' table holds all short answer questions
-- Holds foreign key to 'questions' table
CREATE TABLE short_response
	(short_id 			INT			NOT NULL	PRIMARY KEY,
	question_id 		INT			NOT NULL,
    short_question		NVARCHAR(75)	NOT NULL
	);
PRINT 'Created short_response'

PRINT ''
PRINT 'Completed Creation of Tables'
PRINT ''

/*
RESOLVING FOREIGN KEY CONNECTIONS
*/

PRINT 'Begin FKs'
PRINT ''

-- Add FK from 'quizzes' too 'clusters' and 'lecturers'
ALTER TABLE quizzes
	ADD CONSTRAINT quizzes_cluster_fk FOREIGN KEY (cluster_id)
		REFERENCES clusters(cluster_id);
ALTER TABLE quizzes
	ADD CONSTRAINT quizzes_lecturer_fk FOREIGN KEY (lecturer_id)
		REFERENCES lecturers(lecturer_id);
PRINT 'FK quizzes to clusters and quizzes'

-- Add FK from 'questions' too 'quizzes' and 'formats'
ALTER TABLE questions
	ADD CONSTRAINT questions_quizzes_fk FOREIGN KEY (quiz_id)
		REFERENCES quizzes(quiz_id);
ALTER TABLE questions
	ADD CONSTRAINT questions_formats_fk FOREIGN KEY (format_id)
		REFERENCES formats(format_id);
PRINT 'FK questions to quizzes and formats'

 -- Add FK from 'student_answers' too 'questions' and 'students'
ALTER TABLE student_answers
	ADD CONSTRAINT student_answers_question_fk FOREIGN KEY (question_id)
		REFERENCES questions(question_id);
ALTER TABLE student_answers
	ADD CONSTRAINT student_answers_student_fk FOREIGN KEY (student_id)
		REFERENCES students(student_id);
PRINT 'FK student_answers to questions and students'

-- HANDLING QUESTION TABLE FOREIGN KEYS

-- Add FK from 'mc_wrong' too 'multiple_choice'
ALTER TABLE mc_wrong
	ADD CONSTRAINT mc_wrong_multiple_choice_fk FOREIGN KEY (mc_id)
		REFERENCES multiple_choice(mc_id);
-- Add FK from 'multiple_choice' too 'questions'
ALTER TABLE multiple_choice
	ADD CONSTRAINT multiple_choice_questions_fk FOREIGN KEY (question_id)
		REFERENCES questions(question_id);
PRINT 'FK mc_wrong to multiple_choice, and multiple_choice to questions'

-- Add FK from 'ma_wrong' and 'ma_correct' too 'multiple_answer'
ALTER TABLE ma_answers
	ADD CONSTRAINT ma_multiple_answer_fk FOREIGN KEY (ma_id)
		REFERENCES multiple_answer(ma_id);
-- Add FK from 'multiple_answer' too 'questions'
ALTER TABLE multiple_answer
	ADD CONSTRAINT multiple_answer_questions_fk FOREIGN KEY (question_id)
		REFERENCES questions(question_id);
PRINT 'FK ma_answers to multiple_answers, and multiple_answer to questions'

-- Add FK from 'true_false' too 'questions'
ALTER TABLE true_false
	ADD CONSTRAINT true_false_questions_fk FOREIGN KEY (question_id)
		REFERENCES questions(question_id);
PRINT 'FK true_false to questions'

-- Add FK from 'short_response' too 'questions'
ALTER TABLE short_response
	ADD CONSTRAINT short_response_questions_fk FOREIGN KEY (question_id)
		REFERENCES questions(question_id);
PRINT 'FK short_response to questions'

-- Add FK from 'long_response' too 'questions'
ALTER TABLE long_response
	ADD CONSTRAINT long_response_questions_fk FOREIGN KEY (question_id)
		REFERENCES questions(question_id);
PRINT 'FK long_response to questions'