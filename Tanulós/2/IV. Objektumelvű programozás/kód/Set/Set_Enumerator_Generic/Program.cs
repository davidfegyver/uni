using System;

namespace Set_Generic
{
    class Program
    {
        static void Main()
        {
            Set<int> h = new Set<int>(10);

            h.Insert(1);
            h.Insert(2);
            h.Insert(0);
            h.Insert(3);
            h.Insert(2);
            h.Insert(2);

            bool l = false;
            int elem = 0;
            MyEnumerator<int> enor1 = h.CreateEnumerator();
            foreach (int e in enor1)
            {
                int c = 0;
                MyEnumerator<int> enor2 = h.CreateEnumerator();
                foreach (int f in enor2)
                {
                    if (e > f) ++c;
                }
                if ((l = (c >= 3))) { elem = e; break; };
            }
            enor1.Finish();
            if (l) Console.WriteLine("A keresett szam: {0}", elem);
            else Console.WriteLine("Nincs keresett szam.");
        }
    }
}
