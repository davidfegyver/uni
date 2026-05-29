//Author:   Gregorics Tibor
//Date:     2021.11.12.
//Title:    concrete and abstract classes of different shapes

using System;
using TextFile;

namespace Shapes
{
    abstract class Shape
    {
        protected double size;

        protected Shape(double size)
        {
            this.size = size;
            ++piece;
        }

        ~Shape()
        {
            --piece;
        }

        public abstract double Volume();

        private static int piece = 0;
        public static int Piece() { return piece; }

        public class UnknownShapeException : Exception { }

        public static bool Create(ref TextFileReader reader, out Shape sh)
        {
            sh = null;
            if (reader.ReadString(out string type))
            {
                reader.ReadDouble(out double size);
                switch (type)
                {
                    case "Cube": sh = new Cube(size); break;
                    case "Sphere": sh = new Sphere(size); break;
                    case "Tetrahedron": sh = new Tetrahedron(size); break;
                    case "Octahedron": sh = new Octahedron(size); break;
                    case "Cylinder":
                        reader.ReadDouble(out double height);
                        sh = new Cylinder(size, height); break;
                    case "SquarePrism":
                        reader.ReadDouble(out height);
                        sh = new SquarePrism(size, height); break;
                    case "TriangularPrism":
                        reader.ReadDouble(out height);
                        sh = new TriangularPrism(size, height); break;
                    case "Cone":
                        reader.ReadDouble(out height);
                        sh = new Cone(size, height); break;
                    case "SquarePyramid":
                        reader.ReadDouble(out height);
                        sh = new SquarePyramid(size, height); break;
                    default: throw new UnknownShapeException();
                }
                return true;
            }
            else return false;
        }
    }

    // Regular shapes

    abstract class Regular : Shape
    {
        protected Regular(double size) : base(size) { ++piece; }
        ~Regular()
        {
            --piece;
        }

        public override double Volume()
        {
            return size * size * size * Coefficient();
        }

        protected abstract double Coefficient();

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    class Sphere : Regular
    {
        public Sphere(double size) : base(size) { ++piece; }
        ~Sphere()
        {
            --piece;
        }

        private const double coefficient = 4.0 * 3.14159 / 3.0;
        protected override double Coefficient()
        {
            return coefficient;
        }

       private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    class Cube : Regular
    {
        public Cube(double size) : base(size) { ++piece; }
        ~Cube()
        {
            --piece;
        }
        protected override double Coefficient()
        {
            return 1.0;
        }

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    class Tetrahedron : Regular
    {
        public Tetrahedron(double size) : base(size) { ++piece; }
        ~Tetrahedron()
        {
            --piece;
        }

        private const double coefficient = 1.4142135 / 12.0;
        protected override double Coefficient()
        {
            return coefficient;
        }

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    class Octahedron : Regular
    {
        public Octahedron(double size) : base(size) { ++piece; }
        ~Octahedron()
        {
            --piece;
        }

        private const double coefficient = 1.4142135 / 3.0;
        protected override double Coefficient()
        {
            return coefficient;
        }

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    //Prismatic shapes

    abstract class Prismatic : Shape
    {
        protected Area area;
        protected double height;
        protected Prismatic(double size, double height) : base(size) 
        { 
            this.height = height;
            ++piece; 
        }
        ~Prismatic()
        {
            --piece;
        }
        public override double Volume()
        {
            return area.Value(size) * height;
        }

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    class Cylinder : Prismatic
    {
        public Cylinder(double size, double height) : base(size, height)
        {
            area = CircleArea.Instance(); 
            ++piece;
        }
        ~Cylinder()
        {
            --piece;
        }

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    class SquarePrism : Prismatic
    {
        public SquarePrism(double size, double height) : base(size, height)
        {
            area = SquareArea.Instance();
            ++piece;
        }
        ~SquarePrism()
        {
            --piece;
        }

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    class TriangularPrism : Prismatic
    {
        public TriangularPrism(double size, double height) : base(size, height)
        {
            area = TriangularArea.Instance();
            ++piece;
        }
        ~TriangularPrism()
        {
            --piece;
        }

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    // Pyramidal shapes

    abstract class Pyramidal : Prismatic
    {
        protected Pyramidal(double size, double height) : base(size, height)
        {
            this.height = height;
            ++piece;
        }
        ~Pyramidal()
        {
            --piece;
        }

        public override double Volume()
        {
            return area.Value(size) * height / 3.0;
        }

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    class Cone : Pyramidal
    {
        public Cone(double size, double height) : base(size, height) 
        {
            area = CircleArea.Instance();
            ++piece;
        }
        ~Cone()
        {
            --piece;
        }

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }

    class SquarePyramid : Pyramidal
    {
        public SquarePyramid(double size, double height) : base(size, height)
        {
            area = SquareArea.Instance();
            ++piece;
        }
        ~SquarePyramid()
        {
            --piece; 
        }

        private static int piece = 0;
        public static new int Piece() { return piece; }
    }
}
