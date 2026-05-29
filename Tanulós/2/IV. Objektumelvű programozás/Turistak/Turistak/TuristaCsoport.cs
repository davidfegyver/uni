using System;
using System.Collections.Generic;
using System.Text;

namespace Turistak
{
    public abstract class TuristaCsoport
    {
        protected TuristaCsoport(int tervezettDarab)
        {
            if (tervezettDarab < 0)
            {
                throw new ArgumentOutOfRangeException("A turistaszám nem lehet negatív.");
            }

            TervezettDarab = tervezettDarab;
        }

        public int TervezettDarab { get; }
        public int TenylegesDarab { get; protected set; }

        public int TenylegesDarabSzamit(IAllapot allapot)
        {
            double szorzo = allapot.Accept(this);
            TenylegesDarab = (int)(TervezettDarab * szorzo);
            return TenylegesDarab;
        }

        public long Bevetel()
        {
            return Varos.TurisztikaiBevetel(TenylegesDarab);
        }

        public abstract int Romlas();
        public abstract double Visit(JoAllapot allapot);
        public abstract double Visit(AtlagosAllapot allapot);
        public abstract double Visit(LepusztultAllapot allapot);
    }

    public class JapanTuristaCsoport : TuristaCsoport
    {
        public JapanTuristaCsoport(int tervezettDarab) : base(tervezettDarab) { }

        public override int Romlas() => 0;

        public override double Visit(JoAllapot allapot) => 1.2;
        public override double Visit(AtlagosAllapot allapot) => 1.0;
        public override double Visit(LepusztultAllapot allapot) => 0.0;
    }
    public class NyugatiTuristaCsoport : TuristaCsoport
    {
        public NyugatiTuristaCsoport(int tervezettDarab) : base(tervezettDarab) { }

        public override int Romlas() => this.TenylegesDarab / 100;

        public override double Visit(JoAllapot allapot) => 1.3;
        public override double Visit(AtlagosAllapot allapot) => 1.1;
        public override double Visit(LepusztultAllapot allapot) => 1.0;
    }
    public class EgyebTuristaCsoport : TuristaCsoport
    {
        public EgyebTuristaCsoport(int tervezettDarab) : base(tervezettDarab) { }

        public override int Romlas() => this.TenylegesDarab / 50;
        public override double Visit(JoAllapot allapot) => 1.0;
        public override double Visit(AtlagosAllapot allapot) => 1.1;
        public override double Visit(LepusztultAllapot allapot) => 1.0;
    }
}
