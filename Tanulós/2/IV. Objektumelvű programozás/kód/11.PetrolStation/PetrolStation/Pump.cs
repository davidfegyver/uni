//Author:   Gregorics Tibor
//Date:     2021.11.16.
//Title:    class of pumps of petrolstations

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Threading;


namespace PetrolStation
{
    class AlarmException : WarningException 
    { 
        public AlarmException(string str) : base(str) { } 
    }

    class Queue <Item> where Item : class
    {
        private readonly List<Item> list = new();  
        
        public Queue () { }

        public void Exit(Item item) { list.Remove(item); }

        public void Enter(Item item) { list.Add(item);  }

        public Item First() { if (list.Count > 0) return list[0]; else return null; }

        public bool In(Item item) { return list.Contains(item); }

        public int Size() { return list.Count; }
    }
    class Pump
    {
        private readonly Queue<Car> queue = new();
        private int quantity = 0;
        private readonly PetrolStation petrol;

        public Pump(PetrolStation petrol) 
        {
            this.petrol = petrol;
        }

        public int Quantity()
        { 
            int value; 
            Monitor.Enter(this);
            value = quantity;
            Monitor.Exit(this);
            return value;
        }
        public void ResetQuantity(CashDeck cashdeck) 
        {
            if (petrol.CashDesk == cashdeck)
            {
                Monitor.Enter(this);
                quantity = 0;
                Monitor.Exit(this);
            }
        }

        public bool IsFirst(Car car) 
        {
            Monitor.Enter(this); 
            bool l = queue.First()==car;
            Monitor.Exit(this);
            return l;
        }

        public void JoinQueue(Car car)
        {
            Monitor.Enter(this);
            if (petrol.Search(car)==null)
            {
                queue.Enter(car);   // car joins the end of the queue
                while (!IsFirst(car)) Monitor.Wait(this);   // wait until he is the first
            }
            else throw new WarningException();
            Monitor.Exit(this);
        }

        public void Fill(Car car, int liter)
        {
            Monitor.Enter(this);
            if (IsFirst(car) && liter > 0)
            {
                quantity = Math.Max(liter, 0);
                Thread.Sleep(liter * 200); // time of fueling depends on the amount of petrol fueled
            }
            else Console.WriteLine("must be the first in the queue, must be fill in some fluel");
            Monitor.Exit(this);
        }

        public void Leave(Car car)
        {
            Monitor.Enter(this);
            if (queue.In(car))
            {
                if (!IsFirst(car)) { Console.WriteLine("wants to leave the queue but is not the first"); }
                else if (quantity > 0) throw new AlarmException("forget to pay");
                queue.Exit(car);  // leaves the queue
                Monitor.PulseAll(this);
            }
            Monitor.Exit(this);
        }
    }
}
