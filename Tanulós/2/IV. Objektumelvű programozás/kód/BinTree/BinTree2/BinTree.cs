//Author:   Gregorics Tibor
//Date:     2021.11.11.
//Title:    generic class of binary trees 

using System;

namespace BinTree
{
    public class BinTree
    {
        public class NoRootException : Exception { }

        private Node? root;
        
        public int Root
        {
            get
            {
                if (root == null) throw new NoRootException();
                return root.Value;
            }
        }

        public BinTree() { root = null; }       
        
        public bool Empty() { return root == null; }

        public void RandomInsert(int e) { 
            if (root == null) root = new LeafNode(e, null); 
            else root = root.RandomInsert(e); 
        }

        public void PreOrder()  { root?.PreOrder(); }
        public void InOrder()  { root?.InOrder(); }
        public void PostOrder() { root?.PostOrder(); }
/*
        public void LevelOrder() 
        {
            Console.Write($" {root!.Value} ");
            if (root.Left != null)  Console.Write($" {root.Left.Value} ");  else Console.Write(" na ");
            if (root.Right != null) Console.Write($" {root.Right.Value} "); else Console.Write(" n a");
            if ( root.Left != null)
            {
                if (root.Left.Left != null)  Console.Write($" {root.Left.Left.Value} "); else Console.Write(" na ");
                if (root.Left.Right != null) Console.Write($" {root.Left.Right.Value} "); else Console.Write(" na ");
            }
            if (root.Right != null)
            {
                if (root.Right.Left != null)  Console.Write($" {root.Right.Left.Value} "); else Console.Write(" na ");
                if (root.Right.Right != null) Console.Write($" {root.Right.Right.Value} "); else Console.Write(" na ");
            }
        }
*/
        public int Sum()
        {
            return root==null ? 0 : root.Sum();
        }
 
        public int Max()
        {
            if (Empty()) throw new NoRootException();
            return root!.Max();
        }

        public bool CondMax(out int max)
        {
            max = 0;
            bool l = !Empty() && root!.CondMax(out max);
            return l;
        }

        public bool SearchPreOrder(out int e)
        {
            e = 0;
            if (Empty()) return false;
            return root!.SearchPreOrder(out e);
        }
    }
}
