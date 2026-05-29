//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    Test cases of height of the highest depression

using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using Depression;

namespace TestDepression
{
    [TestClass]
    public class MaxSearchTests
    {
        [TestMethod]
        public void Test_NoTextFile()
        {
            Assert.ThrowsException<FileNotFoundException>(() => Program.MaxSearch("blabla.txt", out double max, out int where));
        }

        [TestMethod]
        public void Test_EmptyEnumerator()
        {
            bool l = Program.MaxSearch("empty.txt", out double max, out int where);
            Assert.AreEqual(l, false);

            // { 2.0, 1.0 };
            l = Program.MaxSearch("two_values.txt", out max, out where);
            Assert.AreEqual(l, false);
        }

        [TestMethod]
        public void Test_OneLengthEnumerator()
        {
            // { 2.1, 1.0, 2.4 };
            bool l = Program.MaxSearch("one_depression1.txt", out double max, out int where);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 1.0);
            Assert.AreEqual(where, 2);
        }

        [TestMethod]
        public void Test_SeveralLengthEnumerator()
        {
            // { 1.0, 2.0, 1.5, 4.0, 2.0 };
            bool l = Program.MaxSearch("one_depression2.txt", out double max, out int where);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 1.5);
            Assert.AreEqual(where, 3);
        }

        [TestMethod]
        public void Test_HasDepression()
        {
            // { 1.0, 2.0, 1.0, 4.0, 2.0 };
            bool l = Program.MaxSearch("one_depression3.txt", out double max, out int where);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 1.0);
            Assert.AreEqual(where, 3);
        }
        [TestMethod]
        public void Test_First()
        {
            // { 3.0, 2.5, 3.0, 2.0, 3.0 };
            bool l = Program.MaxSearch("two_depressions1.txt", out double max, out int where);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 2.5);
            Assert.AreEqual(where, 2);
        }

        [TestMethod]
        public void Test_Last()
        {
            // { 3.0, 2.0, 3.0, 2.5, 3.0 };
            bool l = Program.MaxSearch("two_depressions2.txt", out double max, out int where);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 2.5);
            Assert.AreEqual(where, 4);
        }

        [TestMethod]
        public void Test_SeveralMaxs()
        {
            // { 3.0, 2.0, 3.0, 2.0, 3.0 };
            bool l = Program.MaxSearch("two_depressions3.txt", out double max, out int where);
            Assert.AreEqual(l, true);
            Assert.AreEqual(max, 2.0);
            Assert.IsTrue(where == 2 || where == 4);
        }

        [TestMethod]
        public void Test_NoDepression()
        {
            // { 1.0, 2.0, 3.0, 4.0, 5.0 };
            bool l = Program.MaxSearch("no_depressions.txt", out double max, out int where);
            Assert.AreEqual(l, false);
        }

    }
}
