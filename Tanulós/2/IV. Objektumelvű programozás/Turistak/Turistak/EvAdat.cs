using System;
using System.Collections.Generic;
using System.Text;

namespace Turistak
{
    public class EvAdat
    {
        public EvAdat(int evSorszam, int japanTervezettDarab, int nyugatiTervezettDarab, int egyebTervezettDarab)
        {
            EvSorszam = evSorszam;
            JapanTervezettDarab = japanTervezettDarab;
            NyugatiTervezettDarab = nyugatiTervezettDarab;
            EgyebTervezettDarab = egyebTervezettDarab;
        }

        public int EvSorszam { get; }
        public int JapanTervezettDarab { get; }
        public int NyugatiTervezettDarab { get; }
        public int EgyebTervezettDarab { get; }

        public List<TuristaCsoport> TuristaCsoportokLetrehozasa()
        {
            return new List<TuristaCsoport>
            {
                new JapanTuristaCsoport(JapanTervezettDarab),
                new NyugatiTuristaCsoport(NyugatiTervezettDarab),
                new EgyebTuristaCsoport(EgyebTervezettDarab)
            };
        }
    }
}
