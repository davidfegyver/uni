//Author:   Gregorics Tibor
//Date:     2022.08.18.
//Title:    class of representation of a set including natural numbers with an upper bound n
//          storing in an array over the interval 0..n

using System.Collections;

namespace Set_Enumarable_Generic
{
    class ArraySet : ISetRepr<int>
    {
        private bool[] vect;
        int size;

        public ArraySet(int n) 
        {
            vect = new bool[n + 1];
            for (int i = 0; i <= n; ++i) vect[i] = false;
            size = 0;
        }
        public ArraySet(ArraySet source) 
        {
            vect = new bool[source.vect.Length];
            source.vect.CopyTo(vect, 0);
            size = source.size;
        }
        public object Clone()
        {
            ArraySet copy = new (size) { vect = new bool[vect.Length] };
            for (int i = 0; i < vect.Length; ++i) copy.vect[i] = vect[i];
            copy.size = size;
            return copy;
        }
        public void SetEmpty()
        {
            for (int i = 0; i < vect.Length; ++i) vect[i] = false;
            size = 0;
        }
        public void Insert(int e)
        {
            if (e < 0 || e >= vect.Length) throw new Set<int>.IllegalElementException(e);
            if (!vect[e])
            {
                vect[e] = true;
                ++size;
            }
        }
        public void Remove(int e)
        {
            if (e < 0 || e >= vect.Length) throw new Set<int>.IllegalElementException(e);
            if (vect[e])
            {
                vect[e] = false;
                --size;
            }
        }
        public int Select()
        {
            int e;
            for (e = 0; !vect[e]; ++e) ;
            return e;
        }
        public bool Empty() { return size == 0; }
        public bool In(int e)
        {
            if (e < 0 || e >= vect.Length) throw new Set<int>.IllegalElementException(e);
            return vect[e];
        }
        IEnumerator IEnumerable.GetEnumerator()
        {
            //for (int i = 0; i < vect.Length; ++i)
            foreach(int i in Enumerable.Range(0,vect.Length-1))
                if (vect[i]) yield return i;
        }
    }
}
