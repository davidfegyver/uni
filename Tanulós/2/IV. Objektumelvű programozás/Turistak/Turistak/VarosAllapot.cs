using System;
using System.Collections.Generic;
using System.Text;

namespace Turistak
{
    public interface IAllapot
    {
        string Nev();
        double Accept(TuristaCsoport csoport);
    }

    public class JoAllapot : IAllapot
    {
        public string Nev() => "Jó";
        public double Accept(TuristaCsoport csoport) => csoport.Visit(this);
    }

    public class AtlagosAllapot : IAllapot
    {
        public string Nev() => "Átlagos";
        public double Accept(TuristaCsoport csoport) => csoport.Visit(this);
    }

    public class LepusztultAllapot : IAllapot
    {
        public string Nev() => "Lepusztult";
        public double Accept(TuristaCsoport csoport) => csoport.Visit(this);
    }
}
