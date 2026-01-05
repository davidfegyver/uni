using System;
using System.Collections.Generic;

namespace zh
{
    internal class Program
    {
        static int sorok_szama;
        static int erdeszetek_szama;

        static string kulonosen_vedett_fafajta;
        static Sor[] sorok;

        static void Main(string[] args)
        {
            beolvas();

            Console.WriteLine("#");
            Console.WriteLine(osszes_egyedek());
            Console.WriteLine("#");
            Console.WriteLine(legtobb());
            Console.WriteLine("#");
            Console.WriteLine(kulonbozo_fafajtak());
            Console.WriteLine("#");
            Console.WriteLine(csakegy());
            Console.WriteLine("#");
            Console.WriteLine(kulonosenvedettnel_nagyobbak());
        }

        static void beolvas()
        {
            string elso_sor = Console.ReadLine();
            string[] elso_sor_adatok = elso_sor.Split(" ");

            sorok_szama = int.Parse(elso_sor_adatok[0]);
            erdeszetek_szama = int.Parse(elso_sor_adatok[1]);
            kulonosen_vedett_fafajta = elso_sor_adatok[2];
            sorok = new Sor[sorok_szama];

            for (int sor_i = 0; sor_i < sorok_szama; sor_i++)
            {
                string sor = Console.ReadLine();

                string[] adatok = sor.Split(" ");

                sorok[sor_i].erdeszet = int.Parse(adatok[0]);
                sorok[sor_i].fafajta = adatok[1];
                sorok[sor_i].darabszam = int.Parse(adatok[2]);
            }

        }

        static int osszes_egyedek()
        {
            // összegzés
            int egyedek_szum = 0;

            for (int i = 0; i < sorok_szama; i++)
            {
                egyedek_szum += sorok[i].darabszam;
            }
            return egyedek_szum;
        }

        static string legtobb()
        {
            // feltételes max 
            bool van = false;

            int maxért = 0;
            int maxind = -1;

            for (int sor_i = 0; sor_i < sorok_szama; sor_i++)
            {
                if (sorok[sor_i].fafajta == kulonosen_vedett_fafajta)
                {
                    if (!van)
                    {
                        van = true;
                        maxért = sorok[sor_i].darabszam;
                        maxind = sor_i;
                    }
                    else
                    {
                        if (sorok[sor_i].darabszam > maxért)
                        {
                            maxért = sorok[sor_i].darabszam;
                            maxind = sor_i;
                        }
                    }
                }

            }

            if (maxind == -1) return "0";
            return $"{sorok[maxind].erdeszet} {maxért}";
        }

        static int kulonbozo_fafajtak()
        {
            // kiválogatás
            List<string> fafajtak = new List<string>();
            for (int sor_i = 0; sor_i < sorok_szama; sor_i++)
            {
                if (!fafajtak.Contains(sorok[sor_i].fafajta))
                {
                    fafajtak.Add(sorok[sor_i].fafajta);
                }
            }

            return fafajtak.Count;
        }

        static int csakegy()
        {
            // két kiválogatás :) 
            List<string> fafajtak = new List<string>();
            List<string> tobbszor = new List<string>();

            for (int sor_i = 0; sor_i < sorok_szama; sor_i++)
            {
                if (!fafajtak.Contains(sorok[sor_i].fafajta))
                {
                    fafajtak.Add(sorok[sor_i].fafajta);
                }
                else
                {
                    if (!tobbszor.Contains(sorok[sor_i].fafajta))
                    {
                        tobbszor.Add(sorok[sor_i].fafajta);
                    }
                }
            }

            return fafajtak.Count - tobbszor.Count;

        }

        static string kulonosenvedettnel_nagyobbak()
        {
            // kiválogatás, feltételes max keresés
            List<int> nagyobbak = new List<int>();

            for (int erdeszet_i = 0; erdeszet_i < erdeszetek_szama; erdeszet_i++)
            {
                int kulonosenvedett = 0;

                bool van = false;
                int maxért = 0;
                int maxind = -1;

                for (int sor_i = 0; sor_i < sorok_szama; sor_i++)
                {
                    if (sorok[sor_i].erdeszet == erdeszet_i)
                    {
                        if (sorok[sor_i].fafajta == kulonosen_vedett_fafajta)
                        {
                            kulonosenvedett = sorok[sor_i].darabszam;
                        }
                        else
                        {
                            if (!van)
                            {
                                van = true;
                                maxért = sorok[sor_i].darabszam;
                                maxind = sor_i;
                            }
                            else
                            {
                                if (sorok[sor_i].darabszam > maxért)
                                {
                                    maxért = sorok[sor_i].darabszam;
                                    maxind = sor_i;
                                }

                            }

                        }

                    }

                }


                if (kulonosenvedett != 0 && maxért <= kulonosenvedett)
                {
                    nagyobbak.Add(erdeszet_i);
                }

            }

            int db = nagyobbak.Count;
            string meow = db.ToString();
            meow += " ";

            for (int i = 0; i < db; i++)
            {
                meow += nagyobbak[i].ToString();
                if (i < db - 1) meow += " ";
            }
            return meow;
        }


        public struct Sor
        {
            public int erdeszet;
            public string fafajta;
            public int darabszam;
        }

    }
}
