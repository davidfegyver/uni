//Author:   Gregorics Tibor
//Date:     2022.08.18.
//Title:    interface of the representations of sets including integers
//          based on the bridge pattern 

using System;
using System.Collections;

namespace Set_Enumarable_Generic
{
    interface ISetRepr<T> : IEnumerable, ICloneable
    {
        void SetEmpty();
        void Insert(T e);
        void Remove(T e);
        T Select();
        bool Empty();
        bool In(T e);
    }
}
