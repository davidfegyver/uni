//Author:   Gregorics Tibor
//Date:     2021.11.15.
//Title:    class of garage gates

namespace Garagegate
{
    class Garagegate
    {
        public readonly Engine engine = new();
        public readonly Sensor sensor = new();
        public readonly Gate gate = new(5);
        private readonly Controller controller = new();

        public Garagegate()
        {
            engine.Connect(gate, sensor);
            sensor.Connect(engine);
            gate.Connect(engine);
            controller.Connect(engine);
        }

        public void Process()
        {
            controller.Control();
            engine.Stop();
            sensor.Stop();
        }
    }
}
