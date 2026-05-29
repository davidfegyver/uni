using System;
using System.Collections.Generic;
using System.Text;

namespace Turistak
{
    public class EvesEredmeny
    {
        public int EvSorszam { get; set; }
        public int JapanTervezettDarab { get; set; }
        public int NyugatiTervezettDarab { get; set; }
        public int EgyebTervezettDarab { get; set; }
        public int JapanTenylegesDarab { get; set; }
        public int NyugatiTenylegesDarab { get; set; }
        public int EgyebTenylegesDarab { get; set; }
        public long EvesBevetel { get; set; }
        public int UjAllapotErtek { get; set; }
        public string UjAllapotNev { get; set; } = "";
    }
}
