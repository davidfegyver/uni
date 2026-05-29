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
        
        public bool Empty() { return root == null; }

        private readonly Random rand = new (DateTime.Now.Millisecond);
        public BinTree() { root = null; }

        public void RandomInsert(int e) 
        {
            if (root == null) root = new Node(e);
            else
            {
                Node r = root;
                bool l = rand.Next() %2 != 0; 
                while ( l ? r.Left != null : r.Right != null)
                {
                    if (l) r = r.Left!;
                    else r = r.Right!;
                    l = rand.Next() % 2 != 0;
                }
                if (l) r.Left = new Node(e);
                else   r.Right = new Node(e);
            }
        }

        public void PreOrder(IAction todo) { root!.PreOrder(todo); }
        public void InsOrder(IAction todo) { root!.InOrder(todo); }
        public void PostOrder(IAction todo) { root!.PostOrder(todo); }

        public void Write() { root!.Write(); }
    }
}
