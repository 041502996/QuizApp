using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CentralQuizApp.Models
{
    public class CourseReturn
    {
        Courses core;
        IQueryable<Clusters> clustersList;

        public CourseReturn(Courses Core, IQueryable<Clusters> ClustersList)
        {
            core = Core;
            clustersList = ClustersList;
        }
    }
}
