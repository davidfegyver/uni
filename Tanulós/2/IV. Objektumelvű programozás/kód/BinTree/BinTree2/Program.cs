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

            Console.Write("\nPreorder traversal: ");
            t.PreOrder();
            Console.Write("\nInorder traversal:  ");
            t.InOrder();
            Console.Write("\nPostorder traversal:");
            t.PostOrder();
            Console.WriteLine();

 //           t.LevelOrder();
            Console.WriteLine();

            Console.WriteLine($"\nSum of nodes: {t.Sum()}");

            try
            {
                Console.WriteLine($"\nMax of nodes: {t.Max()}");
            }
            catch(BinTree.NoRootException)
            {

            }

            if(t.CondMax(out int max))
            {
                Console.WriteLine($"\nMax of inner nodes: {max}");
            }
            else Console.WriteLine($"\nNo inner nodes");

            if (t.SearchPreOrder(out int e))
            {
                Console.WriteLine($"\nFirst even number: {e}");
            }
            else Console.WriteLine($"\nNo even numbers");

        }
    }
}