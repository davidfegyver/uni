//Author:   Gregorics Tibor
//Date:     2022.08.17.
//Title:    abstract generic representations of sets
//          based on the bridge and iterator design pattern 

using System;

namespace Set_Generic
{
    abstract class SetRepr<T> : ICloneable
    {
        public int EnumeratorCount { get; protected set; }
        public SetRepr() { EnumeratorCount = 0; }
        public abstract void SetEmpty();
        public abstract void Insert(T e);
        public abstract void Remove(T e);
        public abstract T Select();
        public abstract bool Empty();
        public abstract bool In(T e);
        public abstract object Clone();
        public abstract MyEnumerator<T> CreateEnumerator();
    }
}
