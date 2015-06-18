using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Objects.SqlClient;
//DEBUG: for personal referance later - Dillon: SqlFunctions.StringConvert((decimal?)c.cluster_id)
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CentralQuizApp.Models;

namespace CentralQuizApp.Controllers
{
    public class StudentsController : Controller
    {
        private RepositoryDBContext db = new RepositoryDBContext();
        
        // GET: /Students/

        // ListClusters is considered Student Homepage
        public ActionResult ListClusters(string StudentID)
        {
            // Initiate list of ClusterReturn objects
            List<ClusterReturn> returnList = new List<ClusterReturn>();

            // Generate a list of enrolled clusters
            var clusterEnrol = db.ClusterEnrolList.Where(i => i.student_id.Contains(StudentID)).ToList<Cluster_Enrolments>();

            // Generate a list of completed quizzes
            var studentQuizzes = db.StudentQuizzesList.Where(j => j.student_id.Contains(StudentID)).ToList<Student_Quizzes>();

            // Loop enrolled clusters
            foreach(var clEn in clusterEnrol)
            {
                // Find Cluster
                Clusters temp = db.ClustersList.Find(clEn.cluster_id);

                // Generate a list of enrolled quizzes
                var quizzesTemp = db.QuizzesList.Where(k => k.cluster_id.Contains(temp.cluster_id));

                // Initialise Quiz Return list
                List<Quizzes> returnQuizzes = new List<Quizzes>();

                // Check all Clusters Quizzes
                foreach(var clQu in quizzesTemp)
                {
                    // Make hold a mark
                    bool found = false;

                    // Check all Student Completed Quizzes
                    foreach (var stQu in studentQuizzes)
                    {
                        // Check if they match
                        if(clQu.quiz_id == stQu.quiz_id)
                        {
                            // Mark
                            found = true;
                        }
                    }

                    // If it isnt found, add to list of yet-to-be-completed
                    if(!found)
                    {
                        returnQuizzes.Add(clQu);
                    }
                }

                // Add new ClusterReturn
                returnList.Add(new ClusterReturn(temp, returnQuizzes));
            }

            ViewBag.HTMLClusters = returnList;
            ViewBag.ClustersResult = returnList.Count().ToString();
            return View();
        }

        public ActionResult ListQuizzes(string ClusterID)
        {
            // Find Cluster
            Clusters temp = db.ClustersList.Find(ClusterID);

            // Generate a list of clusters quizzes
            var clusterQuizzes = db.QuizzesList.Where(i => i.cluster_id.Contains(temp.cluster_id)).ToList<Quizzes>();

            // Add new ClusterReturn
            ClusterReturn returnList = new ClusterReturn(temp, clusterQuizzes);

            ViewBag.HTMLClusters = returnList;
            return View();
        }

        public ActionResult ReviewQuiz(string QuizID, string StudentID)
        {
            Student_Quizzes temp = db.StudentQuizzesList.Find(QuizID, StudentID);
            QuizReturn quizReturn = new QuizReturn(temp);

            ViewBag.quizReturn = quizReturn;
            return View();
        }

        public string ReturnQuiz(string QuizID)
        {
            string returnXml;

            int quiz_id = int.Parse(QuizID);
            Quizzes quiz = db.QuizzesList.Find(quiz_id);
            Clusters cluster = db.ClustersList.Find(quiz.cluster_id);
            Lecturers lecturer = db.LecturersList.Find(quiz.lecturer_id);
            List<Questions> quiz_questions = db.QuestionsList.Where(i => i.quiz_id == quiz_id).ToList<Questions>();
            DbSet<Formats> formats = db.FormatsList;

            returnXml = "<QUIZ>" + '\n' +
                        "<CLUSTER>" + cluster.cluster_title + "</CLUSTER>" + '\n' +
                        "<LECTURER>" + lecturer.lecturer_name_first + " " + lecturer.lecturer_name_last + "</LECTURER>" + '\n' +
                        "<TITLE>" + quiz.quiz_title + "</TITLE>" + '\n' +
                        "<TIMER>" + quiz.quiz_timer + "</TIMER>" + '\n' +
                        "<DUEDATE>" + quiz.quiz_due_date + "</DUEDATE>" + '\n' +
                        "<CREATEDATE>" + quiz.quiz_creation_date + "</CREATEDATE>" + '\n';

            returnXml = returnXml + "<QUESTIONS>" + '\n';
            foreach(Questions qu in quiz_questions)
            {
                Formats format = formats.Find(qu.format_id);
                returnXml = returnXml +
                            "<" + format.format_abbreviation + ">" + '\n' +
                            "<TEXT>" + qu.question_question + "</TEXT>" + '\n' +
                            qu.question_answers + '\n' +
                            "</" + format.format_abbreviation + ">" + '\n';
            }
            returnXml = returnXml + "</QUESTIONS>" + '\n' + "</QUIZ>";

            return returnXml;
        }

        public ActionResult ModifyAccount(string studentID)
        {
            return View();
        }

    }
}
