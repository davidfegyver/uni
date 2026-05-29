using System;
using TextFile;

namespace HF06
{
    internal class Program
    {
        static void Main(string[] args)
        {
            using TextFileReader tfr = new TextFileReader("input.txt");

            List<Szamla> szamlak = new();

            while (tfr.ReadLine(out string sor))
            {
                string[] adatok = sor.Split(' ');

                string nev = adatok[0];
                List<Aru> lista = new();

                for (int i = 1; i + 1 < adatok.Length; i += 2)
                {
                    string cikkszam = adatok[i];
                    int ar = int.Parse(adatok[i + 1]);
                    lista.Add(new Aru(cikkszam, ar));
                }

                szamlak.Add(new Szamla(nev, lista));
            }

            bool vane = false;
            int bevét = 0;

            foreach (Szamla sz in szamlak)
            {
                vane = true;
                bevét += sz.Ossz();
            }

            Console.WriteLine(vane ? bevét.ToString() : "nincs");
        }
    }
    public class Szamla
    {
        public string Nev { get; }
        public List<Aru> Lista { get; }

        public Szamla(string nev, List<Aru> lista)
        {
            Nev = nev;
            Lista = lista;
        }

        public int Ossz()
        {
            int sum = 0;
            foreach (Aru e in Lista)
                sum += e.Ar;
            return sum;
        }
    }
    public class Aru
    {
        public string Cikkszam { get; }
        public int Ar { get; }

        public Aru(string cikkszam, int ar)
        {
            Cikkszam = cikkszam;
            Ar = ar;
        }
    }
}
