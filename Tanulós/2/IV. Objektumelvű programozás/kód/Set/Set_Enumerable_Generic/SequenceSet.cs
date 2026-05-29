//Author:   Gregorics Tibor
//Date:     2022.08.18.
//Title:    class of representation of a set including integers storing in a sequence

using System;
using System.Collections;
using System.Collections.Generic;

namespace Set_Enumarable_Generic
{
    class SequenceSet<T> : ISetRepr<T>
    {
        private List<T> seq = new ();

        public SequenceSet() { seq.Clear(); }
        public SequenceSet(SequenceSet<T> source) { seq = new List<T>(source.seq); }
        public object Clone() { return new SequenceSet<T>() { seq = new List<T>(seq) }; }

        public void SetEmpty() { seq.Clear(); }
        public void Insert(T e) { if (!seq.Contains(e)) seq.Add(e); }
        public void Remove(T e) { seq.Remove(e); }
        public bool Empty() { return seq.Count == 0; }
        public T Select() { return seq[0]; }
        public bool In(T e) { return seq.Contains(e); }

        IEnumerator IEnumerable.GetEnumerator()
        {
            foreach (var e in seq) yield return e;
        }

    }
}
