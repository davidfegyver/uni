//Author:   Gregorics Tibor
//Date:     2021.11.12.
//Title:    Creating different shapes 

using System;
using System.Collections.Generic;
using TextFile;

namespace Shapes
{
    class Program
    {
        static void Main()
        {
            TextFileReader reader = new (@"..\..\..\shapes.txt");

            List<Shape> shapes = new ();

            while (Shape.Create(ref reader, out Shape sh))
            {
                shapes.Add(sh);
            }

            Statistics();

            Console.WriteLine("Volumes:");
            foreach (Shape shape in shapes)
            {
                Console.WriteLine($"{shape.ToString().Substring(7)} : " + $"{shape.Volume():f2}" );
            }
        }

        static void Statistics()
        {
            Console.WriteLine($"\nall: {Shape.Piece()}\n"
                + $" regulars: {Regular.Piece()}  :\tspheres: {Sphere.Piece()}, cubes: {Cube.Piece()}, tetrahedrons: {Tetrahedron.Piece()}, octahedron: {Octahedron.Piece()}\n"
                + $" prismatics: {Prismatic.Piece()}:\tcylinders: {Cylinder.Piece()}, squarePrisms: {SquarePrism.Piece()}, triangularPrisms: {TriangularPrism.Piece()}\n"
                + $" pyramidals: {Pyramidal.Piece()}:\tcones: {Cone.Piece()}, squarePyramids: {SquarePyramid.Piece()}" );
        }
    }
}
