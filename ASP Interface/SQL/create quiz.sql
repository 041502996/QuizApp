/* Database Creation Script
   
   Code begins by checking for if the database is currently created, 
   if so drops it and re-creates it as a new, empty database.
   
   Code then generates tables completely void of Foreign Keys,
   but still implementing other constraints.
   
   Finally code implements all Foreign Keys to tables.
   */

USE central_interface;

-- 'quizzes' table holds information about quiz in general
-- Holds foreign key to 'lecturer' and 'cluster' table
CREATE TABLE quizzes
	(quiz_id 			INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	quiz_cluster 		INT			NOT NULL,
	quiz_creator 		INT			NOT NULL,
	quiz_title 			VARCHAR(50)	NOT NULL,
    quiz_timer			INT				NULL,
	quiz_due_date 		DATETIME	NOT NULL,
	quiz_creation_date 	DATETIME		NULL
	);
	
-- 'questions' table holds information about question format and order
-- Holds foreign key to 'quizzes' and 'format' table
CREATE TABLE questions
	(question_id 		INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	quiz_id 			INT			NOT NULL,
	question_format 	INT			NOT NULL,
	question_position 	INT			NOT NULL
	);

-- 'formats' table holds html information about question formats
CREATE TABLE formats
	(format_id 			INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	format_title 		VARCHAR(25)	NOT NULL,
	format_abbreviation VARCHAR(2)	NOT NULL,
	format_html_review	TEXT		NOT NULL,
    format_html_create	TEXT		NOT NULL
	);

/*
CREATING DIFFERENT QUESTION TABLES
*/

-- MULTIPLE CHOICE requires two tables
-- 'multiple_choice' table holds all multiple choice questions, and correct answer
-- Holds foreign key to 'questions' table
CREATE TABLE multiple_choice
	(mc_id 				INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	mc_question_id 		INT			NOT NULL,
    mc_question			VARCHAR(75)	NOT NULL,
    mc_answer			VARCHAR(25)	NOT NULL
	);
-- 'mc_wrong' table holds all multiple choice incorrect answers
-- Holds foreign key to 'multiple_choice' table
CREATE TABLE mc_wrong
	(mc_wrong_id 		INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	mc_id 				INT			NOT NULL,
    mc_wrong_answer		VARCHAR(25)	NOT NULL
	);
    
-- MULTIPLE ANSWER requires three tables
-- 'multiple_answer' table holds all multiple answer questions, with no answers
-- Holds foreign key to 'questions' table
CREATE TABLE multiple_answer
	(ma_id 				INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	ma_question_id 		INT			NOT NULL,
    ma_question			VARCHAR(75)	NOT NULL
	);
-- 'ma_wrong' table holds all multiple answer incorrect answers
-- Holds foreign key to 'multiple_answer' table
CREATE TABLE ma_wrong
	(ma_wrong_id 		INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	ma_id 				INT			NOT NULL,
    ma_wrong_answer		VARCHAR(25)	NOT NULL
	);
-- 'ma_correct' table holds all multiple answer correct answers
-- Holds foreign key to 'multiple_answer' table
CREATE TABLE ma_correct
	(ma_correct_id 		INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	ma_id 				INT			NOT NULL,
    ma_correct_answer	VARCHAR(25)	NOT NULL
	);
    
-- TRUE/FALSE requires one table
-- 'true_false' table holds all true/false questions
-- Holds foreign key to 'questions' table
CREATE TABLE true_false
	(tf_id 				INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	tf_question_id 		INT			NOT NULL,
    tf_question			VARCHAR(75)	NOT NULL,
    tf_answer			BIT(1)		NOT NULL
	);

-- LONG RESPONSE requires one table
-- 'long_response' table holds all long answer questions
-- Holds foreign key to 'questions' table
CREATE TABLE long_response
	(long_id 			INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	long_question_id 	INT			NOT NULL,
    long_question		VARCHAR(75)	NOT NULL
	);

-- SHORT RESPONSE requires one table
-- 'short_response' table holds all short answer questions
-- Holds foreign key to 'questions' table
CREATE TABLE short_response
	(short_id 			INT			NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	short_question_id 	INT			NOT NULL,
    short_question		VARCHAR(75)	NOT NULL
	);

/*
RESOLVING FOREIGN KEY CONNECTIONS
*/
-- Add FK from 'quizzes' too 'clusters' and 'lecturers'
ALTER TABLE quizzes
	ADD CONSTRAINT quizzes_cluster_fk FOREIGN KEY (quiz_cluster)
		REFERENcharacter_informationCES clusters(cluster_id);
ALTER TABLE quizzes
	ADD CONSTRAINT quizzes_lecturer_fk FOREIGN KEY (quiz_creator)
		REFERENCES lecturers(lecturer_id);

-- Add FK from 'questions' too 'quizzes' and 'formats'
ALTER TABLE questions
	ADD CONSTRAINT questions_quizzes_fk FOREIGN KEY (quiz_id)
		REFERENCES quizzes(quiz_id);
ALTER TABLE questions
	ADD CONSTRAINT questions_formats_fk FOREIGN KEY (question_format)
		REFERENCES formats(format_id);


-- HANDLING QUESTION TABLE FOREIGN KEYS

-- Add FK from 'mc_wrong' too 'multiple_choice'
ALTER TABLE mc_wrong
	ADD CONSTRAINT mc_wrong_multiple_choice_fk FOREIGN KEY (mc_id)
		REFERENCES multiple_choice(mc_id);
-- Add FK from 'multiple_choice' too 'questions'
ALTER TABLE multiple_choice
	ADD CONSTRAINT multiple_choice_questions_fk FOREIGN KEY (mc_question_id)
		REFERENCES questions(question_id);

-- Add FK from 'ma_wrong' and 'ma_correct' too 'multiple_answer'
ALTER TABLE ma_correct
	ADD CONSTRAINT ma_correct_multiple_answer_fk FOREIGN KEY (ma_id)
		REFERENCES multiple_answer(ma_id);
ALTER TABLE ma_wrong
	ADD CONSTRAINT ma_wrong_multiple_answer_fk FOREIGN KEY (ma_id)
		REFERENCES multiple_answer(ma_id);
-- Add FK from 'multiple_answer' too 'questions'
ALTER TABLE multiple_answer
	ADD CONSTRAINT multiple_answer_questions_fk FOREIGN KEY (ma_question_id)
		REFERENCES questions(question_id);

-- Add FK from 'true_false' too 'questions'
ALTER TABLE true_false
	ADD CONSTRAINT true_false_questions_fk FOREIGN KEY (tf_question_id)
		REFERENCES questions(question_id);
-- Add FK from 'short_response' too 'questions'
ALTER TABLE short_response
	ADD CONSTRAINT short_response_questions_fk FOREIGN KEY (short_question_id)
		REFERENCES questions(question_id);
-- Add FK from 'long_response' too 'questions'
ALTER TABLE long_response
	ADD CONSTRAINT long_response_questions_fk FOREIGN KEY (long_question_id)
		REFERENCES questions(question_id);