//Author:   Gregorics Tibor
//Date:     2021.11.15.
//Title:    class of controllers

using StateMachine;
using System;
using System.Threading;

namespace Garagegate
{
    class Controller
    {
        public Engine Engine { get; private set; }
        public void Connect(Engine engine)
        {
            Engine = engine;
        }

        public void Control()
        {
            MenuWrite();
            Console.WriteLine($"gate is closed, current length: 5");
            int v;
            do
            {
                v = int.Parse(Console.ReadLine());  // ellenőrzés kell még

                switch (v)
                {
                    case 0: Engine.Send(Final.Instance()); 
                            Engine.Sensor.Send(Final.Instance());
                            Console.WriteLine("end"); 
                            break;
                    case 1: Engine.Send(Open.Instance());
                            Console.WriteLine("open");
                            break;
                    case 2: Engine.Send(Close.Instance());
                            Console.WriteLine("close");
                            break;
                    case 3: Engine.Send(Stop.Instance());
                            Console.WriteLine("stop");
                            break;
                }
            } while (v != 0);
            Console.WriteLine("   gate is over");
        }

        private static void MenuWrite()
        {
            Console.WriteLine("Menupoints:");
            Console.WriteLine("0 - exit");
            Console.WriteLine("1 - up");
            Console.WriteLine("2 - down");
            Console.WriteLine("3 - stop");
        }
    }
}
