using System;
using System.Collections.Generic;
using System.Text;

namespace Turistak
{
    public class Szimulacio
    {
        private readonly string[] sorok;
        private readonly List<EvAdat> evAdatok = new List<EvAdat>();
        private readonly List<EvesEredmeny> eredmenyek = new List<EvesEredmeny>();

        private Varos? varos;

        public Szimulacio(string[] sorok)
        {
            if (sorok.Length < 2)
            {
                throw new ArgumentException("miau");
            }

            this.sorok = sorok;
        }

        public IReadOnlyList<EvAdat> EvAdatok => evAdatok;
        public IReadOnlyList<EvesEredmeny> Eredmenyek => eredmenyek;
        public int LegjobbAllapotErtek { get; private set; }
        public int LegjobbEvSorszam { get; private set; }

        public IReadOnlyList<EvesEredmeny> Futtat()
        {
            evAdatok.Clear();
            eredmenyek.Clear();
            LegjobbEvSorszam = 0;
            LegjobbAllapotErtek = -1;

            int kezdoAllapot = int.Parse(sorok[0]);
            varos = new Varos(kezdoAllapot);

            for (int i = 1; i < sorok.Length; i++)
            {
                if (string.IsNullOrWhiteSpace(sorok[i]))
                {
                    continue;
                }

                EvAdat evAdat = EvAdatParse(sorok[i], i);
                evAdatok.Add(evAdat);

                EvesEredmeny eredmeny = varos.EvetSzimulal(evAdat);
                eredmenyek.Add(eredmeny);

                if (eredmeny.UjAllapotErtek > LegjobbAllapotErtek)
                {
                    LegjobbAllapotErtek = eredmeny.UjAllapotErtek;
                    LegjobbEvSorszam = eredmeny.EvSorszam;
                }
            }

            return eredmenyek;
        }

        private static EvAdat EvAdatParse(string sor, int evSorszam)
        {
            string[] adatok = sor.Split(" ");
            if (adatok.Length != 3)
            {
                throw new ArgumentException($"{evSorszam}. év három számot tartalmazzon! ");
            }

            return new EvAdat(
                evSorszam,
                int.Parse(adatok[0]),
                int.Parse(adatok[1]),
                int.Parse(adatok[2]));
        }
    }
}
