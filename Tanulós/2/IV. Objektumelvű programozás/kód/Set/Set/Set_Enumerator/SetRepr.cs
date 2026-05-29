//Author:   Gregorics Tibor
//Date:     2022.08.16.
//Title:    abstract representations of sets including integers
//          based on the bridge and iterator design pattern

using System;

namespace Set_Enumerator
{
    abstract class SetRepr : ICloneable
    {
        public int EnumeratorCount { get; protected set; }
        public SetRepr() { EnumeratorCount = 0; }
        public abstract void SetEmpty();
        public abstract void Insert(int e);
        public abstract void Remove(int e);
        public abstract int Select();
        public abstract  bool Empty();
        public abstract bool In(int e);
        public abstract object Clone();
        public abstract MyEnumerator CreateEnumerator();
    }
}
