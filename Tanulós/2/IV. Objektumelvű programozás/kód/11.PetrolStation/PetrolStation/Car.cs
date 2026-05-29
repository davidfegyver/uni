//Author:   Gregorics Tibor
//Date:     2021.11.16.
//Title:    class of cars

using System;
using System.Threading;

namespace PetrolStation
{
    class Car
    {
        public string Name { get; private set; }
        public Car(string str) { Name = str; }

        private PetrolStation station;
        private int number;
        private int liter;
        private Thread fuelThread;

        public void Refuel(PetrolStation station, int number, int liter)
        {
            this.station = station; 
            this.number = number; this.
            liter = liter;
            fuelThread = new Thread(new ThreadStart(Activity));
            fuelThread.Start();
        }
        public class NoRefuelingException : Exception { }
        private void Activity()
        {
            if (null == station || null == station.CashDesk || number < 0 || 
                number >= station.PumpsCount) throw new NoRefuelingException();

            Console.WriteLine($"{Name}. car is driving in, and joining the {number+1}. pump");
            station.GetPump(number).JoinQueue(this);        // joins the queue at the n-th pump
            Console.WriteLine($@"{Name}. car is fueling {liter} liters petrol");
            station.GetPump(number).Fill(this, liter);      // refuels petrol      
            Console.WriteLine($"{Name}. car is joining the cash desk");
            station.CashDesk.JoinQueue(this);               // goes to cashdesk and joins the queue
            int sum = station.CashDesk.Pay(this);           // pays
            Console.WriteLine($"{Name}. car has paid: {sum} Ft");
            station.GetPump(number).Leave(this);            // leaves the petrolstation
            Console.WriteLine($"{Name}. car has left");
        }
    }
}
