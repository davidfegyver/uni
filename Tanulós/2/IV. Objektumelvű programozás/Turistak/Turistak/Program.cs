namespace Turistak
{
    internal static class Program
    {
        private static void Main(string[] args)
        {
            Console.Write("Add meg a bemeneti fájl nevét: ");
            string fajlnev = Console.ReadLine();

            if (string.IsNullOrWhiteSpace(fajlnev) || !File.Exists(fajlnev))
            {
                Console.WriteLine("A fájl nem található!");
                return;
            }

            string[] sorok = File.ReadAllLines(fajlnev);

            BemenetKiir(sorok);

            try
            {
                Szimulacio szimulacio = new Szimulacio(sorok);
                IReadOnlyList<EvesEredmeny> eredmenyek = szimulacio.Futtat();

                EredmenyekKiir(eredmenyek);

                Console.WriteLine(
                    $"A város állapota a {szimulacio.LegjobbEvSorszam}. évben volt a legjobb " +
                    $"({szimulacio.LegjobbAllapotErtek} pont).");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Hiba: {ex.Message}");
            }
        }
        private static void BemenetKiir(IEnumerable<string> sorok)
        {
            Console.WriteLine();
            Console.WriteLine("Bemeneti fájl tartalma:");
            Console.WriteLine("---------------------");
            foreach (string sor in sorok)
            {
                Console.WriteLine(sor);
            }

            Console.WriteLine("---------------------");
            Console.WriteLine();
        }

        private static void EredmenyekKiir(IEnumerable<EvesEredmeny> eredmenyek)
        {
            foreach (EvesEredmeny eredmeny in eredmenyek)
            {
                Console.WriteLine($"{eredmeny.EvSorszam}. év eredményei:");
                TuristaSorKiir("Japán", eredmeny.JapanTervezettDarab, eredmeny.JapanTenylegesDarab);
                TuristaSorKiir("Nyugati", eredmeny.NyugatiTervezettDarab, eredmeny.NyugatiTenylegesDarab);
                TuristaSorKiir("Egyéb", eredmeny.EgyebTervezettDarab, eredmeny.EgyebTenylegesDarab);
                Console.WriteLine($"  Éves összes bevétel: {eredmeny.EvesBevetel} Ft");
                Console.WriteLine(
                    $"  Város új állapota: {eredmeny.UjAllapotErtek} pont ({eredmeny.UjAllapotNev})");
                Console.WriteLine();
            }
        }
        private static void TuristaSorKiir(string tipus, int tervezett, int tenyleges)
        {
            Console.WriteLine($"  {tipus}: tervezett {tervezett}, tényleges {tenyleges}");
        }
    }
}
