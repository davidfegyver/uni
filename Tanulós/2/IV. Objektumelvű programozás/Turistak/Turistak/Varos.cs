using System;
using System.Collections.Generic;
using System.Text;

namespace Turistak
{
    public class Varos
    {

        public Varos(int kezdoAllapotErtek)
        {
            if (kezdoAllapotErtek < 1 || kezdoAllapotErtek > 100)
            {
                throw new ArgumentOutOfRangeException(
                    "A város állapota 1 és 100 közötti egész szám lehet.");
            }

            AllapotErtek = kezdoAllapotErtek;
            AktualisAllapot = AllapotKivalaszt(AllapotErtek);
        }

        public int AllapotErtek { get; private set; }
        public IAllapot AktualisAllapot { get; private set; }

        public EvesEredmeny EvetSzimulal(EvAdat evAdat)
        {
            List<TuristaCsoport> csoportok = evAdat.TuristaCsoportokLetrehozasa();

            foreach (TuristaCsoport csoport in csoportok)
            {
                csoport.TenylegesDarabSzamit(AktualisAllapot);
            }

            long bevetel = BevetelSzamit(csoportok);
            int romlas = RomlasSzamit(csoportok);
            int fejlesztes = FejlesztesSzamit(bevetel);

            //Console.WriteLine(
            //    $"Év {evAdat.EvSorszam}: bevétel {bevetel} Ft, romlás {romlas} pont, fejlesztés {fejlesztes} pont.");

            AllapotFrissit(romlas, fejlesztes);

            return new EvesEredmeny
            {
                EvSorszam = evAdat.EvSorszam,
                JapanTervezettDarab = evAdat.JapanTervezettDarab,
                NyugatiTervezettDarab = evAdat.NyugatiTervezettDarab,
                EgyebTervezettDarab = evAdat.EgyebTervezettDarab,
                JapanTenylegesDarab = csoportok[0].TenylegesDarab,
                NyugatiTenylegesDarab = csoportok[1].TenylegesDarab,
                EgyebTenylegesDarab = csoportok[2].TenylegesDarab,
                EvesBevetel = bevetel,
                UjAllapotErtek = AllapotErtek,
                UjAllapotNev = AktualisAllapot.Nev()
            };
        }

        public static long TurisztikaiBevetel(int turistaDarab)
        {
            return (long)turistaDarab * 100_000L;
        }

        private static long BevetelSzamit(IEnumerable<TuristaCsoport> csoportok)
        {
            long osszeg = 0;
            foreach (TuristaCsoport csoport in csoportok)
            {
                osszeg += csoport.Bevetel();
            }

            return osszeg;
        }

        private static int RomlasSzamit(IEnumerable<TuristaCsoport> csoportok)
        {
            int osszeg = 0;
            foreach (TuristaCsoport csoport in csoportok)
            {
                osszeg += csoport.Romlas();
            }

            return osszeg;
        }

        private static int FejlesztesSzamit(long bevetel)
        {
            if (bevetel <= 20_000_000_000L)
            {
                return 0;
            }

            return (int)((bevetel - 20_000_000_000L) / 50_000_000L);
        }

        private void AllapotFrissit(int romlas, int fejlesztes)
        {
            AllapotErtek = Math.Clamp(AllapotErtek + fejlesztes - romlas, 1, 100);
            AktualisAllapot = AllapotKivalaszt(AllapotErtek);
        }

        private static IAllapot AllapotKivalaszt(int allapotErtek)
        {
            if (allapotErtek >= 67)
            {
                return new JoAllapot();
            }

            if (allapotErtek >= 34)
            {
                return new AtlagosAllapot();
            }

            return new LepusztultAllapot();
        }
    }
}
