//Author:   Gregorics Tibor
//Date:     2021.11.15.
//Title:    class of engine

using System;
using System.Threading;
using StateMachine;

namespace Garagegate
{
    class Engine : StateMachine.StateMachine
    {
        public Gate Gate { get; private set; }
        public Sensor Sensor { get; private set; }

        public EngineState CurrentState
        {
            get { return (EngineState)currentState; }
        }

        public Engine():base()
        {
            currentState = Unmove.Instance(this);
            Start();
        }

        public void Connect(Gate gate, Sensor sensor)
        {
            Gate = gate;
            Sensor = sensor;
        }
    }

    abstract class EngineState : State
    {
        protected Engine engine;
        protected EngineState(Engine e) { engine = e; }
        public virtual State Transition(Open signal) { return this; }
        public virtual State Transition(Close signal) { return this; }
        public virtual State Transition(Stop signal) { return this; }
        public virtual State Transition(Unrolled signal) { return this; }
        public virtual State Transition(Coiled signal) { return this; }
        public virtual State Transition(Blockage signal) { return this; }

    }

    class Upward : EngineState
    {
        private static Upward instance = null;
        private Upward(Engine e) : base(e) { }
        public static Upward Instance(Engine e)
        {
            instance ??= new Upward(e);
            instance.StartActivity();
            return instance;
        }

        private bool moving;

        protected override void StartActivity()
        {
            moving = true;
            base.StartActivity();
        }
        protected override void Activity()
        {
            while (moving)
            {
                engine.Gate.Openning();
                Thread.Sleep(500);
            }
        }
        public override void StopActivity()
        {
            moving = false;
            base.StopActivity();
        }

        public override State Transition(Close signal)
        {
            StopActivity(); 
            return Downward.Instance(engine);
        }

        public override State Transition(Stop signal)
        {
            Console.WriteLine("stopped");
            StopActivity(); 
            engine.Sensor.Send(Deactivate.Instance());
            return Unmove.Instance(engine);
        }

        public override State Transition(Coiled signal) 
        {
            Console.WriteLine("coiled");
            StopActivity(); 
            engine.Sensor.Send(Deactivate.Instance()); 
            return Unmove.Instance(engine); 
        }

        public override State Transition(Blockage signal)
        {
            Console.WriteLine("blockage");
            StopActivity();
            engine.Sensor.Send(Deactivate.Instance());
            return Unmove.Instance(engine);
        }
    }

    class Downward : EngineState
    {
        private static Downward instance = null;
        private Downward(Engine e) : base(e) { }
        public static Downward Instance(Engine s)
        {
            instance ??= new Downward(s);
            instance.StartActivity();
            return instance;
        }

        private bool moving;

        protected override void StartActivity()
        {
            moving = true;
            base.StartActivity();
        }
        protected override void Activity()
        {
            while (moving)
            {
                engine.Gate.Closing();
                Thread.Sleep(500);
            }
        }
        public override void StopActivity()
        {
            moving = false;
            base.StopActivity();
        }

        public override State Transition(Open signal)
        {
            StopActivity(); 
            return Upward.Instance(engine);
        }
        public override State Transition(Stop signal)
        {
            Console.WriteLine("stopped"); 
            StopActivity();
            engine.Sensor.Send(Deactivate.Instance());
            return Unmove.Instance(engine);
        }
        public override State Transition(Unrolled signal)
        {
            Console.WriteLine("unrolled"); 
            StopActivity();
            engine.Sensor.Send(Deactivate.Instance());
            return Unmove.Instance(engine);
        }
        public override State Transition(Blockage signal)
        {
            Console.WriteLine("blockage");
            StopActivity();
            engine.Sensor.Send(Deactivate.Instance());
            return Unmove.Instance(engine);
        }
    }

    class Unmove : EngineState
    {
        private static Unmove instance = null;
        private Unmove(Engine e) : base(e) { }
        public static Unmove Instance(Engine s)
        {
            instance ??= new Unmove(s);
            return instance;
        }

        public override State Transition(Open signal) 
        {
            engine.Sensor.Send(Activate.Instance());
            return Upward.Instance(engine); 
        }

        public override State Transition(Close signal) 
        {
            engine.Sensor.Send(Activate.Instance());
            return Downward.Instance(engine);
        }
    }
}
