//Author:   Gregorics Tibor
//Date:     2022.08.16.
//Title:    abstract class of enumerator

using System.Collections;

namespace Set_Enumerator
{
    abstract class MyEnumerator : IEnumerable
    {
        public abstract void First();
        public abstract void Next();
        public abstract bool End();
        public abstract int Current();
 //       public abstract void Finish();

        IEnumerator IEnumerable.GetEnumerator()
        {
            for (First(); !End(); Next())
            {
                yield return Current();
            }
        }
    }
}
