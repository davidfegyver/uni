using Polygon;
using System.Globalization;


namespace TestPolygon
{
    [TestClass]
    public class UnitTestPoint
    {
        [TestMethod]
        public void TestAdd()
        {
            // associative
            Point a = new (2.5, -1.0);
            Point b = new(0.5, 1.0);
            Point c = new(-3.0, 0.0);
            Point e1 = new();
            Point e2 = new();
            e1.Add(a); e1.Add(b); e1.Add(c);
            e2.Add(a); e2.Add(b); e2.Add(c);
            Assert.AreEqual(e1.X, e2.X);
            Assert.AreEqual(e1.Y, e2.Y);

            //commutative
            a = new(2.5, -1.0);
            b = new(0.5, 1.0);
            e1 = new();
            e2 = new();
            e1.Add(a); e1.Add(b); 
            e2.Add(b); e2.Add(a); 
            Assert.AreEqual(e1.X, e2.X);
            Assert.AreEqual(e1.Y, e2.Y);

            //neutral
            a = new(1.0, -1.0);
            e1 = new();
            e1.Add(a); 
            Assert.AreEqual(e1.X, a.X);
            Assert.AreEqual(e1.Y, a.Y);

            //inverse
            a = new(1.0, -1.0);
            b = new(-1.0, 1.0);
            e1 = new();
            e1.Add(a); e1.Add(b);
            Assert.AreEqual(e1.X, 0.0);
            Assert.AreEqual(e1.Y, 0.0);
        }

        [TestMethod]
        public void TestDivideBy()
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            Point a = new(1.0, 1.0);
            a.DivideBy(3);
            Assert.AreEqual(a.X.ToString("0.0#"),"0.33");

            Assert.ThrowsException<System.DivideByZeroException>(() => a.DivideBy(0));
        }
    }
}