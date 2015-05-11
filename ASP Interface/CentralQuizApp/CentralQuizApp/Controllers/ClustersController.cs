﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CentralQuizApp.Models;

namespace CentralQuizApp.Controllers
{
    public class ClustersController : Controller
    {
        private RepositoryDBContext db = new RepositoryDBContext();

        //
        // GET: /Clusters/

        public ActionResult Index()
        {
            return View(db.ClustersList.ToList());
        }

        //
        // GET: /Clusters/Details/5

        public ActionResult Details(int id = 0)
        {
            Clusters clusters = db.ClustersList.Find(id);
            if (clusters == null)
            {
                return HttpNotFound();
            }
            return View(clusters);
        }

        //
        // GET: /Clusters/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Clusters/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Clusters clusters)
        {
            if (ModelState.IsValid)
            {
                db.ClustersList.Add(clusters);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(clusters);
        }

        //
        // GET: /Clusters/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Clusters clusters = db.ClustersList.Find(id);
            if (clusters == null)
            {
                return HttpNotFound();
            }
            return View(clusters);
        }

        //
        // POST: /Clusters/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Clusters clusters)
        {
            if (ModelState.IsValid)
            {
                db.Entry(clusters).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(clusters);
        }

        //
        // GET: /Clusters/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Clusters clusters = db.ClustersList.Find(id);
            if (clusters == null)
            {
                return HttpNotFound();
            }
            return View(clusters);
        }

        //
        // POST: /Clusters/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Clusters clusters = db.ClustersList.Find(id);
            db.ClustersList.Remove(clusters);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}