using System;
using System.Data.Entity;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CentralQuizApp.Models
{
    public class RepositoryDBContext : DbContext
    {
        public DbSet<Students> StudentsList { get; set; }
        public DbSet<Lecturers> LecturersList { get; set; }
        public DbSet<Clusters> ClustersList { get; set; }
        public DbSet<Courses> CoursesList { get; set; }
        public DbSet<Course_Enrolments> CourseEnrolList { get; set; }
        public DbSet<Course_Clusters> CourseClustersList { get; set; }
        public DbSet<Cluster_Enrolments> ClusterEnrolList { get; set; }
        public DbSet<Cluster_Lecturers> ClusterLecturersList { get; set; }
        public DbSet<Quizzes> QuizzesList { get; set; }
        public DbSet<Questions> QuestionsList { get; set; }
        public DbSet<Formats> FormatsList { get; set; }

        // Quiz Object Lists
    }

    // Creating the table objects

    public class Students
    {
        [Key]
        public string student_id { get; set; }
        public string student_email { get; set; }
        public string student_password { get; set; }
        public string student_name_first { get; set; }
        public string student_name_last { get; set; }
        public string student_verified { get; set; }
    }

    public class Lecturers
    {
        [Key]
        public string lecturer_id { get; set; }
        public string lecturer_email { get; set; }
        public string lecturer_password { get; set; }
        public string lecturer_name_first { get; set; }
        public string lecturer_name_last { get; set; }
        public string lecturer_verified { get; set; }
        public bool lecturer_superuser { get; set; }
    }

    public class Clusters
    {
        [Key]
        public string cluster_id { get; set; }
        public string cluster_title { get; set; }
        public string cluster_abbreviation { get; set; }
    }

    public class Courses
    {
        [Key]
        public string course_id { get; set; }

        public virtual string lecturer_id { get; set; }
        [ForeignKey("lecturer_id")]
        public virtual Lecturers lecturer { get; set; }

        public string course_title { get; set; }
    }

    // Creating many-to-many table objects

    public class Course_Enrolments
    {
        [Key, Column(Order=0)]
        public virtual string course_id { get; set; }
        [ForeignKey("course_id")]
        public virtual Courses course { get; set; }

        [Key, Column(Order=1)]
        public virtual string student_id { get; set; }
        [ForeignKey("student_id")]
        public virtual Students student { get; set; }
    }

    public class Course_Clusters
    {
        [Key, Column(Order = 0)]
        public virtual string course_id { get; set; }
        [ForeignKey("course_id")]
        public virtual Courses course { get; set; }

        [Key, Column(Order = 1)]
        public virtual string cluster_id { get; set; }
        [ForeignKey("cluster_id")]
        public virtual Clusters cluster { get; set; }
    }

    public class Cluster_Enrolments
    {
        [Key, Column(Order = 0)]
        public virtual string cluster_id { get; set; }
        [ForeignKey("cluster_id")]
        public virtual Clusters cluster { get; set; }

        [Key, Column(Order = 1)]
        public virtual string student_id { get; set; }
        [ForeignKey("student_id")]
        public virtual Students student { get; set; }
    }

    public class Cluster_Lecturers
    {
        [Key, Column(Order = 0)]
        public virtual string cluster_id { get; set; }
        [ForeignKey("cluster_id")]
        public virtual Clusters cluster { get; set; }

        [Key, Column(Order = 1)]
        public virtual string lecturer_id { get; set; }
        [ForeignKey("lecturer_id")]
        public virtual Lecturers lecturer { get; set; }
    }

    // Creating the Quiz table objects

    public class Quizzes
    {
        [Key]
        public int quiz_id { get; set; }

        public virtual string cluster_id { get; set; }
        [ForeignKey("cluster_id")]
        public virtual Clusters cluster { get; set; }

        public virtual string lecturer_id { get; set; }
        [ForeignKey("lecturer_id")]
        public virtual Lecturers lecturer { get; set; }

        public string quiz_title { get; set; }
        public int quiz_timer { get; set; }
        public DateTime quiz_due_date { get; set; }
        public DateTime quiz_creation_date { get; set; }
    }

    public class Questions
    {
        [Key]
        public int question_id { get; set; }

        public virtual int quiz_id { get; set; }
        [ForeignKey("quiz_id")]
        public virtual Quizzes quiz { get; set; }

        public virtual int format_id { get; set; }
        [ForeignKey("format_id")]
        public virtual Formats format { get; set; }

        public int question_position { get; set; }
    }

    public class Formats
    {
        [Key]
        public int format_id { get; set; }
        public string format_title { get; set; }
        public string format_abbreviation { get; set; }
        public string format_html_review { get; set; }
        public string format_html_create { get; set; }
    }

    public class True_False
    {
        [Key]
        public int tf_id { get; set; }

        public virtual int question_id { get; set; }
        [ForeignKey("question_id")]
        public virtual Questions question { get; set; }

        public string tf_question { get; set; }
        public string tf_answer { get; set; }
    }

    public class Multiple_Choice
    {
        public int mc_id { get; set; }

        public virtual int question_id { get; set; }
        [ForeignKey("question_id")]
        public virtual Questions question { get; set; }

        public string mc_question { get; set; }
        public string mc_answer { get; set; }
    }
}