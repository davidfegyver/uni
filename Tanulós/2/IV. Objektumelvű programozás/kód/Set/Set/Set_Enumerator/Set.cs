//Author:   Gregorics Tibor
//Date:     2022.08.16.
//Title:    class of general type of sets including integers with enumerator
//          based on the bridge and iterator design pattern 

using System;

namespace Set_Enumerator
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
    class Set : ICloneable
    {
        public class EmptySetException : Exception { }
        public class UnderTraversalException : Exception { }
        public class IllegalElementException : Exception
        {
            public int e;
            public IllegalElementException(int n) { e = n; }
        }

        private SetRepr repr;
        public Set(int n = 0)
        {
            if (0 == n) repr = new SequenceSet();
            else repr = new ArraySet(n);
        }
        public Set(Set other)
        {
            if (other.repr is SequenceSet seqrepr) repr = new SequenceSet(seqrepr);
            else if (other.repr is ArraySet arrayrepr)  repr = new ArraySet(arrayrepr);
        }
        public object Clone() 
        {
            return new Set() { repr = (SetRepr)repr.Clone() };
        }

        public void SetEmpty() { repr.SetEmpty(); }
        public void Insert(int e) 
        {
            if (repr.EnumeratorCount != 0) throw new UnderTraversalException(); 
            repr.Insert(e); 
        }
        public void Remove(int e)
        {
            if (repr.EnumeratorCount != 0) throw new UnderTraversalException();
            repr.Remove(e);
        }
        public int Select()
        {
            if (Empty()) throw new EmptySetException();
            return repr.Select();
        }
        public bool Empty() { return repr.Empty(); }

        public bool In(int e) { return repr.In(e); }

        public MyEnumerator CreateEnumerator() { return repr.CreateEnumerator(); }
    }

}
