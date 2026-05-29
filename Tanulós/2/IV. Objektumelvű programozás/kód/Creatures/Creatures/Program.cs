//Author:   Gregorics Tibor
//Date:     2021.11.13.
//Title:    competition of different creatures

using System;
using TextFile;
using System.Collections.Generic;

namespace Creatures
{
    class Program
    {
        static void Main()
        {
            TextFileReader reader = new (@"..\..\..\inp.txt");

            // populating creatures
            reader.ReadLine(out string line); int n = int.Parse(line);
            List<Creature> creatures = new ();
            for (int i = 0; i < n; ++i)
            { 
                char[] separators = new char[] { ' ', '\t' };
                Creature creature = null;

                if (reader.ReadLine(out line))
                {
                    string[] tokens = line.Split(separators, StringSplitOptions.RemoveEmptyEntries);

                    char ch = char.Parse(tokens[0]);
                    string name = tokens[1];
                    int p = int.Parse(tokens[2]);

                    switch (ch)
                    {
                        case 'G': creature = new Greenfinch(name, p); break;
                        case 'D': creature = new DuneBeetle(name, p); break;
                        case 'S': creature = new Squelchy(name, p);   break;
                    }
                }
                creatures.Add(creature);
            }


            // populating courts
            reader.ReadLine(out line); int m = int.Parse(line);
            List<IGround> courts = new ();
            for (int j = 0; j < m; ++j)
            {
                reader.ReadChar(out char c);
                switch (c)
                {
                    case 'g': courts.Add(Grass.Instance()); break;
                    case 's': courts.Add(Sand.Instance()); break;
                    case 'm': courts.Add(Marsh.Instance()); break;
                }
            }


            // competition
            try
            {
                foreach (var creature in creatures)
                {
                    creature.Race(ref courts);
                    if (creature.Alive()) Console.WriteLine(creature.Name);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("{0}", e.ToString() ); 
            }
        }
    }
}
