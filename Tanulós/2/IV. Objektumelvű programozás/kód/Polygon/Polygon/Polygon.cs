//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    class of polygons 

using System;
using TextFile;
using System.Collections;

namespace Polygon
{
    public class Polygon : IEnumerable
    {
        public class FewVerticesException : Exception { }

        private readonly Point[] vertices;

        public int Sides
        { 
            get => vertices.Length;     // get { return vertices.Length; } 
        }

        public Point this[int i]
        {
            get => vertices[i];         // get { return vertices[i]; }
            set => vertices[i] = value; // set { vertices[i] = value; } 
        }

        public Polygon(int m)
        {
            if (m < 3) throw new FewVerticesException();
            vertices = new Point[m];

            for (int i = 0; i < m; ++i) vertices[i] = new Point();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            foreach (Point vertex in vertices )
            {
                yield return vertex;
            }
        }

        //Task: 	prepearing for writing the vertices of a polygon
        //Input:    this        -  polygon
        //          string      -  polygon
        //Output:   ostream o   -  output adatfolyam
        //Activity: writing coordinates of all vertices of the polygon
        public override string ToString()
        {
            string str = "< ";
            foreach (Point vertex in vertices)
            {
                str += vertex.ToString();
            }
            str += " >";
            return str;
        }

        //Task: 	creating a polygon based on a textfile
        //Input:    ifstream inp   -  textfile
        //Output:   Polygon this   -  polygon
        //Activity: constructing a polygon and setting coordinates of its vertices
        public static Polygon Create(TextFileReader reader, int sides)
        {
            Polygon p = new (sides);
            for (int i = 0; i < sides; ++i)
            {
                reader.ReadDouble(out double x);
                reader.ReadDouble(out double y);
                p[i].SetPoint(x, y);  
            }
            return p;
        }

        //Task: 	computing the center of a polygon polygon
        //Input:    Polygon this   -  polygon
        //Output:   Point center   -  polygon
        //Activity: computing the sum of the vertices of the polygon 
        //          and dividing it by the number of the vertices
        public Point Centroid()
        {
            Point centroid = new();
            foreach (Point vertex in vertices)
            {
                centroid.Add(vertex);
            }
            centroid.DivideBy(Sides);
            return centroid;

            /* Alternative solutions if Point has operator+ instead of Add() and operator/ instead of DivideBy() 
            Point centroid = new();
            foreach (Point vertex in vertices)
            {
                centroid += vertex;
            }
            return centroid/Sides;
            */
        }

        //Task: 	moving a polygon
        //Input:    Polygon this   -  polygon
        //          Point mp       -  moving vector
        //Output:   Polygon this   -  polygon
        //Activity: moving of all vertices of the polygon
        public void Shift(Point e)
        {
            foreach (Point vertex in vertices)
            {
                vertex.Add(e);
            }

            /* Alternative solutions if Point has operator+ instead of Add()
            for (int i = 0; i < vertices.Length; ++i)
            {
                vertices[i] += e;
            }

            foreach (Point vertex in vertices)
            {
                vertex.SetPoint(vertex.X + e.X, vertex.Y + e.Y);
            }
            */

        }
    }
}