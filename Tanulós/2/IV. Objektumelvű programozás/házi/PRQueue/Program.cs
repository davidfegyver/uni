using System.Collections;
using System.Xml.Linq;

namespace HF04
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string[]? input;
            input = Console.ReadLine()?.Split();
            PrQueue testQ = new PrQueue();
            switch (input[0])
            {
                case "Hozzáad":
                    Console.WriteLine("A sor üres:");
                    Console.WriteLine(testQ.IsEmpty());
                    Console.WriteLine("Prioritás Adat bemenet:");
                    input = Console.ReadLine()?.Split();
                    int pr1 = int.Parse(input[0]);
                    Item toAdd1;
                    toAdd1.pr = pr1;
                    toAdd1.data = input[1];
                    testQ.Add(toAdd1);
                    Console.WriteLine("A sor nem üres:");
                    Console.WriteLine(!testQ.IsEmpty());
                    break;
                case "Üres":
                    Console.WriteLine("A sor üres:");
                    Console.WriteLine(testQ.IsEmpty());
                    try
                    {
                        testQ.GetMax();
                    }
                    catch
                    {
                        Console.WriteLine("Hiba - GetMax");
                    }
                    try
                    {
                        testQ.RemMax();
                    }
                    catch
                    {
                        Console.WriteLine("Hiba - RemMax");
                    }
                    break;
                case "Kiürítés":
                    Console.WriteLine("A sor üres:");
                    Console.WriteLine(testQ.IsEmpty());
                    Console.WriteLine("Prioritás Adat bemenet:");
                    input = Console.ReadLine()?.Split();
                    int pr2 = int.Parse(input[0]);
                    Item toAdd2;
                    toAdd2.pr = pr2;
                    toAdd2.data = input[1];
                    testQ.Add(toAdd2);
                    Console.WriteLine("A sor nem üres:");
                    Console.WriteLine(!testQ.IsEmpty());
                    Console.WriteLine("Kiürítés...");
                    testQ.SetEmpty();
                    Console.WriteLine("Újra hozzáadás...");
                    testQ.Add(toAdd2);
                    Item e = testQ.RemMax();
                    Console.WriteLine(e.data);
                    Console.WriteLine("A sor üres:");
                    Console.WriteLine(testQ.IsEmpty());
                    try
                    {
                        testQ.GetMax();
                    }
                    catch
                    {
                        Console.WriteLine("Hiba - GetMax");
                    }
                    try
                    {
                        testQ.RemMax();
                    }
                    catch
                    {
                        Console.WriteLine("Hiba - RemMax");
                    }
                    break;
                case "Maximumkiválasztás":
                    Console.WriteLine("Elemek hozzáadása...");
                    Console.WriteLine("Prioritás Adat bemenet:");
                    input = Console.ReadLine()?.Split();
                    int pr3 = int.Parse(input[0]);
                    Item toAdd3;
                    toAdd3.pr = pr3;
                    toAdd3.data = input[1];
                    Console.WriteLine("Prioritás Adat bemenet:");
                    input = Console.ReadLine()?.Split();
                    pr3 = int.Parse(input[0]);
                    Item toAdd4;
                    toAdd4.pr = pr3;
                    toAdd4.data = input[1];
                    Console.WriteLine("Prioritás Adat bemenet:");
                    input = Console.ReadLine()?.Split();
                    pr3 = int.Parse(input[0]);
                    Item toAdd5;
                    toAdd5.pr = pr3;
                    toAdd5.data = input[1];
                    testQ.Add(toAdd3);
                    testQ.Add(toAdd4);
                    testQ.Add(toAdd5);
                    Console.WriteLine("Max lekérdezése:");
                    Item toGet = testQ.GetMax();
                    Console.WriteLine(toGet.data);
                    Console.WriteLine("Max eltávolítása:");
                    toGet = testQ.RemMax();
                    Console.WriteLine(toGet.data);
                    Console.WriteLine("Max lekérdezése:");
                    toGet = testQ.GetMax();
                    Console.WriteLine(toGet.data);
                    break;
            }
        }
    }
}
