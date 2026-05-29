namespace HF02
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int n, m;
            string[] separatedLine = Console.ReadLine().Split();
            n = int.Parse(separatedLine[0]);
            m = int.Parse(separatedLine[1]);
            Labyrinth labyrinth = new Labyrinth(n, m);
            for (int i = 0; i < n; i++)
            {
                separatedLine = Console.ReadLine().Split();
                for (int j = 0; j < m; j++)
                {
                    switch (separatedLine[j])
                    {
                        case "Üres":
                            labyrinth.Place(new Position(i+1, j+1), Content.EMPTY);
                            break;
                        case "Fal":
                            labyrinth.Place(new Position(i+1, j+1), Content.WALL);
                            break;
                        case "Kincs":
                            labyrinth.Place(new Position(i+1, j+1), Content.TREASURE);
                            break;
                        case "Szellem":
                            labyrinth.Place(new Position(i+1, j+1), Content.GHOST);
                            break;
                    }
                }
            }

            try
            {
                separatedLine = Console.ReadLine().Split();
                labyrinth.Gather(new Position(int.Parse(separatedLine[0]), int.Parse(separatedLine[1])));
                Console.WriteLine("Sikerült begyűjteni");
            }
            catch (Exception e)
            {
                Console.WriteLine("Nem sikerült a begyűjtés");
            }
            try
            {
                separatedLine = Console.ReadLine().Split();
                Position pos = new Position(int.Parse(separatedLine[0]), int.Parse(separatedLine[1]));
                separatedLine = Console.ReadLine().Split();
                Position dir = new Position(int.Parse(separatedLine[0]), int.Parse(separatedLine[1]));
                Content result = labyrinth.Spy(pos, dir);
                if (result == Content.TREASURE)
                    Console.WriteLine("Kincs");
                else if (result == Content.WALL)
                    Console.WriteLine("Fal");
                else if (result == Content.EMPTY)
                    Console.WriteLine("Üres");
                else
                    Console.WriteLine("Szellem");
            }
            catch (Exception e)
            {
                Console.WriteLine("Nem sikerült megtekinteni a tartalmat");
            }
        }
    }
}
