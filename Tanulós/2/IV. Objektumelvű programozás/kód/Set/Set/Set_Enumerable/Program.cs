//Author:   Gregorics Tibor
//Date:     2022.08.18.
//Title:    Enumerable sets including integers with different representations 

using System;

namespace Set_Enumarable
{
    class Program
    {
        static void Main()
        {
            Set h = new Set();

            h.Insert(1);
            h.Insert(2);
            h.Insert(0);
            h.Insert(3);
            h.Insert(2);
            h.Insert(2);

            int elem = 0;
            bool l = false;
            Console.WriteLine("----------------");
            foreach (int e in h)
            {
                Console.WriteLine("\n{0} :", e);
                int c = 0;
                foreach(int f in h)
                {
                    Console.Write(" {0}", f);
                    if (e > f) ++c;
                }
                if (c >= 3) elem = e; ;
            }
            Console.WriteLine("\n----------------");
            if (l) Console.WriteLine("A keresett szam: {0}", elem);
            else Console.WriteLine("Nincs keresett szam.");
            // Rossz eredmény ad !!!

            Set h1 = new Set(15);
            try
            {
                h1.Insert(23);
            }
            catch (Set.IllegalElementException er)
            {
                Console.WriteLine("illegal element -- {0}", ((Set.IllegalElementException)er).e);
            }

            try
            {
                Console.WriteLine(h1.Select());
            }
            catch (Exception)
            {
                Console.WriteLine("empty -- ");
            }

            Set h2 = new Set();
            h2.Insert(9);
            h2.Insert(5);
            Set hnew = (Set)h2.Clone();
            hnew.Remove(9);

            Console.WriteLine("original: {0}", h2.In(9) );
            Console.WriteLine("copied:   {0}", hnew.In(9) );

        }
    }
}
