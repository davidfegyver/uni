//Author:   Gregorics Tibor
//Date:     2022.08.18.
//Title:    enumerable class of general type of sets including integers
//          based on the bridge design pattern 

using System;
using System.Collections;

namespace Set_Enumarable
{
    //General type of sets of integers without its representation
    //Constructor selects a representation (dependency injection) based on its parameter
    //Methods:
    //SetEmpty()   - all integers are removed from the set
    //Insert()     - a given integer is put in the set
    //Remove()     - a given integer is removed from the set
    //Select()     - selects an integer from a non-empty set
    //Empty()      - checks whether the set is empty
    //In()         - checks whether a given integer is in the set
    class Set : IEnumerable, ICloneable
    {
        public class EmptySetException : Exception { }
        public class IllegalElementException : Exception
        {
            public int e;
            public IllegalElementException(int n) { e = n; }
        }

        private ISetRepr repr;

        public Set(int n = 0)
        {
            if (0 == n) repr = new SequenceSet();
            else repr = new ArraySet(n);
        }

        public Set(Set other)
        {
            if (other.repr is SequenceSet seqsetrepr) repr = new SequenceSet(seqsetrepr);
            else if (other.repr is ArraySet arraysetrepr) repr = new ArraySet(arraysetrepr);
        }

        public object Clone()
        {
            return new Set() { repr = (ISetRepr)repr.Clone() };
        }

        public void SetEmpty() { repr.SetEmpty(); }

        public void Insert(int e) { repr.Insert(e); }

        public void Remove(int e) { repr.Remove(e); }

        public int Select()
        {
            if (Empty()) throw new EmptySetException();
            return repr.Select();
        }

        public bool Empty() { return repr.Empty(); }

        public bool In(int e) { return repr.In(e); }

        IEnumerator IEnumerable.GetEnumerator()
        {
            foreach (var e in repr) yield return e;
        }
    }
}
