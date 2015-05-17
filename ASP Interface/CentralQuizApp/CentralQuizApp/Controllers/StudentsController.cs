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
            // Generate a list of enrolled clusters
            var clusterEnrol = db.ClusterEnrolList.Where(c => c.student_id.Contains(studentID)).ToList<Cluster_Enrolments>();

            // Initiate list of ClusterReturn objects
            List<ClusterReturn> returnList = new List<ClusterReturn>();

            // Loop enrolled clusters
            foreach(var clEn in clusterEnrol)
            {
                // Find Cluster
                Clusters temp = db.ClustersList.Find(clEn.cluster_id);
                String tempID = temp.cluster_id.ToString();

                // Generate a list of enrolled quizzes
                var clusterQuizzes = db.QuizzesList.Where(c => c.cluster_id.Contains(tempID)).ToList<Quizzes>();

                // Add new ClusterReturn
                returnList.Add(new ClusterReturn(temp, clusterQuizzes));
            }

            ViewBag.HTMLClusters = returnList;
            ViewBag.ClustersResult = returnList.Count().ToString();
            return View();
        }

        public ActionResult ListQuizzes(string clusterID)
        {
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
