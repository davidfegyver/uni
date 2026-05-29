//Author:   Gregorics Tibor
//Date:     2021.11.05.
//Title:    Students - teachers - courses

using System;
using System.Collections.Generic;
using TextFile;

namespace Courses
{
    class Program
    {
        class WrongObjectName : Exception { }

        static readonly Dictionary<string, Person> persons = new Dictionary<string, Person>();
        static readonly Dictionary<string, Course> courses = new Dictionary<string, Course>();
        static readonly Dictionary<string, Control> controls = new Dictionary<string, Control>();
        static Person Person(string name)
        {
            if (!persons.ContainsKey(name)) throw new WrongObjectName();
            return persons[name];
        }
        static Course Course(string name)
        {
            if (!courses.ContainsKey(name)) throw new WrongObjectName();
            return courses[name];
        }
        static Control Control(string name)
        {
            if (!controls.ContainsKey(name)) throw new WrongObjectName();
            return controls[name];
        }

        static void Main()
        {
            Person adm = new Person("Admin", "000000");
            Centre centre = new Centre(adm);

            TextFileReader reader = new TextFileReader("input.txt");
            char[] separators = new char[] { ' ', '\t' };

            while (reader.ReadLine(out string line))
            {
                string[] tokens = line.Split(separators, StringSplitOptions.RemoveEmptyEntries);
                try
                {
                    switch (tokens[0])
                    {
                        case "PRA":
                            courses.Add(tokens[1], new Practice(tokens[1], Convert.ToInt32(tokens[2]), centre)); break;
                        case "LEC": courses.Add(tokens[1], new Lecture(tokens[1], Convert.ToInt32(tokens[2]), centre)); break;
                        case "TEA":
                            Teacher t = new Teacher(tokens[1], tokens[2]);
                            centre.ModifyPassword(t, centre.Registrate(t, adm), tokens[3]);
                            t.ModifyPassword(tokens[2], tokens[3]);
                            persons.Add(tokens[1], t);
                            break;
                        case "STU":
                            Student s = new Student(tokens[1], tokens[2]);
                            centre.ModifyPassword(s, centre.Registrate(s, adm), tokens[3]);
                            s.ModifyPassword(tokens[2], tokens[3]);
                            persons.Add(tokens[1], s);
                            break;
                        case "UNTA": ((Teacher)persons[tokens[1]]).Undertakes(Course(tokens[2])); break;
                        case "GIUP": ((Teacher)persons[tokens[1]]).Drops(Course(tokens[2])); break;
                        case "SIUP": ((Student)persons[tokens[1]]).SignsUp(Course(tokens[2])); break;
                        case "SIDO": ((Student)persons[tokens[1]]).SignsDown(Course(tokens[2])); break;
                        case "ANNO":
                            Course course = Course(tokens[2]);
                            Control ex = null;
                            if      ( course is Practice p ) ex = p.Announce((Teacher)persons[tokens[1]], DateTime.Parse(tokens[4]), int.Parse(tokens[5]), tokens[6]);
                            else if ( course is Lecture l )  ex = l.Announce((Teacher)persons[tokens[1]], DateTime.Parse(tokens[4]), int.Parse(tokens[5]));
                            controls.Add(tokens[3], ex);
                            break;
                        case "DELE": Course(tokens[2]).DeleteControl((Teacher)persons[tokens[1]], Control(tokens[3])); break;
                        case "REGI": Control(tokens[2]).Registrate((Student)persons[tokens[1]]); break;
                        case "UNRE": Control(tokens[2]).Unregistrate((Student)persons[tokens[1]]); break;
                        case "EVAL": Control(tokens[2]).Evaluate((Student)persons[tokens[3]], (Category)int.Parse(tokens[4]), (Teacher)persons[tokens[1]]); break;
                        case "RESU": Console.WriteLine($"{Control(tokens[3]).Result((Student)Person(tokens[2]), persons[tokens[1]])}"); break;
                        case "QUAL": Console.WriteLine($"{Course(tokens[3]).Grade((Student)Person(tokens[2]), persons[tokens[1]])}"); break;
                        default: Console.WriteLine("Wrong command name in the current row of the input file"); break;
                    }
                }
                catch (Centre.PersonHasAlreadyRegistrated) { Console.WriteLine("This person has been registrated"); }
                catch (Centre.PersonNotAuthenticated)      { Console.WriteLine("Actor is not authenticated"); }
 
                catch (Person.WrongPassword) { Console.WriteLine("Wrong password"); }

                catch (WrongObjectName) { Console.WriteLine("Name of person, course or control in the input file does not exsist");}
                     
                catch (Course.NoTeacherInThisCourse)   { Console.WriteLine("NoTeacherInThisCourse"); }
                catch (Course.TeacherNotFoundInCourse) { Console.WriteLine("TeacherNotFoundInCourse"); }
                catch (Course.TeacherHasNoPermission)  { Console.WriteLine("TeacherHasNoPermission"); }
                catch (Course.TeacherCannotRemoved)    { Console.WriteLine("TeacherCannotRemoved"); }
                catch (Course.StudentNotFoundInCourse) { Console.WriteLine("StudentNotFoundInCourse"); }
                catch (Course.StudentHasNoPermission)  { Console.WriteLine("StudentHasNoPermission"); }
                catch (Course.ControlNotFoundInCourse) { Console.WriteLine("ControlNotFoundInCourse"); }

                catch (Control.StudentNotRegistrated)  { Console.WriteLine("StudentNotRegistrated"); }
                catch (Control.StudentAlreadyRegistrated) { Console.WriteLine("StudentAlreadyRegistrated"); }
                catch (Control.WrongControlParameters) { Console.WriteLine("WrongControlParameters"); }
            }
        }
    }
}
