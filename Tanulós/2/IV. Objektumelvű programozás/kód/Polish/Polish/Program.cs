//Author:   Gregorics Tibor
//Date:     2021.11.10.
//Title:    Transforming an arithmetic expression from infix form to postfix form, and then its evaluation 

using System;
using System.Collections.Generic;

namespace Polish
{
    class Program
    {
        public class Interrupt : Exception { }
        static void Main()
        {
            ConsoleKeyInfo cki;
            do
            {
                Console.WriteLine("\nGive me an arithmetic expression!\n");
                string input = Console.ReadLine()!;

                try
                {
                    // Tokenization
                    List<Token> infix = new ();

                    try
                    {
                        while (Token.ReadToken(ref input, out Token? token))
                        {
                            infix.Add(token!);
                        }
                    }
                    catch (Token.IllegalElementException ex)
                    {
                        Console.WriteLine("Illegal character: {0} ", ex.What() );
                        throw new Interrupt();
                    }
                    if (0 == infix.Count)
                    {
                        Console.WriteLine("Empty expression");
                        throw new Interrupt();
                    }

                    // Transforming into RPN
                    Stack<Token> stackToken = new ();
                    List<Token> postfix = new ();

                    foreach (Token token in infix)
                    {
                        if      ( token is Operand ) postfix.Add(token);
                        else if ( token is LeftP ) stackToken.Push(token);
                        else if ( token is RightP )
                        {
                            try
                            {
                                while ( stackToken.Peek() is not LeftP )
                                {
                                    postfix.Add(stackToken.Peek());
                                    stackToken.Pop();
                                }
                                stackToken.Pop();
                             }
                            catch (InvalidOperationException) 
                            {
                                Console.WriteLine("Syntax error: less left parenthesis than right ones");
                                throw new Interrupt();
                            }
                        }
                        else if (token is Operator operator1)
                       {
                            while ( stackToken.Count!=0 && (stackToken.Peek() is Operator operator2)
                                 && operator1.Priority() <= operator2.Priority() )
                            {
                                postfix.Add(stackToken.Peek());
                                stackToken.Pop();
                            }
                            stackToken.Push(token);
                        }
                        else
                        {
                            Console.WriteLine("Syntax error: others");
                            throw new Interrupt();
                        }
                    }

                    while (stackToken.Count!=0)
                    {
                        if ( stackToken.Peek() is LeftP )
                        {
                            Console.WriteLine("Syntax error: more left parenthesis than right ones");
                            throw new Interrupt();
                        }
                        else postfix.Add(stackToken.Peek());
                        stackToken.Pop();
                    }

                    // Evaluation
                    Stack<int> stackInt = new ();

                    try
                    {
                        foreach (Token token in postfix)
                        {
                            if ( token is Operand operand )
                            {
                                stackInt.Push(operand.Value());
                            }
                            else if (token is Operator operator0 )
                            {
                                int rightOp = stackInt.Peek(); stackInt.Pop();
                                int leftOp = stackInt.Peek(); stackInt.Pop();
                                stackInt.Push(operator0.Evaluate(leftOp, rightOp));
                            }
                        }
                        int result = stackInt.Peek(); stackInt.Pop();
                        if (stackInt.Count!=0)
                        {
                            Console.WriteLine("Syntax error: more operands than operators");
                            throw new Interrupt();
                        }
                        Console.WriteLine($"value: {result}");
                    }
                    catch (InvalidOperationException)
                    {
                        Console.WriteLine("Syntax error: less operands than operators");
                        throw new Interrupt();
                    }
                }
                catch (Interrupt) { }

                Console.Write("\nDo you continue? I/N");
                cki = Console.ReadKey();
            } while (cki.KeyChar != 'n' && cki.KeyChar != 'N');
            
        }
    }
}
