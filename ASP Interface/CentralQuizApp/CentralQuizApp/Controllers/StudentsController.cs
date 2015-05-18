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
        public ActionResult ListClusters(string studentID)
        {
            // Initiate list of ClusterReturn objects
            List<ClusterReturn> returnList = new List<ClusterReturn>();

            // Generate a list of enrolled clusters
            var clusterEnrol = db.ClusterEnrolList.Where(i => i.student_id.Contains(studentID)).ToList<Cluster_Enrolments>();

            // Generate a list of completed quizzes
            var studentQuizzes = db.StudentQuizzesList.Where(j => j.student_id.Contains(studentID)).ToList<Student_Quizzes>();

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

        public ActionResult ListQuizzes(string clusterID)
        {
            // Initiate list of ClusterReturn objects
            List<ClusterReturn> returnList = new List<ClusterReturn>();

            // Find Cluster
            Clusters temp = db.ClustersList.Find(clusterID);

            // Generate a list of clusters quizzes
            var clusterQuizzes = db.QuizzesList.Where(i => i.cluster_id.Contains(temp.cluster_id)).ToList<Quizzes>();

            // Add new ClusterReturn
            returnList.Add(new ClusterReturn(temp, clusterQuizzes));

            ViewBag.HTMLClusters = returnList;
            ViewBag.QuizzesResult = "Returned Quizzes";
            return View();
        }

        public ActionResult ReviewQuiz(string quizID)
        {
            ViewBag.ReviewResult = "Review Returned";
            return View();
        }

        public ActionResult ModifyAccount()
        {
            ViewBag.ReviewResult = "Account Returned";
            return View();
        }

    }
}
