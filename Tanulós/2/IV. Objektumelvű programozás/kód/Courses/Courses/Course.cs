//Author:   Gregorics Tibor
//Date:     2021.11.05.
//Title:    class of courses

using System;
using System.Collections.Generic;

namespace Courses
{
    abstract class Course
    {
        public class TooManyTeachersLeadThisCourse : Exception { }
        public class TeacherHasLeadThisCourse : Exception { }
        public class TeacherNotFoundInCourse : Exception { }
        public class TeacherHasNoPermission : Exception { }
        public class TeacherCannotRemoved : Exception { }
        public class TooManyStudentsLeadThisCourse : Exception { }
        public class NoTeacherInThisCourse : Exception { }
        public class StudentHasSignedUpThisCourse : Exception { }
        public class StudentNotFoundInCourse : Exception { }
        public class StudentHasNoPermission : Exception { }
        public class ControlNotFoundInCourse : Exception { }

        public readonly string Name;
        public int Max { get; private set; }

        public void ChangeMax(int max, Teacher teacher)
        {
            centre.Authentication(teacher); 
            if (!teachers.Contains(teacher)) throw new TeacherNotFoundInCourse();
            Max = max;
        }
        private readonly List<Student> students = new (); // 0 .. max
        private readonly List<Teacher> teachers = new (); // 0 .. 2
        public List<Teacher> Teachers { get { return teachers; } }
       
        protected Centre centre;

        public readonly List<Control> controls = new ();

        public Course(string name, int max, Centre centre)
        {
            Name = name;
            Max = max;
            this.centre = centre;
        }

        public void AddTeacher(Teacher teacher)
        {
            centre.Authentication(teacher);
            if (teachers.Count == 2) throw new TooManyTeachersLeadThisCourse();
            if (teachers.Contains(teacher)) throw new TeacherHasLeadThisCourse();
            teachers.Add(teacher);
        }
        public void RemoveTeacher(Teacher teacher)
        {
            centre.Authentication(teacher);
            if (!teachers.Contains(teacher)) throw new TeacherNotFoundInCourse();
            if (teachers.Count == 1 && students.Count > 0) throw new TeacherCannotRemoved();
            teachers.Remove(teacher);
        }

        public void AddStudent(Student student)
        {
            centre.Authentication(student);
            if (teachers.Count == 0) throw new NoTeacherInThisCourse();
            if (students.Count == Max) throw new TooManyStudentsLeadThisCourse();
            if (students.Contains(student)) throw new StudentHasSignedUpThisCourse();
            students.Add(student);
        }
        public void RemoveStudent(Student student)
        {
            centre.Authentication(student);
            if (!students.Contains(student)) throw new StudentNotFoundInCourse();
            students.Remove(student);
        }

        protected abstract bool Check(DateTime date, string name = "");
        protected void CheckAnnounce(Teacher teacher, DateTime date, string name = "")
        {
            centre.Authentication(teacher);
            if (!teachers.Contains(teacher)) throw new TeacherHasNoPermission();
            if (!Check(date, name)) throw new Control.WrongControlParameters();
        }
        public bool In(Student student)
        {
            centre.Authentication(student);
            return students.Contains(student);
        }
        public void DeleteControl(Teacher teacher, Control control)
        {
            centre.Authentication(teacher);
            if (!teachers.Contains(teacher)) throw new TeacherHasNoPermission();
            if (!controls.Contains(control)) throw new ControlNotFoundInCourse();
            foreach (Student e in students)
            {
                e.RemoveControl(control);
            }
            controls.Remove(control);
        }
        public Category Grade(Student student, Person person)
        {
            centre.Authentication(student); 
            centre.Authentication(person);
            if (person is Teacher t && !teachers.Contains(t)) throw new TeacherHasNoPermission();
            if (person is Student && !person.Equals(student)) throw new StudentHasNoPermission();
            return ComputeGrade(student, person);
        }

        public abstract Category ComputeGrade(Student student, Person person);
    }

    class Practice : Course
    {
        public Practice(string name, int max, Centre centre) : base(name, max, centre) { }
        protected override bool Check(DateTime date, string name)
        {
            foreach (Control test in controls)
            {
                if ( ((Test)test).name == name && test.date == date) return false;
            }
            return true;
        }
        public Test Announce(Teacher teacher, DateTime date, int limit, string name)
        {
            CheckAnnounce(teacher, date, name);
            Test test = new (this, date, limit, name, centre);
            controls.Add(test);
            return test;
        }
        public override Category ComputeGrade(Student student, Person person)
        {
            centre.Authentication(student);
            centre.Authentication(person);
            int sum = 0;
            Dictionary<string, int> results = new ();
            foreach (Control test in controls)
            {
                int res = Convert.ToInt32(test.Result(student, person).value);
                string name = ((Test)test).name;
                if (!results.ContainsKey(name))
                {
                    sum += res;
                    results.Add(name, res);
                }
                else if (results[name] < res)
                {
                    sum = sum - results[name] + res;
                    results[name] = res;
                }
            }
            if (results.Count == 0) return Category.no_grade;
            else return (Category)(Convert.ToInt32(Math.Round(Convert.ToDouble(sum) / results.Count, 0)));
        }
    }
    class Lecture : Course
    {
        public Lecture(string name, int max, Centre centre) : base(name, max, centre) { }

        protected override bool Check(DateTime date, string name = "")
        {
            foreach (Control exam in controls)
            {
                if (exam.date == date) return false;
            }
            return true;
        }
        public Exam Announce(Teacher teacher, DateTime date, int limit)
        {
            centre.Authentication(teacher); 
            CheckAnnounce(teacher, date);
            Exam exam = new (this, date, limit, centre);
            controls.Add(exam);
            return exam;
        }
        public override Category ComputeGrade(Student student, Person person)
        {
            centre.Authentication(student);
            centre.Authentication(person);
            Category max = 0;
            foreach (Control exam in controls)
            {
                Category res = exam.Result(student, person).value;
                if (max < res) max = res;
            }
            return max;
        }
    }
}
