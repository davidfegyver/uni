//Author:   Gregorics Tibor
//Date:     2021.11.16.
//Title:    class of petrolstations

using System.Collections.Generic;
using static System.Collections.Specialized.BitVector32;

namespace PetrolStation
{
    class PetrolStation
    {
        private readonly List<Pump> pumps = new ();
        public CashDeck CashDesk { get; }
        public double Unit { get; set; }

        public PetrolStation(int n, int m)
        {
            for (int i = 0; i < n; ++i)
            {
                pumps.Add(new Pump(this));
            }
            CashDesk = new CashDeck(this, m);
        }

        public Pump GetPump(int number) { return pumps[number]; }

        public int PumpsCount { get => pumps.Count; }

        public Pump Search(Car car)
        {
            return pumps.Find(p => p.IsFirst(car));
        }

    }
}
