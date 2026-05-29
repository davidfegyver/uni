//Author:   Gregorics Tibor
//Date:     2021.11.11.
//Title:    generic class of nodes of a tree 

namespace BinTree
{
    public class Node
    {
        public int Value { get; }
        public Node? Left { get; set; }
        public Node? Right { get; set; }

        public Node(int v)
        {
            Value = v;
            Left = null;
            Right = null;
        }

        public bool IsLeaf { get { return Left == null && Right == null; } }
        public bool IsInternal { get { return !IsLeaf; } }


        public void PreOrder(IAction todo)
        {
            todo.Exec(this);
            Left?.PreOrder(todo);
            Right?.PreOrder(todo);
        }

        public void InOrder(IAction todo)
        {
            Left?.InOrder(todo);
            todo.Exec(this);
            Right?.InOrder(todo);
        }

        public void PostOrder(IAction todo)
        {
            Left?.PostOrder(todo);
            Right?.PostOrder(todo);
            todo.Exec(this);
        }

        public void Write()
        {
            Console.Write("[");
            Console.Write(this.Value);
            Console.Write(",");
            Left?.Write();
            Console.Write(",");
            Right?.Write();
            Console.Write("]");
        }
    }
}
