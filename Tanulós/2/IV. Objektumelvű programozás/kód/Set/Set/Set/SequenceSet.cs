//Author:   Gregorics Tibor
//Date:     2022.08.15.
//Title:    class of representation of a set including integers storing in a sequence

using System;
using System.Collections.Generic;

namespace Set
{
    class SequenceSet : ISetRepr, ICloneable
    {
        private List<int> seq = new List<int>();

        public SequenceSet() { seq.Clear(); }
        public SequenceSet(SequenceSet source) { seq = new List<int>(source.seq); }
        public object Clone() 
        {
            return new SequenceSet() { seq = new List<int>(seq) }; 
        }

        public void SetEmpty() { seq.Clear(); }
        public void Insert(int e) { if (!seq.Contains(e)) seq.Add(e); }
        public void Remove(int e) { seq.Remove(e); }
        public bool Empty() { return seq.Count == 0; }
        public int Select() { return seq[0]; }
        public bool In(int e) { return seq.Contains(e); }
    }
}
