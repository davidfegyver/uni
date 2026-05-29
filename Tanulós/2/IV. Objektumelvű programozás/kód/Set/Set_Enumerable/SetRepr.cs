//Author:   Gregorics Tibor
//Date:     2022.08.18.
//Title:    interface of the representations of sets including integers
//          based on the bridge pattern 

using System;
using System.Collections;

namespace Set_Enumarable
{
    interface ISetRepr : IEnumerable, ICloneable
    {
        void SetEmpty();
        void Insert(int e);
        void Remove(int e);
        int Select();
        bool Empty();
        bool In(int e);
    }
}
