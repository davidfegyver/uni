using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TextFile;

namespace Depression
{
    internal class Infile
    {
        private readonly TextFileReader reader;

        public record Triple
        {
            public double prev, centre, next;
            public int serial;
        }

        public Triple current { get; private set; }

        public Infile(string fname)
        {
            current = new Triple();
            reader = new(fname);
            reader.ReadDouble(out current.centre);
            reader.ReadDouble(out current.next);
            current.serial = 1;
        }
        public bool Read()
        {
            if (!reader.ReadDouble(out double hight)) return false;
            current.prev = current.centre;
            current.centre = current.next;
            current.next = hight;
            ++current.serial;
            return true;
        }
    }
}
