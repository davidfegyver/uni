namespace Courses
{
    enum Category { excellent = 5, good = 4, satisfactory = 3, poor = 2, insufficient = 1, no_grade = 0, not_appear = -1 }
    class Grade
    {
        public Category value;
        public string teacher;

        public Grade()
        {
            value = Category.no_grade;
            teacher = "";
        }
        public override string ToString()
        {
            return value.ToString() + " by " + teacher;
        }
    }
}
