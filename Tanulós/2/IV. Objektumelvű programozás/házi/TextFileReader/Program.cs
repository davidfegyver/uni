using System;
using TextFile;

namespace HF05
{
    class Program
    {
        static void Main(string[] args)
        {
            bool lmax = false, lmin = false;
            int max = 0, min = 0;

            using TextFileReader tfr = new TextFileReader("input.txt");


            while (tfr.ReadInt(out int e))
            {
                if (e < 0)
                {
                    if (!lmax || e > max)
                    {
                        lmax = true;
                        max = e;
                    }
                }
                if (e > 0)
                {
                    if (!lmin || e < min)
                    {
                        lmin = true;
                        min = e;
                    }
                }
            }


            Console.WriteLine(lmax ? max.ToString() : "nincs");
            Console.WriteLine(lmin ? min.ToString() : "nincs");
        }
    }
}