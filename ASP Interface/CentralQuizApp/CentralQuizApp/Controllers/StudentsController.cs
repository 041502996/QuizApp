using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CentralQuizApp.Controllers
{
    public class StudentsController : Controller
    {
        
        // GET: /Students/

        public ActionResult ListClusters(string studentID)
        {
            ViewBag.ClustersResult = "Returned Quizzes";
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
