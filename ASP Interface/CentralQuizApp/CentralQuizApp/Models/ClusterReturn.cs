using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CentralQuizApp.Models
{
    public class ClusterReturn
    {
        public Clusters core;
        public List<Quizzes> quizzesList;

        public ClusterReturn(Clusters Core, List<Quizzes> QuizzesList)
        {
           core = Core;
           quizzesList = QuizzesList;
        }
    }
}