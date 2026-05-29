//Author:   Gregorics Tibor
//Date:     2022.08.17.
//Title:    abstract generic class of enumerator

using System.Collections.Generic;
using System.Collections;

namespace Set_Generic
{
    abstract class MyEnumerator<T> : IEnumerable<T>
    {
        public abstract void First();
        public abstract void Next();
        public abstract bool End();
        public abstract T Current();
        public abstract void Finish();

        IEnumerator<T> IEnumerable<T>.GetEnumerator()
        {
            for (First(); !End(); Next())
            {
                yield return Current();
            }
        }
        IEnumerator IEnumerable.GetEnumerator()
        {
            for (First(); !End(); Next())
            {
                yield return Current();
            }
        }
 
    }
}
