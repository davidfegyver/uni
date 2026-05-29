//Author:   Gregorics Tibor
//Date:     2022.08.16.
//Title:    class of representation of a set including integers storing in a sequence 
//          class of enumerator

using System;
using System.Collections.Generic;

namespace Set_Enumerator
{
    //Set including integers represented with a sequence
    class SequenceSet : SetRepr, ICloneable
    {
        private List<int> seq = new ();

        public SequenceSet() : base() { seq.Clear(); }
        public SequenceSet(SequenceSet source) : base() { seq = new List<int>(source.seq);  }
        public override object Clone() { return new SequenceSet() { seq = new List<int>(seq) }; }
        
        public override void SetEmpty() { seq.Clear(); }
        public override void Insert(int e) { if (!seq.Contains(e)) seq.Add(e); }
        public override void Remove(int e) { seq.Remove(e); }
        public override bool Empty() { return seq.Count == 0; }
        public override int Select() { return seq[0]; }
        public override bool In(int e) { return seq.Contains(e); }

        public class SequenceSetEnor : MyEnumerator
        {
            private readonly SequenceSet s;
            private int ind;

            public SequenceSetEnor(SequenceSet h) 
            { 
                s = h; 
                if (s.seq.Count > 0) { ++s.EnumeratorCount; } 
            }

            public override void First()
            {
                ind = 0;
            }
            public override void Next()
            {
                ++ind;
                if (ind == s.seq.Count) { --s.EnumeratorCount; }
            }
            public override bool End() { return ind == s.seq.Count; }
            public override int Current() { return s.seq[ind]; }
            ~SequenceSetEnor() 
            {
                if (ind < s.seq.Count) 
                { 
                    ind = s.seq.Count; 
                    --s.EnumeratorCount; 
                }
            }
        }
        public override MyEnumerator CreateEnumerator() { return new SequenceSetEnor(this); }
    }
}
