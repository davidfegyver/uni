//Author:   Gregorics Tibor
//Date:     2022.08.17.
//Title:    generic class of representation of a set whose elements storing in a sequence 
//          generic class of enumerator

using System;
using System.Collections.Generic;

namespace Set_Generic
{
    //Set including elements is represented with a sequence
    class SequenceSet<T> : SetRepr<T>, ICloneable
    {
        private List<T> seq = new List<T>();
        public SequenceSet() : base() { seq.Clear(); }
        public SequenceSet(SequenceSet<T> source) : base() { seq = new List<T>(source.seq); }
        public override object Clone() { return new SequenceSet<T>() { seq = new List<T>(seq) }; }

        public override void SetEmpty() { seq.Clear(); }
        public override void Insert(T e) { if (!seq.Contains(e)) seq.Add(e); }
        public override void Remove(T e) { seq.Remove(e); }
        public override bool Empty() { return seq.Count == 0; }
        public override T Select() { return seq[0]; }
        public override bool In(T e) { return seq.Contains(e); }

        public class SequenceSetEnor<T> : MyEnumerator<T>
        {
            private readonly SequenceSet<T> s;
            private int ind;

            public SequenceSetEnor(SequenceSet<T> h) { s = h; }

            public override void First()
            {
                ind = 0;
                if (s.seq.Count > 0) { ++s.EnumeratorCount; }
            }
            public override void Next()
            {
                ++ind;
                if (ind == s.seq.Count) { --s.EnumeratorCount; }
            }
            public override bool End() { return ind == s.seq.Count; }
            public override T Current() { return s.seq[ind]; }
            public override void Finish()
            {
                if (ind < s.seq.Count)
                {
                    ind = s.seq.Count;
                    --s.EnumeratorCount;
                }
            }
        }
        public override MyEnumerator<T> CreateEnumerator()
        {
            return new SequenceSetEnor<T>(this);
        }
    }
}
