//Author:   Gregorics Tibor
//Date:     2021.11.15.
//Title:    class of gates

using System;

namespace Garagegate
{
    class Gate
    {
        public Engine Engine { get; private set; }

        private readonly int maxLength;
        private int currentLength;

        public Gate(int m)
        {
            maxLength = m;
            currentLength = m;
        }

        public void Connect(Engine engine)
        {
            Engine = engine;
        }

        public void Openning()
        {
            if (currentLength > 0) --currentLength;
            if (0 == currentLength) Engine.Send(Coiled.Instance());
            Console.WriteLine($"gate is rising, current length: {currentLength}");
        }

        public void Closing()
        {
            if (currentLength < maxLength) ++currentLength;
            if (maxLength == currentLength) Engine.Send(Unrolled.Instance());
            Console.WriteLine($"gate is descending, current length: {currentLength}");
        }
    }
}
