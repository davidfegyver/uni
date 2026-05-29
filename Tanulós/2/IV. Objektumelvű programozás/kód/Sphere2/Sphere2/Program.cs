//Author:   Gregorics Tibor
//Date:     2021.11.05.
//Title:    Generalization: point is a special sphere

using System;

namespace Sphere2
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

    class Point : Sphere
    {
        public Point(double a, double b, double c) : base(a, b, c, 0.0) { }
    }

    class Sphere
    {
        class IllegalRadiusException : Exception { }

        protected readonly double x, y, z;
        private readonly double radius;

        public Sphere(double a, double b, double c, double d = 0.0)
        {
            x = a; y = b; z = c;
            radius = d;
            if (radius < 0.0) throw new IllegalRadiusException();
        }
        public double Distance(Sphere g)
        { 
            return Math.Sqrt(Math.Pow((x-g.x),2) + Math.Pow((y-g.y),2) + Math.Pow((z-g.z),2))   
             -radius - g.radius; 
        }

        public bool Contains(Sphere g)
        {
            return Distance(g) + 2 * g.radius <= 0;
        }
    }
 }
