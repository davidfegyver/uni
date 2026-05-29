//Author:   Gregorics Tibor
//Date:     2022.08.17.
//Title:    generic class of general type of sets including integers with enumerator
//          based on the bridge and iterator design pattern 

using System;

namespace Set_Generic
{
    //General type of sets without its representation
    //Constructor selects a representation (dependency injection) based on its parameter
    //Methods:
    //SetEmpty()   - all elements are removed from the set
    //Insert()     - a given element is put in the set
    //Remove()     - a given element is removed from the set
    //Select()     - selects an element from a non-empty set
    //Empty()      - checks whether the set is empty
    //In()         - checks whether a given element is in the set

    class Set<T> : ICloneable
    {
        public class EmptySetException : Exception { }
        public class UnderTraversalException : Exception { }
        public class IllegalElementException : Exception
        {
            public int e;
            public IllegalElementException(int n) { e = n; }
        }
        public class UpperLimitButElementsNotInteger : Exception { }

        protected SetRepr<T> repr;

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
                if (n > 0) throw new UpperLimitButElementsNotInteger();
                else o = new SequenceSet<T>();
            }
            repr = (SetRepr<T>)o;
        }

        public Set(Set<T> other)
        {
            object o = null;
            if (typeof(T) == typeof(int))
            {
                if (other.repr is SequenceSet<int> seqrepr) o = new SequenceSet<int>(seqrepr);
                else if(other.repr is ArraySet arrayrepr)   o = new ArraySet(arrayrepr);
            }
            else o = new SequenceSet<T>(other.repr as SequenceSet<T>);
         //   else o = new SequenceSet<T>((SequenceSet<T>)other.repr);
            repr = (SetRepr<T>)o;
        }
    
        public object Clone()
        {
            return new Set<T>() { repr = (SetRepr<T>)repr.Clone() };
        }

        public void SetEmpty() { repr.SetEmpty(); }
        public void Insert(T e) 
        {
            if (repr.EnumeratorCount != 0) throw new UnderTraversalException(); 
            repr.Insert(e); 
        }
        public void Remove(T e) { repr.Remove(e); }
        public T Select()
        {
            if (Empty()) throw new EmptySetException();
            return repr.Select();
        }
        public bool Empty()
        { 
            return repr.Empty();
        }
        public bool In(T e) 
        { 
            return repr.In(e); 
        }

        public MyEnumerator<T> CreateEnumerator() 
        { 
            return repr.CreateEnumerator(); 
        }
    }
}
