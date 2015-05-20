CREATE TABLE students
	(student_id 		NVARCHAR(128)		NOT NULL	PRIMARY KEY,
	);
	
CREATE TABLE quizzes
	(quiz_id 		INT			NOT NULL	PRIMARY KEY,
	);


CREATE TABLE questions
(question_id	INT not null,
quiz_id int not null,
CONSTRAINT qpk PRIMARY KEY (question_id,quiz_id)
);

create table student_quizzes
(quiz_id int not null,
student_id NVARCHAR(128) not null,
CONSTRAINT sqpk PRIMARY KEY (quiz_id,student_id)
);

create table student_answers
(q_question_id int not null,
q_quiz_id int not null,
sq_quiz_id int not null,
sq_student_id nvarchar(128) not null,
CONSTRAINT sapk PRIMARY KEY (q_question_id,q_quiz_id,sq_quiz_id,sq_student_id)
);


ALTER TABLE questions
	ADD CONSTRAINT a FOREIGN KEY (quiz_id)
		REFERENCES quizzes(quiz_id);

ALTER TABLE student_quizzes
	ADD CONSTRAINT b FOREIGN KEY (quiz_id)
		REFERENCES quizzes(quiz_id);
ALTER TABLE student_quizzes
	ADD CONSTRAINT c FOREIGN KEY (student_id)
		REFERENCES students(student_id);

ALTER TABLE student_answers
	ADD CONSTRAINT d FOREIGN KEY (q_question_id, q_quiz_id)
		REFERENCES questions(question_id, quiz_id);
ALTER TABLE student_answers
	ADD CONSTRAINT e FOREIGN KEY (sq_quiz_id, sq_student_id)
		REFERENCES student_quizzes(quiz_id, student_id);