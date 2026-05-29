//Author:   Gregorics Tibor
//Date:     2021.11.11.
//Title:    Building a binary tree including integers, and implementing algorithmic patterns over the tree 

using System;

namespace BinTree
{
    class Program
    {
        static void Main()
        {
            BinTree t = new ();

            Console.WriteLine("Give the elements of the tree: ");
            int i;
            while ((i = int.Parse(Console.ReadLine()!)) != 0)
            {
                t.RandomInsert(i);
            }

            t.Write();
            Console.WriteLine();

            Writer print = new ();
            Console.Write("\nPreorder traversal: ");
            t.PreOrder(print);
            Console.Write("\nInorder traversal:  ");
            t.InsOrder(print);
            Console.Write("\nPostorder traversal:");
            t.PostOrder(print);
            Console.WriteLine();

            Summation sum = new ();
            t.PreOrder(sum);
            Console.WriteLine($"\nSum of elements: {sum.Sum}");

            try
            {
                MaxSelect max1 = new (t.Root);
                t.PreOrder(max1);
                Console.WriteLine($"\nMaxima of elements: {max1.Max}");
            }
            catch (BinTree.NoRootException)
            {
                Console.WriteLine("Empty tree.");
            }

            Search search = new ();
            try
            {
                t.PreOrder(search);
                Console.WriteLine("\nNo even numbers");
            }
            catch (Found)
            {
                Console.WriteLine($"\nFirst even number: {search.Value}");
            }

            CondMaxSearch max2 = new ();
            t.PreOrder(max2);
            Console.Write("\nMaxima of internal elements: ");
            if (max2.Found) Console.WriteLine(max2.Max);
            else Console.WriteLine("none");
        }
    }
}