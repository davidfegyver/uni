//Author:   Gregorics Tibor
//Date:     2021.11.12.
//Title:    Different area calculating and their interface

#nullable enable

namespace Shapes
{
    abstract class  Area
    {
        public double Value(double size) { return Coefficient() * System.Math.Pow(size,2); }
        protected abstract double Coefficient();
    }

    class SquareArea : Area
    {
        private SquareArea() { }
        protected override double Coefficient()
        {
            return 1;
        }
        
        private static SquareArea? instance;
        public static SquareArea? Instance()
        {
            instance ??= new SquareArea();
            return instance;
        }
    }

    class CircleArea : Area
    {
        private CircleArea() { }
        protected override double Coefficient()
        {
            return 3.14159;
        }

        private static CircleArea? instance;
        public static CircleArea? Instance()
        {
            instance ??= new CircleArea();
            return instance;
        }
    }

    class TriangularArea : Area
    {
        private TriangularArea() { }
        protected override double Coefficient()
        {
            return 1.73205 / 4.0;
        }

        private static TriangularArea? instance;
        public static TriangularArea? Instance()
        {
            instance ??= new TriangularArea();
            return instance;
        }
    }
}
