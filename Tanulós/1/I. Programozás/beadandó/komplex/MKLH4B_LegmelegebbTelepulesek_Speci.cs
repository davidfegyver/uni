/*
 Készítette: Fegyver Dávid Bátor
 Neptun-azonosító: MKLH4B
 E-mail: root@davidfegyver.hu
 Feladat: Legmelegebb települések
*/
using System;

namespace LegmelegebbTelepulesek
{
    class Program
    {
        static int n;
        static int m;
        static int[,] homletek;

        static int db;
        static int[] maxhomletek;
        static int[] telepulesMaxCache;

        static void Main()
        {

            beolvas();

            megold();

            kiir();

        }

        static void beolvas()
        {
            bool biroE = Console.IsInputRedirected;
            if (biroE)
            {
                homletek = beolvas_biro();
            }
            else
            {
                homletek = beolvas_kezi();
            }

            telepulesMaxCache = new int[n];
            for (int i = 0; i < n; i++) telepulesMaxCache[i] = -1;
        }

        static int[,] beolvas_biro()
        {
            string eSor = Console.ReadLine();
            string[] eAdatok = eSor.Split(" ");

            n = int.Parse(eAdatok[0]);
            m = int.Parse(eAdatok[1]);

            int[,] mat = new int[n, m];

            for (int i = 0; i < n; i++)
            {
                string sor = Console.ReadLine();

                string[] adatok = sor.Split(" ");
                for (int j = 0; j < m; j++)
                {
                    mat[i, j] = int.Parse(adatok[j]);
                }
            }

            return mat;
        }
        static int[,] beolvas_kezi()
        {
            Console.WriteLine("=== Legmelegebb települések ===");

            bool siker = false;
            do
            {
                Console.Write("Kérem a települések számát (n): ");
                string be = Console.ReadLine();

                if (int.TryParse(be, out n) && n > 0)
                {
                    siker = true;
                }
                else
                {
                    Console.WriteLine("Hiba: A települések számának pozitív egésznek kell lennie!");
                    siker = false;
                }
            }
            while (!siker);

            siker = false;
            do
            {
                Console.Write("Kérem a napok számát (m): ");
                string be = Console.ReadLine();

                if (int.TryParse(be, out m) && m > 0)
                {
                    siker = true;
                }
                else
                {
                    Console.WriteLine("Hiba: A napok számának pozitív egésznek kell lennie!");
                    siker = false;
                }
            }
            while (!siker);

            int[,] mat = new int[n, m];

            Console.WriteLine($"Kérem a hőmérsékleteket ({m} db szám soronként):");

            for (int i = 0; i < n; i++)
            {
                siker = false;
                do
                {
                    Console.Write($"{i + 1}. település adatai: ");
                    string sor = Console.ReadLine();

                    string[] adatok = sor.Split(" ");

                    if (adatok.Length != m)
                    {
                        Console.WriteLine($"Hiba: Pontosan {m} számot kell megadni!");
                        siker = false; 
                    }
                    else
                    {
                        bool mindenJo = true;
                        for (int j = 0; j < m; j++)
                        {
                            if (!int.TryParse(adatok[j], out mat[i, j]))
                            {
                                Console.WriteLine($"Hiba: A bemeneted tartalmaz nem érvényes számot!");
                                mindenJo = false;
                                break;
                            }
                        }
                        siker = mindenJo;
                    }
                }
                while (!siker);
            }
            return mat;
        }

        static void megold()
        {
            db = 0;
            maxhomletek = new int[n];
            for (int i = 0; i < n; i++)
            {
                if (telepulesMaxOsszMaxE(i))
                {
                    maxhomletek[db] = i;
                    db++;
                }
            }
        }
        static int telepulesMax(int i)
        {
            if (telepulesMaxCache[i] != -1) return telepulesMaxCache[i];

            int maxért = homletek[i, 0];
            int maxind = 0;

            for (int j = 1; j < m; j++)
            {
                if (homletek[i, j] > maxért)
                {
                    maxért = homletek[i, j];
                    maxind = j;
                }
            }

            telepulesMaxCache[i] = maxért;

            return maxért;
        }

        static bool telepulesMaxOsszMaxE(int i)
        {
            int maxért = telepulesMax(0);
            int maxind = 0;
            for (int j = 1; j < n; j++)
            {
                int Jmax = telepulesMax(j);
                if (Jmax > maxért)
                {
                    maxért = Jmax;
                    maxind = j;
                }
            }
            return telepulesMax(i) == maxért;
        }

        static void kiir()
        {
            bool biroE = Console.IsInputRedirected;


            if (!biroE) Console.WriteLine("=== Eredmény ===");

            if (!biroE) Console.Write("Ennyi település érte el a legmagasabb hőmérsékletet: ");
            Console.Write(db);
            Console.Write(" ");
            if (!biroE) Console.Write("\nA települések sorszámai: ");

            for (int i = 0; i < db; i++)
            {
                Console.Write(maxhomletek[i] + 1);
                if (i < db - 1) Console.Write(" ");
            }
            Console.WriteLine();

            if (!biroE)
            {
                Console.WriteLine("Kérem, nyomjon ENTER-t a kilépéshez! ");
                Console.ReadLine();
            }
        }
    }
}