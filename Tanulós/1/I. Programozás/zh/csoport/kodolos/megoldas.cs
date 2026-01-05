namespace csoportzh_kodolos
{
    internal class Program
    {

        static void GyerekSzamBeolv(out int gyerekszam)
        {
            bool joe = false;


            do
            {
                Console.Error.Write("Add meg a gyerekek számát: ");
                joe = int.TryParse(Console.ReadLine(), out gyerekszam);
                joe = joe && (1 <= gyerekszam && gyerekszam <= 50);
                if (!joe)
                {
                    Console.Error.WriteLine("Hibás bemenet. Egész számot adj meg, 1 és 50 között.");
                }
            }
            while (!joe);
        }

        static void DolgozatokBeolv(int gyerekszam, out int[] dolgozatok)
        {
            dolgozatok = new int[gyerekszam];
            for (int i = 0; i < gyerekszam; i++)
            {
                bool joe;


                do
                {
                    Console.Error.Write("\nAdd meg a(z) " + (i + 1).ToString() + ". gyerek eredményét: ");

                    joe = int.TryParse(Console.ReadLine(), out dolgozatok[i]);
                    joe = joe && (1 <= dolgozatok[i] && dolgozatok[i] <= 50);

                    if (!joe)
                    {
                        Console.Error.WriteLine("Hibás bemenet. Egész számot adj meg, 0 és 100 között.");
                    }
                }
                while (!joe);

            }

        }

        static void Feldolgoz(int gyerekszam, int[] dolgozatok, out int boldogok)
        {
            boldogok = 0;

            for (int i = 0; i < gyerekszam - 1; i++)
            {
                if(boldogE(i))
                {
                    boldogok ++;
                }
            }

            bool boldogE(int i)
            {
                int maxind, maxért;

                maxind = i; maxért = dolgozatok[i];

                for (int j = i; j < gyerekszam; j++)
                {
                    if (dolgozatok[j] > maxért)
                    {
                        maxért = dolgozatok[j];
                        maxind = j;
                    }
                }
                return maxért / 2 < dolgozatok[i];
            }
        }

        static void Kiir(int boldogok)
        {
            Console.Error.Write(boldogok.ToString() + " boldog diák van az osztályban.");
        }

        static void Main()
        {
            GyerekSzamBeolv(out int gyerekszam);
            DolgozatokBeolv(gyerekszam, out int[] dolgozatok);

            Feldolgoz(gyerekszam, dolgozatok, out int boldogok);

            Kiir(boldogok);
        }
        
    }
}
