//Author:   Gregorics Tibor
//Date:     2022.08.16.
//Title:    Sets including integers with enumerator

using System;

namespace Set_Enumerator
{
    class Program
    {
        static void Main()
        {
            Set h = new ();

            h.Insert(1);
            h.Insert(2);
            h.Insert(0);
            h.Insert(3);
            h.Insert(2);
            h.Insert(2);

            /*
            bool l = false;
            int elem = 0;
            IMyEnumerator enor1 = h.CreateEnumerator();
            for (enor1.First(); !l && !enor1.End(); enor1.Next())
            {
                elem = enor1.Current();
                int c = 0;
                IMyEnumerator enor2 = h.CreateEnumerator();
                for (enor2.First(); !enor2.End(); enor2.Next())
                {
                    if (elem > enor2.Current()) ++c;
                }
                l = c >= 3;
            }
            */
 
            bool l = false;
            int elem = 0;
            MyEnumerator enor1 = h.CreateEnumerator();
            
            foreach (int e in enor1)
            {
                int c = 0;
                MyEnumerator enor2 = h.CreateEnumerator();
                foreach (int f in enor2)
                {
                    if (e > f) ++c;
                }
                if ((l = (c >= 3))) { elem = e; break; };
            }
            // enor1.Finish();
            if (l) Console.WriteLine("A keresett szam: {0}", elem);
            else Console.WriteLine("Nincs keresett szam.");

            Set h1 = new (15);
            h1.Insert(2);
            try { h1.Insert(23); }
            catch (Exception er) { if (er is Set.IllegalElementException o) Console.WriteLine("illegal element -- {0}", o.e); }

            try { Console.WriteLine(h1.Select()); }
            catch (Exception) { Console.WriteLine("empty -- "); }

            MyEnumerator enor = h1.CreateEnumerator();
            enor.First();
            try { h1.Remove(2); }
            catch (Exception er) { Console.WriteLine($"under -- {er}"); }

            h.Remove(2);

            Console.WriteLine(h.In(1)?"in":"no"); 
            Set h2 = new (h);
            h2.Remove(1);
            Console.WriteLine(h.In(1) ? "in" : "no");
        }
    }
}
