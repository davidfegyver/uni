using System;
using System.Collections.Generic;

namespace Courses
{
    class Person
    {
        public class WrongPassword : Exception { }

        public readonly string Name;
        public string Id {  get; private set; }
        private string password;
        public Centre centre;

        protected readonly List<Course> courses = new List<Course>();
        public Person(string name, string id)
        {
            Name = name; 
            Id = id;
            password = id;
        }
        public void ModifyPassword(string oldpw, string newpw) 
        {
            if (password != oldpw) throw new WrongPassword();
            password = newpw;
        }        
        public bool OKPW(string pw) { return pw == password; }
    }

    class Teacher : Person
    {
        public Teacher(string name, string id) : base(name, id) { }
        public void Undertakes(Course c)
        {
            c.AddTeacher(this);
            courses.Add(c);
        }

        public void Drops(Course c)
        {
            c.RemoveTeacher(this);
            courses.Remove(c);
        }
    }

    class Student : Person
    {
        private readonly List<Control> controls = new List<Control> ();
        public Student(string name, string id) : base(name, id) { }

        public void SignsUp(Course c)
        {
            c.AddStudent(this);
            courses.Add(c);
        }
        public void SignsDown(Course c)
        {
            c.RemoveStudent(this);
            courses.Remove(c);
        }
        public void AddControl(Control ex)
        {
            controls.Add(ex);
        }

        public void RemoveControl(Control ex)
        {
            controls.Remove(ex);
        }

    }
}
