//Author:   Gregorics Tibor
//Date:     2022.08.18.
//Title:    enumerable class of general type of sets including integers
//          based on the bridge design pattern 

using System.Collections;

namespace Set_Enumarable_Generic
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
    class Set<T> : IEnumerable, ICloneable
    {
        public class EmptySetException : Exception { }
        public class UnderTraversalException : Exception { }
        public class IllegalElementException : Exception
        {
            public int e;
            public IllegalElementException(int n) { e = n; }
        }
        public class MeaninglessConstructorParameter : Exception { }

        private ISetRepr<T> repr;

        public Set(int n = 0)
        {
            object o;
            if (typeof(T) == typeof(int))
            {
                if (0 == n) o = new SequenceSet<int>();
                else o = new ArraySet(n);
            }
            else
            {
                if (n != 0) throw new MeaninglessConstructorParameter();
                else o = new SequenceSet<T>();
            }
            repr = (ISetRepr<T>)o;
        }

        public Set(Set<T> other)
        {
            object o = other; //= null;
            if (typeof(T) == typeof(int))
            {
                if (other.repr is SequenceSet<int> seqrepr) o = new SequenceSet<int>(seqrepr);
                else if (other.repr is ArraySet arrayrepr) o = new ArraySet(arrayrepr);
            }
            // else o = new SequenceSet<T>(other.repr as SequenceSet<T>);
            else o = new SequenceSet<T>((SequenceSet<T>)other.repr);
            repr = (ISetRepr<T>)o!;
        }

        public object Clone()
        {
            return new Set<T>() { repr = (ISetRepr<T>)repr.Clone() };
        }

        public void SetEmpty() { repr.SetEmpty(); }

        public void Insert(T e) { repr.Insert(e); }

        public void Remove(T e) { repr.Remove(e); }

        public T Select()
        {
            if (Empty()) throw new EmptySetException();
            return repr.Select();
        }

        public bool Empty() { return repr.Empty(); }

        public bool In(T e) { return repr.In(e); }

        IEnumerator IEnumerable.GetEnumerator()
        {
            foreach (var e in repr) yield return e;
        }
    }
}
