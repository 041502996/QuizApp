INSERT INTO students (student_id, student_email, student_password, student_name_first, student_name_last, student_verified)
VALUES ('041502996', '041502996@my.central.wa.edu.au', '5f4dcc3b5aa765d61d8327deb882cf99', 'Dillon', 'ODwyer', 'aaaaa')
PRINT 'Inserted (1) into students'

INSERT INTO lecturers (lecturer_id, lecturer_email, lecturer_password, lecturer_name_first, lecturer_name_last, lecturer_verified, lecturer_superuser)
VALUES ('040000000', 'nichola.kerr@my.central.wa.edu.au', '5f4dcc3b5aa765d61d8327deb882cf99', 'Nichola', 'Kerr', 'aaaab', 1),
	   ('040000001', 'helen.burgess@my.central.wa.edu.au', '5f4dcc3b5aa765d61d8327deb882cf99', 'Helen', 'Burgess', 'aaaac', 0),
	   ('040000002', 'tony.evans@my.central.wa.edu.au', '5f4dcc3b5aa765d61d8327deb882cf99', 'Tony', 'Evans', 'aaaad', 0),
	   ('040000003', 'guido@my.central.wa.edu.au', '5f4dcc3b5aa765d61d8327deb882cf99', 'Guido', 'Evans', 'aaaae', 0)
PRINT 'Inserted (4) into lecurers'

INSERT INTO courses (course_id, lecturer_id, course_title)
VALUES ('D573', '040000000', 'Diploma of Software Development')
PRINT 'Inserted (1) into courses'

INSERT INTO clusters (cluster_id, cluster_title, cluster_abbreviation)
VALUES ('0001', 'Manage a Project Using Software Management Tools', 'PM'),
	   ('0002', 'Rapid Application Development Cluster', 'RD'),
	   ('0003', 'Dynamic Websites', 'DW'),
	   ('0004', 'Intermediate Object-Oriented Programming Cluster', 'IO')
PRINT 'Inserted (4) into clusters'

INSERT INTO course_enrolments (course_id, student_id)
VALUES ('D573', '041502996')
PRINT 'Inserted (1) into course_enrolments'

INSERT INTO cluster_enrolments (cluster_id, student_id)
VALUES ('0001', '041502996'),
	   ('0002', '041502996'),
	   ('0003', '041502996'),
	   ('0004', '041502996')
PRINT 'Inserted (4) into cluster_enrolments'

INSERT INTO course_clusters (course_id, cluster_id)
VALUES ('D573', '0001'),
	   ('D573', '0002'),
	   ('D573', '0003'),
	   ('D573', '0004')
PRINT 'Inserted (4) into course_clusters'

INSERT INTO cluster_lecturers (cluster_id, lecturer_id)
VALUES ('0001', '040000000'),
	   ('0001', '040000003'),
	   ('0002', '040000001'),
	   ('0003', '040000002'),
	   ('0004', '040000000')
PRINT 'Inserted (5) into course_clusters'