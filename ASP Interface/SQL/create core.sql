/* Database Creation Script
   
   Code begins by checking for if the database is currently created, 
   if so drops it and re-creates it as a new, empty database.
   
   Code then generates tables completely void of Foreign Keys,
   but still implementing other constraints.
   
   Finally code implements all Foreign Keys to tables.
   */

--DROP DATABASE RepositoryDBContext;
--CREATE DATABASE RepositoryDBContext;

--USE central_interface;

PRINT 'Begin Creation of Tables'
PRINT ''

-- 'students' table holds information about students, including login details
CREATE TABLE students
	(student_id 		INT			NOT NULL	PRIMARY KEY,
	student_email 		NVARCHAR(30)	NOT NULL,
	student_password 	NVARCHAR(32)	NOT NULL,
	student_name_first 	NVARCHAR(25)	NOT NULL,
	student_name_last 	NVARCHAR(25)	NOT NULL,
	student_verified 	NVARCHAR(25)		NULL
	);
PRINT 'Created Students'
	
-- 'lecturer' holds information about lecturers and superusers, including login details
CREATE TABLE lecturers
	(lecturer_id 		INT			NOT NULL	PRIMARY KEY,
	lecturer_email 		NVARCHAR(50)	NOT NULL,
	lecturer_password 	NVARCHAR(32)	NOT NULL,
	lecturer_name_first NVARCHAR(25)	NOT NULL,
	lecturer_name_last 	NVARCHAR(25)	NOT NULL,
	lecturer_verified 	NVARCHAR(25)		NULL,
	lecturer_superuser 	NVARCHAR(1)		NOT NULL
	);
PRINT 'Created Lecturers'

-- 'courses' table holds information about the courses
-- Holds foreign key to 'lecturer' table
CREATE TABLE courses
	(course_id 			NVARCHAR(4)	NOT NULL	PRIMARY KEY,
	course_coordinator 	INT			NOT NULL,
	course_title 		NVARCHAR(50)	NOT NULL
	);
PRINT 'Created Courses'
	
-- 'clusters' table holds information about the clusters
CREATE TABLE clusters
	(cluster_id 		INT			NOT NULL	PRIMARY KEY,
	cluster_title 		NVARCHAR(50)	NOT NULL,
	cluster_abbreviation NVARCHAR(2)	NOT NULL
	);
PRINT 'Created Clusters'

/*
RESOLVING MANY TO MANY CONNECTIONS
*/

-- 'course_enrolments' is an intermediary between 'courses' and 'students'
-- Holds foreign keys to 'courses' table and 'students' table
CREATE TABLE course_enrolments
	(course_id			NVARCHAR(4)	NOT NULL,
	student_id 			INT			NOT NULL,
	CONSTRAINT courses_students_key PRIMARY KEY(course_id, student_id)
	);
PRINT 'Resolved course_enrolments'

-- 'cluster_enrolments' is an intermediary between 'clusters' and 'students'
-- Holds foreign keys to 'clusters' table and 'students' table
CREATE TABLE cluster_enrolments
	(cluster_id 		INT			NOT NULL,
	student_id 			INT			NOT NULL,
	CONSTRAINT clusters_students_key PRIMARY KEY(cluster_id, student_id)
	);
PRINT 'Resolved cluster_enrolments'
	
-- 'course_clusters' is an intermediary between 'courses' and 'clusters'
-- Holds foreign keys to 'courses' table and 'clusters' table
CREATE TABLE course_clusters
	(course_id 			NVARCHAR(4)	NOT NULL,
	cluster_id 			INT			NOT NULL,
	CONSTRAINT courses_clusters_key PRIMARY KEY(course_id, cluster_id)
	);
PRINT 'Resolved course_clusters'

-- 'cluster_lecturers' is an intermediary between 'clusters' and 'lecturers'
-- Holds foreign keys to 'clusters' table and 'lecturers' table
CREATE TABLE cluster_lecturers
	(cluster_id 		INT			NOT NULL,
	lecturer_id 		INT			NOT NULL,
	CONSTRAINT clusters_lecturers_key PRIMARY KEY(cluster_id, lecturer_id)
	);
PRINT 'Resolved cluster_lecturers'

PRINT ''
PRINT 'Completed Creation of Tables'
PRINT ''

/*
RESOLVING FOREIGN KEY CONNECTIONS
*/

PRINT 'Begin FKs'
PRINT ''

-- Add FK from 'course_enrolments' too 'students' and 'courses'
ALTER TABLE course_enrolments
	ADD CONSTRAINT course_enrolments_student_fk FOREIGN KEY (student_id)
		REFERENCES students(student_id);
ALTER TABLE course_enrolments
	ADD CONSTRAINT course_enrolments_course_fk FOREIGN KEY (course_id)
		REFERENCES courses(course_id);
PRINT 'FK course_enrolments to students and courses'

-- Add FK from 'cluster_enrolments' too 'clusters' and 'students'
ALTER TABLE cluster_enrolments
	ADD CONSTRAINT cluster_enrolments_student_fk FOREIGN KEY (student_id)
		REFERENCES students(student_id);
ALTER TABLE cluster_enrolments
	ADD CONSTRAINT cluster_enrolments_cluster_fk FOREIGN KEY (cluster_id)
		REFERENCES clusters(cluster_id);
PRINT 'FK cluster_enrolments to clusters and students'

-- Add FK from 'course_clusters' too 'courses' and 'clusters'
ALTER TABLE course_clusters
	ADD CONSTRAINT course_clusters_course_fk FOREIGN KEY (course_id)
		REFERENCES courses(course_id);
ALTER TABLE course_clusters
	ADD CONSTRAINT course_clusters_cluster_fk FOREIGN KEY (cluster_id)
		REFERENCES clusters(cluster_id);
PRINT 'FK course_clusters to courses and clusters'

-- Add FK from 'cluster_lecturers' too 'clusters' and 'lecturers'
ALTER TABLE cluster_lecturers
	ADD CONSTRAINT cluster_lecturers_cluster_fk FOREIGN KEY (cluster_id)
		REFERENCES clusters(cluster_id);
ALTER TABLE cluster_lecturers
	ADD CONSTRAINT cluster_lecturers_lecturer_fk FOREIGN KEY (lecturer_id)
		REFERENCES lecturers(lecturer_id);
PRINT 'FK cluster_lecturers to clusters and lecturers'
		
-- Add FK from 'courses' too 'lecturers'
ALTER TABLE courses
	ADD CONSTRAINT courses_coordinator_fk FOREIGN KEY (course_coordinator)
		REFERENCES lecturers(lecturer_id);
PRINT 'FK courses to lecturers'

PRINT ''
PRINT 'Completed FKs'