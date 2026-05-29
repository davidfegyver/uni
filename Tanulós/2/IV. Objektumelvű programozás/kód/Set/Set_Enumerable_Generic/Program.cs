//Author:   Gregorics Tibor
//Date:     2022.08.18.
//Title:    Enumerable sets including integers with different representations 

namespace Set_Enumarable_Generic
{
    class Program
    {
        static void Main()
        {
            Set<int> h = new ();

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
                if (l = (c >= 3)) { elem = e; break; }
            }
            Console.WriteLine("\n----------------");
            if (l) Console.WriteLine("A keresett szam: {0}", elem);
            else Console.WriteLine("Nincs keresett szam.");

            try
            {
                foreach (int e in h)
                {
                    h.Remove(e);
                }
            }
            catch (InvalidOperationException)
            {
                Console.WriteLine("Remove");
            }

            Set<int> h1 = new (15);
            try
            {
                h1.Insert(23);
            }
            catch (Set<int>.IllegalElementException er)
            {
                Console.WriteLine("illegal element -- {0}", ((Set<int>.IllegalElementException)er).e);
            }

            try
            {
                Console.WriteLine(h1.Select());
            }
            catch (Exception)
            {
                Console.WriteLine("empty -- ");
            }

            Set<int> h2 = new ();
            h2.Insert(9);
            h2.Insert(5);
            Set<int> hnew = (Set<int>)h2.Clone();
            hnew.Remove(9);

            Console.WriteLine("original: {0}", h2.In(9) );
            Console.WriteLine("copied:   {0}", hnew.In(9) );

        }
    }
}
