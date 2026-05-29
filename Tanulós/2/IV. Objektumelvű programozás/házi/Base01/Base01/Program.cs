namespace Base01
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Adagoló maximum tartalma, adag mennyisége és megnyomások száma:");
            string[] input = Console.ReadLine().Split();
            double max = double.Parse(input[0]);
            double dose = double.Parse(input[1]);
            int presses = int.Parse(input[2]);
            Dispenser test = new Dispenser(max, dose);
            Console.WriteLine(test.Empty());
            test.Fill();
            Console.WriteLine(test.Empty());
            for (int i = 0; i < presses; i++)
            {
                test.Push();
            }
            Console.WriteLine(test.Empty());
        }
    }
}
