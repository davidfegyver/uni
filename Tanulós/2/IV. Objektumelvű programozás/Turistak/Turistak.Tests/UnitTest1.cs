namespace Turistak.Tests
{
    public class UnitTest1
    {
        [Fact]
        public void AllapotKategoriak()
        {
            Assert.Equal("Lepusztult", new Varos(1).AktualisAllapot.Nev());
            Assert.Equal("Lepusztult", new Varos(33).AktualisAllapot.Nev());
            Assert.Equal("Átlagos", new Varos(34).AktualisAllapot.Nev());
            Assert.Equal("Átlagos", new Varos(66).AktualisAllapot.Nev());
            Assert.Equal("Jó", new Varos(67).AktualisAllapot.Nev());
            Assert.Equal("Jó", new Varos(100).AktualisAllapot.Nev());
        }

        [Fact]
        public void TuristaSzorzok()
        {
            Assert.Equal(120, new JapanTuristaCsoport(100).TenylegesDarabSzamit(new JoAllapot()));
            Assert.Equal(100, new JapanTuristaCsoport(100).TenylegesDarabSzamit(new AtlagosAllapot()));
            Assert.Equal(0, new JapanTuristaCsoport(100).TenylegesDarabSzamit(new LepusztultAllapot()));

            Assert.Equal(130, new NyugatiTuristaCsoport(100).TenylegesDarabSzamit(new JoAllapot()));
            Assert.Equal(110, new NyugatiTuristaCsoport(100).TenylegesDarabSzamit(new AtlagosAllapot()));
            Assert.Equal(100, new NyugatiTuristaCsoport(100).TenylegesDarabSzamit(new LepusztultAllapot()));

            Assert.Equal(100, new EgyebTuristaCsoport(100).TenylegesDarabSzamit(new JoAllapot()));
            Assert.Equal(110, new EgyebTuristaCsoport(100).TenylegesDarabSzamit(new AtlagosAllapot()));
            Assert.Equal(100, new EgyebTuristaCsoport(100).TenylegesDarabSzamit(new LepusztultAllapot()));
        }

        [Fact]
        public void RomlasEsBevetel()
        {
            Varos varos = new Varos(67);

            EvesEredmeny eredmeny = varos.EvetSzimulal(new EvAdat(1, 0, 100, 100));

            Assert.Equal(130, eredmeny.NyugatiTenylegesDarab);
            Assert.Equal(100, eredmeny.EgyebTenylegesDarab);
            Assert.Equal(23_000_000L, eredmeny.EvesBevetel);
            Assert.Equal(64, eredmeny.UjAllapotErtek);
            Assert.Equal("Átlagos", eredmeny.UjAllapotNev);
        }

        [Fact]
        public void Fejlesztes()
        {
            Varos varos = new Varos(67);

            EvesEredmeny eredmeny = varos.EvetSzimulal(new EvAdat(1, 210_000, 0, 0));

            Assert.Equal(252_000, eredmeny.JapanTenylegesDarab);
            Assert.Equal(25_200_000_000L, eredmeny.EvesBevetel);
            Assert.Equal(100, eredmeny.UjAllapotErtek);
            Assert.Equal("Jó", eredmeny.UjAllapotNev);
        }

        [Fact]
        public void LegjobbEv()
        {
            Szimulacio szimulacio = new Szimulacio(new[]
            {
                "34",
                "0 0 0",
                "210000 0 0"
            });

            szimulacio.Futtat();

            Assert.Equal(2, szimulacio.LegjobbEvSorszam);
            Assert.Equal(54, szimulacio.LegjobbAllapotErtek);
        }

        [Fact]
        public void MintaBemenet()
        {
            Szimulacio szimulacio = new Szimulacio(new[]
            {
                "50",
                "1000 4000 6000",
                "2000 3000 8000",
                "6500 5000 3000"
            });

            IReadOnlyList<EvesEredmeny> eredmenyek = szimulacio.Futtat();

            Assert.Equal(3, eredmenyek.Count);

            Assert.Equal(1000, eredmenyek[0].JapanTenylegesDarab);
            Assert.Equal(4400, eredmenyek[0].NyugatiTenylegesDarab);
            Assert.Equal(6600, eredmenyek[0].EgyebTenylegesDarab);
            Assert.Equal(1_200_000_000L, eredmenyek[0].EvesBevetel);
            Assert.Equal(1, eredmenyek[0].UjAllapotErtek);
            Assert.Equal("Lepusztult", eredmenyek[0].UjAllapotNev);

            Assert.Equal(1, szimulacio.LegjobbEvSorszam);
            Assert.Equal(1, szimulacio.LegjobbAllapotErtek);
        }
    }
}
