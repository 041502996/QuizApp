using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CentralQuizApp.Models
{
    public class QuizReturn
    {


        Quizzes quiz;
        List<Questions> questions;

        Student_Quizzes student_Quiz;
        Student_Answers student_Answers;

        public QuizReturn(Quizzes Quiz)
        {
            RepositoryDBContext db = new RepositoryDBContext();

            quiz = Quiz;
            var questions = db.QuestionsList.Where(i => i.quiz_id.ToString().Contains(quiz.quiz_id.ToString())).ToList<Questions>();
        }

        public QuizReturn(Student_Quizzes StudentQuiz)
        {
            RepositoryDBContext db = new RepositoryDBContext();

            student_Quiz = StudentQuiz;
            var student_answers = db.StudentAnswersList.Where(i => i.quiz_id.ToString().Contains(student_Quiz.quiz_id.ToString()) && i.student_id.Contains(student_Quiz.student_id)).ToList<Student_Answers>();
        }
    }
}