using System;

namespace Set
{
    class Program
    {
        static void Main()
        {
            Set seqset = new Set();

            seqset.Insert(0);

            Set arrset = new Set(15);
            arrset.Insert(13);
            try
            {
                arrset.Insert(23);
            }
            catch (Set.IllegalElementException er)
            {
                Console.WriteLine("illegal element -- {0}", er.e);
            }

            try
            {
                Console.WriteLine(arrset.Select());
            }
            catch (Exception)
            {
                Console.WriteLine("empty -- ");
            }

            Set newseqset = new Set();
            Set newarrset = new Set(15);

            Console.WriteLine("--------- seq -> seq -----------");
            seqset.SetEmpty();
            arrset.SetEmpty();
            DeepCopy(seqset, newseqset);

            Console.WriteLine("--------- arr -> arr -----------");
            seqset.SetEmpty();
            arrset.SetEmpty();
            DeepCopy(arrset, newarrset);

            Console.WriteLine("--------- seq -> arr -----------");
            seqset.SetEmpty();
            arrset.SetEmpty();
            DeepCopy(seqset, newarrset);

            Console.WriteLine("--------- arr -> seq -----------");
            seqset.SetEmpty();
            arrset.SetEmpty();
            DeepCopy(arrset, newseqset);

        }
        /*
        static void DeepCopy(Set s1, Set s2)
        {
            s1.Insert(1);
            s2 = (Set)s1.Clone();
            Console.WriteLine("original: {0}", s1.In(1));
            Console.WriteLine("copied:   {0}", s2.In(1));
            s1.Insert(2);
            Console.WriteLine("original: {0}", s1.In(2));
            Console.WriteLine("copied:   {0}", s2.In(2));
            s1.Remove(1);
            Console.WriteLine("original: {0}", s1.In(1));
            Console.WriteLine("copied:   {0}", s2.In(1));
        }
        */
        static void DeepCopy(Set s1, Set s2)
        {
            s1.Insert(1);
            s2 = new Set(s1);
            Console.WriteLine("original: {0}", s1.In(1));
            Console.WriteLine("copied:   {0}", s2.In(1));
            s1.Insert(2);
            Console.WriteLine("original: {0}", s1.In(2));
            Console.WriteLine("copied:   {0}", s2.In(2));
            s1.Remove(1);
            Console.WriteLine("original: {0}", s1.In(1));
            Console.WriteLine("copied:   {0}", s2.In(1));
        }
    }
}
