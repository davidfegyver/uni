//Author:   Gregorics Tibor
//Date:     2022.08.15.
//Title:    interface of the representations of sets including integers
//          based on the bridge design pattern 

using System;

namespace Set
{
    interface ISetRepr : ICloneable
    {
        void SetEmpty();
        void Insert(int e);
        void Remove(int e);
        int Select();
        bool Empty();
        bool In(int e);
    }
}
