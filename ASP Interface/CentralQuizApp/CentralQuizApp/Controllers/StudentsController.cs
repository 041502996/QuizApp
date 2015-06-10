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
            string returnJson;

            int quiz_id = int.Parse(QuizID);
            Quizzes quiz = db.QuizzesList.Find(quiz_id);
            Clusters cluster = db.ClustersList.Find(quiz.cluster_id);
            Lecturers lecturer = db.LecturersList.Find(quiz.lecturer_id);
            List<Questions> quiz_questions = db.QuestionsList.Where(i => i.quiz_id == quiz_id).ToList<Questions>();
            DbSet<Formats> formats = db.FormatsList;

            returnJson = "\"quiz\": [{" +
                        "\"clustertitle\": \"" + cluster.cluster_title + "\", " + '\n' +
                        "\"lecturer\": \"" + lecturer.lecturer_name_first + " " + lecturer.lecturer_name_last + "\", " + '\n' +
                        "\"quiztitle\": \"" + quiz.quiz_title + "\", " + '\n' +
                        "\"timer\": \"" + quiz.quiz_timer + "\", " + '\n' +
                        "\"duedate\": \"" + quiz.quiz_due_date + "\", " + '\n' +
                        "\"createdate\": \"" + quiz.quiz_creation_date + "\", " + '\n';

            returnJson = returnJson + "\"questions\": [" + '\n';
            foreach(Questions qu in quiz_questions)
            {


                Formats format = formats.Find(qu.format_id);
                returnJson = returnJson + "{" +
                            "\"type\": \"" + format.format_abbreviation + "\", " +
                            "\"text\": \"" + qu.question_question + "\", " +
                            "\"answers\": [" + qu.question_answers + "]" +
                            "}," + '\n';
            }
            returnJson = returnJson + "]]";

            return returnJson;
        }

        public ActionResult ModifyAccount(string studentID)
        {
            return View();
        }

    }
}
