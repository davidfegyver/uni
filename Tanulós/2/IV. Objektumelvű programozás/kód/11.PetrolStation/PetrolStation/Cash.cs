//Author:   Gregorics Tibor
//Date:     2021.11.16.
//Title:    class of cash desks

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Threading;

namespace PetrolStation
{
    class Cash
    {
        private readonly int capacity;
        private int engaged = 0;    
        private readonly Queue<Car> queue = new ();
        private readonly PetrolStation station;

        public Cash(PetrolStation station, int capacity) { this.station = station; this.capacity = capacity; }

        private static double Invoice(int liter, double price) { return liter * price; }

        public void JoinQueue(Car car)
        {
            Monitor.Enter(this);
            if (!queue.In(car))
            {
                queue.Enter(car);   // car joins the end of the queue
                while (!(queue.First()==car && engaged < capacity)) Monitor.Wait(this); // wait until he is the first and there is free cassa
            }
            else throw new WarningException();
            Monitor.Exit(this);
        }
        public int Pay(Car car)
        {
            Monitor.Enter(this);
            bool l = queue.First()==car && engaged < capacity;
            Monitor.Exit(this);

            int sum = 0;
            if (l)
            {
                Monitor.Enter(this);
                ++engaged;              // steps to a cash desk
                queue.Exit(car);        // leaves the queue
                Monitor.Exit(this);

                Pump pump = station.Search(car);
                if (pump != null)
                {
                    sum = (int)Invoice(pump.Quantity(), station.Unit);
                    pump.ResetQuantity();   // resets the display of the i-th pump
                    Thread.Sleep(10000);    //elapsed time of paying
                }
                else { Console.WriteLine("there is nothing to pay"); }

                Monitor.Enter(this);
                --engaged;              // leaves the cash desk
                Monitor.PulseAll(this);
                Monitor.Exit(this);
            }
            return sum;
        }
    }
}
