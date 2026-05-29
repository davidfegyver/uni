//Author:   Gregorics Tibor
//Date:     2021.11.16.
//Title:    Petrolstation

using System.Collections.Generic;

namespace PetrolStation
{
    class Program
    {
        static void Main()
        {
            const int piecepump = 4;
            const int piececash = 2;
            const int piececar = 8;

            PetrolStation petrol = new(piecepump, piececash) { Unit = 400 };

            List<Car> cars = new ();
            for (int i = 0; i < piececar; ++i)
            {
                string str = string.Format("{0}", i + 1 );
                cars.Add(new Car(str));
            }
            
            foreach( Car car in cars )
            {
                char[] separators = new char[] {'.'};
                string[] tokens = car.Name.Split(separators);
                car.Refuel(petrol, int.Parse(tokens[0])%piecepump, (piececar+2-int.Parse(tokens[0])) * 5);
             }
        }
    }
}
