//Author:   Gregorics Tibor
//Date:     2021.11.05.
//Title:    Composition: point is a part of sphere

using System;

namespace Sphere1
{
    class Program
    {
        static void Main()
        {
            Point p = new (0, 0, 0);
            Sphere g = new (new Point(1, 1, 1), 1);

            Console.WriteLine("p.Distance(p): {0}", p.Distance(p));
            Console.WriteLine("g.Distance(p): -");
            Console.WriteLine("p.Distance(g): -");
            Console.WriteLine("g.Distance(g): -");
            Console.WriteLine("g.Contains(p): {0}", g.Contains(p));
            Console.WriteLine("g.Contains(g): -");
        }
    }

    class Point
    {
        private readonly double x, y, z;

        public Point(double a, double b, double c) { x = a; y = b; z = c; }

        public double Distance( Point p) 
        {
            return Math.Sqrt(Math.Pow(x-p.x,2) + Math.Pow(y-p.y,2) + Math.Pow(z-p.z,2)); 
        }
    }

    class Sphere
    {
        public class IllegalRadiusException : Exception { }

        private readonly Point centre;
        private readonly double radius;

        public Sphere(Point c, double r) 
        {
            centre = c; 
            radius = r; 
            if (radius < 0.0) throw new IllegalRadiusException();
        }

        public bool Contains(Point p) 
        {
            return centre.Distance(p) <= radius; 
        }
    }
}
