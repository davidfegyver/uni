using System;
using System.Collections.Generic;

namespace Courses
{
    class Control
    {
        public class StudentNotRegistrated : Exception { }
        public class StudentAlreadyRegistrated : Exception { }
        public class NewStudentOverLimit : Exception { }
        public class WrongControlParameters : Exception { }

        public class TimeLimit : Exception { }

        public readonly Course course;
        public readonly DateTime date;
        public int Limit { get; private set; }
        protected readonly Dictionary<Student, Grade> students = new ();
        protected Centre centre;

        protected Control(Course course, DateTime date, int limit, Centre centre)
        {
            this.course = course;
            this.date = date;
            Limit = limit;
            this.centre = centre;
        }
        public void Registrate(Student student)
        {
            centre.Authentication(student);
            if (!course.In(student) ) throw new Course.StudentNotFoundInCourse();
            if (DateTime.Now > date) throw new TimeLimit();
            if (students.Count == Limit) throw new NewStudentOverLimit();
            if (students.ContainsKey(student)) throw new StudentAlreadyRegistrated();
            students.Add(student, new Grade());
            student.AddControl(this);
        }
        public void Unregistrate(Student student)
        {
            centre.Authentication(student);
            if (!students.ContainsKey(student)) throw new StudentNotRegistrated();
            if (DateTime.Now > date) throw new TimeLimit();
            students.Remove(student);
            student.RemoveControl(this);
        }
        public void Evaluate(Student student, Category category, Teacher teacher)
        {
            centre.Authentication(teacher); 
            if (!course.Teachers.Contains(teacher)) throw new Course.TeacherNotFoundInCourse();
            if (!students.ContainsKey(student)) throw new StudentNotRegistrated();
            students[student].value = category;
            students[student].teacher = teacher.Name;
        }
        public Grade Result(Student student, Person person)
        {
            centre.Authentication(person);
            if ( person is Student s && !s.Equals(student) )  throw new Course.StudentHasNoPermission();
            if ( person is Teacher t && !course.Teachers.Contains(t) ) throw new Course.TeacherHasNoPermission();
            if (!students.ContainsKey(student)) return new Grade();
            return students[student];
        }
    }

    class Test : Control
    {
        public readonly string name;
        public Test(Course course, DateTime date, int limit, string name, Centre centre) : base(course, date, limit, centre) 
        {
            this.name = name;
        }
    }
    class Exam : Control
    {
        public Exam(Course course, DateTime date, int limit, Centre centre) : base(course, date, limit, centre) { }
    }
}
