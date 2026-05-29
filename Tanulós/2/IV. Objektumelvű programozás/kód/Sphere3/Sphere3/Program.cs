//Author:   Gregorics Tibor
//Date:     2021.11.05.
//Title:    Generalization: sphere is a special point

using System;

namespace Sphere3
{
    class Program
    {
        static void Main()
        {
            Point p = new (0, 0, 0);
            Sphere g = new (1, 1, 1, 1);

            Console.WriteLine("p.Distance(p): {0}", p.Distance(p));
            Console.WriteLine("g.Distance(p): {0}", g.Distance(p));
            Console.WriteLine("p.Distance(g): {0}", p.Distance(g));
            Console.WriteLine("g.Distance(g): {0}", g.Distance(g));
            Console.WriteLine("g.Contains(p): {0}", g.Contains(p));
            Console.WriteLine("g.Contains(g): {0}", g.Contains(g));
        }
    }

    class Point
    {
        private readonly double x, y, z;

        public Point(double a, double b, double c) { x = a; y = b; z = c; }

        public double Distance(Point p)
        {
            return Math.Sqrt (Math.Pow(x - p.x, 2) + Math.Pow(y - p.y, 2) + Math.Pow(z - p.z, 2) ) - Radius() - p.Radius();
        }
        public virtual double Radius() { return 0.0; }
    }

    class Sphere : Point
    {
        class IllegalRadiusException : Exception { }

        private readonly double radius;

        public Sphere(double a, double b, double c, double d) : base(a, b, c)
        {

            radius = d;
            if (radius < 0.0) throw new IllegalRadiusException();
        }

        public bool Contains(Point p)
        {
            return Distance(p) + 2 * p.Radius() <= 0;
        }

        public override double Radius()  
        { 
            return radius; 
        }
    }
}
