using Polygon;
using TextFile;

namespace TestPolygon
{
    [TestClass]
    class UnitTestPolygon
    {
        [TestMethod]
        public void TestCreate()
        {
            Assert.ThrowsException<Polygon.Polygon.FewVerticesException>(() => Polygon.Polygon.Create(new TextFileReader("inp.txt"), 2));
        }

        [TestMethod]
        public void TestShift()
        {
            Polygon.Polygon p = Polygon.Polygon.Create(new TextFileReader("inp.txt"), 3);
            p.Shift(new Point(1.0, 1.0));
            foreach (Point v in p)
            { 
                Assert.AreEqual(v.X, v.X + 1.0);
                Assert.AreEqual(v.Y, v.Y + 1.0);
            }

            p = Polygon.Polygon.Create(new TextFileReader("inp.txt"), 5);
            p.Shift(new Point(1.0, 1.0));
            foreach(Point v in p)
            {
                Assert.AreEqual(v.X, v.X + 1);
                Assert.AreEqual(v.Y, v.Y + 1);
            }
        }

        [TestMethod]
        public void TestCentroid()
        {
            Polygon.Polygon p = Polygon.Polygon.Create(new TextFileReader("inp.txt"), 3);
            Assert.AreEqual(p.Centroid(), 1.1);

            p = Polygon.Polygon.Create(new TextFileReader("inp.txt"), 5);
            Assert.AreEqual(p.Centroid(), 1.1);
        }
    }
}
