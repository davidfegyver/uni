//Author:   Gregorics Tibor
//Date:     2021.11.11.
//Title:    generic class of activities over a node of a tree

using System;

namespace BinTree
{
    public interface IAction
    {
        public void Exec(Node node);
    }
    class Writer : IAction
    {
        public void Exec(Node node)
        {
            Console.Write($" {node.Value} ");
        }
    }
    class Summation : IAction
    {
        public int Sum { get; private set; }
        public Summation()
        {
            Sum = 0;
        }
        public void Exec(Node node)
        {
            if (node.IsInternal) Sum += node.Value;
        }
    }

    class MaxSelect : IAction
    {
        public int Max { get; private set; }
        public MaxSelect(int i) { Max = i; }
        public void Exec(Node node)
        {
            Max = Math.Max(Max, node.Value);
        }
    }

    class CondMaxSearch : IAction
    {
        public bool Found { get; private set; }
        public int Max { get; private set; }

        public CondMaxSearch() { Found = false; }
        public void Exec(Node node)
        {
            if (node.IsInternal)
            {
                if (!Found) { Found = true; Max = node.Value; }
                else { Max = Math.Max(Max, node.Value); }
            }
        }
    }
    class Found : Exception { }
    class Search : IAction
    {
        public int Value { get; private set; }
        public void Exec(Node node)
        {
            if (node.Value % 2 == 0)
            {
                Value = node.Value;
                throw new Found();
            }
        }
    }
}