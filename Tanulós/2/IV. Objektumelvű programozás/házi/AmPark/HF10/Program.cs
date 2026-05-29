namespace HF10
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string choice = Console.ReadLine();
            switch (choice)
            {
                case "Sizes":
                    TestSizes();
                    break;
                case "Gifts":
                    TestGifts();
                    break;
                case "TargetShot":
                    TestTarget();
                    break;
                case "Guest":
                    TestGuest();
                    break;
                case "AmPark":
                    TestAmPark();
                    break;
            }
        }
        public static void TestSizes()
        {
            ISize testSize;
            S testSOne = S.Instance();
            S testSTwo = S.Instance();
            Console.WriteLine(testSOne == testSTwo);
            M testMOne = M.Instance();
            M testMTwo = M.Instance();
            Console.WriteLine(testMOne == testMTwo);
            L testLOne = L.Instance();
            L testLTwo = L.Instance();
            Console.WriteLine(testLOne == testLTwo);
            XL testXLOne = XL.Instance();
            XL testXLTwo = XL.Instance();
            Console.WriteLine(testXLOne == testXLTwo);
            testSize = testSOne;
            testSize = testMOne;
            testSize = testLOne;
            testSize = testXLOne;
            Console.WriteLine(testSOne.Multi());
            Console.WriteLine(testMOne.Multi());
            Console.WriteLine(testLOne.Multi());
            Console.WriteLine(testXLOne.Multi());
        }
        public static void TestGifts()
        {
            string input = Console.ReadLine();
            ISize testSize = null;
            Gift tested = null;
            switch (input)
            {
                case "S":
                    testSize = S.Instance();
                    break;
                case "M":
                    testSize = M.Instance();
                    break;
                case "L":
                    testSize = L.Instance();
                    break;
                case "XL":
                    testSize = XL.Instance();
                    break;
            }
            input = Console.ReadLine();
            switch (input)
            {
                case "Ball":
                    tested = new Ball(testSize);
                    break;
                case "Figure":
                    tested = new Figure(testSize);
                    break;
                case "Plush":
                    tested = new Plush(testSize);
                    break;
            }
            Console.WriteLine(tested?.Value());
        }
        public static void TestTarget()
        {
            TargetShot tested = new TargetShot("Tatooine");
            ISize testSize = L.Instance();
            Gift testGift = new Ball(testSize);
            Console.WriteLine(tested.Gifts.Count);
            try
            {
                tested.Shows(testGift);
            }
            catch
            {
                Console.WriteLine("Exception - Gift targetshot is not null");
            }
            Console.WriteLine(tested.Gifts.Count);
            try
            {
                tested.Shows(testGift);
            }
            catch
            {
                Console.WriteLine("Exception - Gift targetshot is not null");
            }
            Console.WriteLine(tested.Gifts.Count);
        }
        public static void TestGuest()
        {
            string input = Console.ReadLine();
            Guest testedOne = new Guest(input);
            Gift testGift = new Ball(L.Instance());
            TargetShot testTS = new TargetShot("random");
            testTS.Shows(testGift);
            Console.WriteLine(testedOne.Name);
            try
            {
                testedOne.Wins(testGift);
            }
            catch
            {
                Console.WriteLine("Exception - Gift not at targetshot");
            }
            try
            {
                testedOne.Wins(testGift);
            }
            catch
            {
                Console.WriteLine("Exception - Gift not at targetshot");
            }
            input = Console.ReadLine();
            Guest testedTwo = new Guest(input);
            int numTShots = int.Parse(Console.ReadLine());
            int numGifts = int.Parse(Console.ReadLine());
            ISize inputSize = null;
            Gift inputGift = null;
            List<TargetShot> targetShots = new List<TargetShot>();
            for (int i = 0; i < numTShots; i++)
            {
                input = Console.ReadLine();
                targetShots.Add(new TargetShot(input));
            }
            int currTS;
            for (int i = 0; i < numGifts; i++)
            {
                input = Console.ReadLine();
                switch (input)
                {
                    case "S":
                        inputSize = S.Instance();
                        break;
                    case "M":
                        inputSize = M.Instance();
                        break;
                    case "L":
                        inputSize = L.Instance();
                        break;
                    case "XL":
                        inputSize = XL.Instance();
                        break;
                }
                input = Console.ReadLine();
                switch (input)
                {
                    case "Ball":
                        inputGift = new Ball(inputSize);
                        break;
                    case "Figure":
                        inputGift = new Figure(inputSize);
                        break;
                    case "Plush":
                        inputGift = new Plush(inputSize);
                        break;
                }
                currTS = int.Parse(Console.ReadLine());
                targetShots[currTS].Shows(inputGift);
                testedTwo.Wins(inputGift);
            }
            Console.WriteLine(testedTwo.Name);
            int targetShot = int.Parse(Console.ReadLine());
            Console.WriteLine(testedTwo.Result(targetShots[targetShot]));
        }
        public static void TestAmPark()
        {
            string input;
            int numGuest = int.Parse(Console.ReadLine());
            int numTShots = int.Parse(Console.ReadLine());
            int numGifts = int.Parse(Console.ReadLine());
            int targetChoice;
            bool noLength = false;
            ISize inputSize = null;
            Gift inputGift = null;
            List<TargetShot> targetShots = new List<TargetShot>();
            Guest testGuest;
            AmPark tested = null;
            for (int i = 0; i < numTShots; i++)
            {
                input = Console.ReadLine();
                targetShots.Add(new TargetShot(input));
            }
            try
            {
                tested = new AmPark(targetShots);
            }
            catch
            {
                noLength = true;
                Console.WriteLine("Exception - targetShot list too short");
            }
            for (int i = 0; i < numGuest; i++)
            {
                input = Console.ReadLine();
                testGuest = new Guest(input);
                for (int j = 0; j < numGifts; j++)
                {
                    targetChoice = int.Parse(Console.ReadLine());
                    input = Console.ReadLine();
                    switch (input)
                    {
                        case "S":
                            inputSize = S.Instance();
                            break;
                        case "M":
                            inputSize = M.Instance();
                            break;
                        case "L":
                            inputSize = L.Instance();
                            break;
                        case "XL":
                            inputSize = XL.Instance();
                            break;
                    }
                    input = Console.ReadLine();
                    switch (input)
                    {
                        case "Ball":
                            inputGift = new Ball(inputSize);
                            break;
                        case "Figure":
                            inputGift = new Figure(inputSize);
                            break;
                        case "Plush":
                            inputGift = new Plush(inputSize);
                            break;
                    }
                    targetShots[targetChoice].Shows(inputGift);
                    testGuest.Wins(inputGift);
                }
                tested.Receives(testGuest);
            }
            if (!noLength)
            {
                targetChoice = int.Parse(Console.ReadLine());
                Console.WriteLine(tested.Best(targetShots[targetChoice]));
            }
        }
    }
}
