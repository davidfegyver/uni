//Author:   Gregorics Tibor
//Date:     2021.11.10.
//Title:    classes of tokens and an arithmetic expression 

using System;

namespace Polish
{
    // superclass of tokens with the operator "read the next token"
    abstract public class Token
    {
        public class IllegalElementException : Exception
        {
            private readonly char ch;
            public IllegalElementException(char c) { ch = c; }
            public string What() { return ch.ToString(); }
        }

        const string digits = "0123456789";
        public static bool ReadToken(ref string input, out Token? token)
        {
            token = null;
            if (input.Length == 0) return false;
            int i = 1;
            switch (input[0])
            {
                case '+': token = OperatorAdd.Instance(); break;
                case '-': token = OperatorSub.Instance(); break;
                case '*': token = OperatorMul.Instance(); break;
                case '/': token = OperatorDiv.Instance(); break;
                case '(': token = LeftP.Instance(); break;
                case ')': token = RightP.Instance(); break;
                case '0': 
                case '1':
                case '2':
                case '3':
                case '4':
                case '5':
                case '6':
                case '7':
                case '8':
                case '9':
                    string str = "";
                    for (i = 0; i < input.Length && digits.Contains(input[i]); ++i) { str += input[i]; }
                    token = new Operand(int.Parse(str));
                    break;
                default: throw new IllegalElementException(input[0]);
            }
            input = input[i..];
            return true;
        }
    }

    // class of operands
    public class Operand : Token
    {
        protected int val;
        public Operand(int v) { val = v; }
        public override string ToString() { return val.ToString(); }
        public int Value() { return val; }
    }

    // class of left parentheses
    public class LeftP : Token
    {
        private LeftP() { }
        public override string ToString() { return "("; }

        private static LeftP? instance;
        public static LeftP Instance()
        {
            instance ??= new LeftP(); // if (instance == null)
            return instance;
        }
    }

    // class of right parentheses
    public class RightP : Token
    {
        private RightP() { }
        public override string ToString() { return ")"; }

        private static RightP? instance;
        public static RightP Instance()
        {
            instance ??= new RightP();
            return instance;
        }
    }

    // superclass of operators
    abstract public class Operator : Token
    {
        private readonly char op;
        protected Operator(char o) { op = o; }

        public override string ToString() { return op.ToString(); }

        public abstract int Evaluate(int leftValue, int rightValue);
        public virtual int Priority(){ return 3; }
    }

    // class of addition operator
    public class OperatorAdd : Operator
    {
        private OperatorAdd() : base('+') { }

        public override int Evaluate(int leftValue, int rightValue) { return leftValue + rightValue; }
        public override int Priority() { return 1; }

        private static OperatorAdd? instance;
        public static OperatorAdd Instance()
        {
            instance ??= new OperatorAdd();
            return instance;
        }
    }

    // class of subtraction operator
    public class OperatorSub : Operator
    {
        private OperatorSub() : base('-') { }

        public override int Evaluate(int leftValue, int rightValue) { return leftValue - rightValue; }
        public override int Priority() { return 1; }

        private static OperatorSub? instance;
        public static OperatorSub Instance()
        {
            instance ??= new OperatorSub();
            return instance;
        }
    }

    // class of multiplication operator
    public class OperatorMul : Operator
    {
        private OperatorMul() : base('*') { }

        public override int Evaluate(int leftValue, int rightValue) { return leftValue * rightValue; }
        public override int Priority() { return 2; }

        private static OperatorMul? instance;
        public static OperatorMul Instance()
        {
            instance ??= new OperatorMul();
            return instance;
        }
    }

    // class of division operator
    public class OperatorDiv : Operator
    {
        private OperatorDiv() : base('/') { }

        public override int Evaluate(int leftValue, int rightValue) { return leftValue / rightValue; }
        public override int Priority() { return 2; }

        private static OperatorDiv? instance;
        public static OperatorDiv Instance()
        {
            instance ??= new OperatorDiv();
            return instance;
        }
    }
}
