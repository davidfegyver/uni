//Author:   Gregorics Tibor
//Date:     2021.11.13.
//Title:    abstract and concrete classes of creatures 

using TextFile;
using System;
using System.Collections.Generic;

namespace Creatures
{
    // class of abstract creatures
    abstract class Creature
    {
        public string Name { get; }
        protected int power; 
        public void ModifyPower(int e) { power += e; }
        public bool Alive()  { return power > 0; }
       
        protected Creature(string str, int e = 0) { Name = str; power = e; }
        public void Race(ref List<IGround> courts)
        {
            for(int j = 0; Alive() && j<courts.Count; ++j)
            {
                IGround court = courts[j];
                Traverse(ref court);
                courts[j] = court;
            }
        }
        protected abstract void Traverse(ref IGround court);
    }

    // class of dune beetles
    class DuneBeetle : Creature
    {
        public DuneBeetle(string str, int e = 0) : base(str, e) { }
        protected override void Traverse(ref IGround court)
        {
            court = court.Change(this);
        }
    }

    // class of squelchies
    class Squelchy : Creature
    {
        public Squelchy(string str, int e = 0) : base(str, e) { }
        protected override void Traverse(ref IGround court)
        {
            court = court.Change(this);
        }
    }

    // class of green finches
    class Greenfinch : Creature
    {
        public Greenfinch(string str, int e = 0) : base(str, e) { }
        protected override void Traverse(ref IGround court)
        {
            court = court.Change(this); 
        }
    }
}
