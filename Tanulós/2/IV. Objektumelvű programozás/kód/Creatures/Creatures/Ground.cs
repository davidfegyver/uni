//Author:   Gregorics Tibor
//Date:     2021.11.13.
//Title:    abstract and concrete classes of ground 

using TextFile;

namespace Creatures
{
    enum G { sand = 0, grass = 1, marsh = 2 }
    // class of abstract grounds
    interface IGround
    {
        IGround Change(DuneBeetle p);
        IGround Change(Squelchy p);
        IGround Change(Greenfinch p);
    }

     // class of grass

    class Grass : IGround
    {

        public IGround Change(DuneBeetle p)
        {
            p.ModifyPower(-2);
            return Sand.Instance();
        }
        public IGround Change(Squelchy p)
        {
            p.ModifyPower(-2);
            return Marsh.Instance();
        }
        public IGround Change(Greenfinch p)
        {
            p.ModifyPower(1);
            return this;
        }
        private Grass() { }

        private static Grass instance = null;
        public static Grass Instance()
        {
            instance ??= new Grass();
            return instance;
        }
    }

    // class of sand
    class Sand : IGround
    {
        public IGround Change(Greenfinch p)
        {
            p.ModifyPower(-2);
            return this;
        }
        public IGround Change(DuneBeetle p)
        {
            p.ModifyPower(3);
            return this;
        }
        public IGround Change(Squelchy p)
        {
            p.ModifyPower(-5);
            return this;
        }

        private Sand() { }

        private static Sand instance = null;
        public static Sand Instance()
        {
            instance ??= new Sand();
            return instance;
        }
    }

    // class of marsh

    class Marsh : IGround
    {
        public IGround Change(Greenfinch p)
        {
            p.ModifyPower(-1);
            return Grass.Instance();
        }
        public IGround Change(DuneBeetle p)
        {
            p.ModifyPower(-4);
            return Grass.Instance();
        }
        public IGround Change(Squelchy p)
        {
            p.ModifyPower(6);
            return this;
        }

        private Marsh() { }

        private static Marsh instance = null;
        public static Marsh Instance()
        {
            instance ??= new Marsh();
            return instance;
        }
    }
}
