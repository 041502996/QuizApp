using System;
using System.Data.Entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CentralQuizApp.Models
{
    public class RepositoryDBContext : DbContext
    {
        public DbSet<Clusters> ClustersList { get; set; }
    }

    public class Clusters
    {
        public int ID { get; set; }
        public string title { get; set; }
    }
}