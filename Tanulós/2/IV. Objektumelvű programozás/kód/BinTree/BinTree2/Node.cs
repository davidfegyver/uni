//Author:   Gregorics Tibor
//Date:     2021.11.11.
//Title:    generic class of nodes of a tree 

namespace BinTree
{
    abstract public class Node
    {
        public int Value { get; protected set; }
        public Node? Parent { get; protected set; }
        public Node? Left { get; set; }
        public Node? Right { get; set; }

        public Node(int e, Node? parent) { Value = e; Parent = parent; Left = null; Right = null; }

        protected readonly Random rand = new(DateTime.Now.Millisecond);
        abstract public Node RandomInsert(int e);
        abstract public void PreOrder();
        abstract public void InOrder();        
        abstract public void PostOrder();
        abstract public int Sum();
        abstract public int Max();
        abstract public bool CondMax(out int max);
        abstract public bool SearchPreOrder(out int e);
        abstract public bool SearchInOrder(out int e);
        abstract public bool SearchPostOrder(out int e);

    }

    public class LeafNode : Node
    {
        public LeafNode(int e, Node? parent) : base(e, parent) { }

        public override Node RandomInsert(int e)
        {
            InnerNode parent = new(Value, Parent);

            if (rand.Next() % 2 == 0) parent.Left = this;
            else parent.Right = this;

            Value = e;
            Parent = parent;

            return parent;
        }

        public override void PreOrder()
        {
            Console.Write($" {Value} ");
        }

        public override void InOrder()
        {
            Console.Write($" {Value} ");
        }

        public override void PostOrder()
        {
            Console.Write($" {Value} ");
        }

        public override int Sum()
        {
            return Value;
        }

        public override int Max()
        {
            return Value;
        }

        public override bool CondMax(out int max)
        {
            max = Value;
            return false;
        }

        public override bool SearchPreOrder(out int e)
        {
            e = Value;
            return e%2==0;
        }
        public override bool SearchInOrder(out int e)
        {
            e = Value;
            return e % 2 == 0;
        }
        public override bool SearchPostOrder(out int e)
        {
            e = Value;
            return e % 2 == 0;
        }
    }

    public class InnerNode : Node
    {
        public InnerNode(int e, Node? parent) : base(e, parent) { }

        public override Node RandomInsert(int e)
        {
            bool l = rand.Next() % 2 == 0;
            if (l)
            {
                if (Left != null) Left = Left.RandomInsert(e); 
                else Left = new LeafNode(e, this);
            }
            else
            {
                if (Right != null) Right = Right.RandomInsert(e); 
                else Right = new LeafNode(e, this);
            }

            return this;
        }
        public override void PreOrder()
        {
            Console.Write($" {Value} ");
            Left?.PreOrder();
            Right?.PreOrder();
        }

        public override void InOrder()
        {
            Left?.InOrder(); 
            Console.Write($" {Value} ");
            Right?.InOrder();
        }

        public override void PostOrder()
        {
            Left?.PostOrder();
            Right?.PostOrder();
            Console.Write($" {Value} ");
        }

        public override int Sum()
        {
            int sum = Value;
            if (Left  != null) sum += Left.Sum();
            if (Right != null) sum += Right.Sum();
            return sum; 
        }

        public override int Max()
        {
            int max = Value;
            if (Left != null) max = max < Left.Max() ? Left.Max() : max;
            if (Right != null) max = max < Right.Max() ? Right.Max() : max;
            return max;
        }

        public override bool CondMax(out int max)
        {
            max = Value;
            if (Left != null)
            {
                Left!.CondMax(out int m);
                max = m > max ? m : max;
            }
            if (Right != null)
            {
                Right!.CondMax(out int m);
                max = m > max ? m : max;
            }
            return true;
        }

        public override bool SearchPreOrder(out int e)
        {
            e = Value;
            if (e % 2 == 0) return true;
            if(Left!=null   && Left.SearchPreOrder(out e))  return true;
            if(Right!= null && Right.SearchPreOrder(out e)) return true;
            return false;
        }

        public override bool SearchInOrder(out int e)
        {
            if (Left != null && Left.SearchPostOrder(out e)) return true;
            e = Value;
            if (e % 2 == 0) return true;
            if (Right != null && Right.SearchPostOrder(out e)) return true;
            return false;
        }

        public override bool SearchPostOrder(out int e)
        {
            if (Left != null  && Left.SearchPostOrder(out e))  return true;
            if (Right != null && Right.SearchPostOrder(out e)) return true;
            e = Value;
            if (e % 2 == 0) return true;
            return false;
        }

    }
}
