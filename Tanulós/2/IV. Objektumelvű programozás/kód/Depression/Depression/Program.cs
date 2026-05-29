//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    Height of the highest depression

using System;
using System.Collections.Generic;
using TextFile;
using static Depression.Infile;

namespace Depression
{
    public class Program
    {
        static void Main()
        {
            if (MaxSearch("input.txt", out double max, out int where))
            {
                Console.WriteLine($"Height of the highest depression: {max:f2} meter on the place {where}");
            }
            else
            {
                Console.WriteLine("There is no depression.");
            }
        }

        public static bool MaxSearch(string fname, out double max, out int where)
        {
            max = 0.0; where = 0; 
            try
            {
                Infile f = new(fname);

                bool l = false; 
                while (f.Read())
                {
                    Triple e = f.current;
                    if (!(e.prev > e.centre && e.centre < e.next)) continue;
                    if (!l) { l = true; max = e.centre; where = e.serial; }
                    else if (e.centre > max) { max = e.centre; where = e.serial; }
                }
                return l;
            }
            catch (System.IO.FileNotFoundException)
            {
                Console.WriteLine("File open error.");
                return false;
            }
        }

    }
}

