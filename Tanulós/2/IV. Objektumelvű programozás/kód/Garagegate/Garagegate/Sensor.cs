//Author:   Gregorics Tibor
//Date:     2021.11.15.
//Title:    class of sensor

using System;
using System.Diagnostics;
using System.Threading;
using StateMachine;

namespace Garagegate
{
    class Sensor : StateMachine.StateMachine
    {
        public Engine Engine { get; private set; }

        public SensorState CurrentState
        {
            get { return (SensorState)currentState; }
        }

        public Sensor() : base()
        {
            currentState = Passive.Instance(this);
            Start();
        }

        public void Connect(Engine engine)
        {
            Engine = engine;
        }

    }

    abstract class SensorState : State
    {
        protected Sensor sensor;
        protected SensorState(Sensor s) { sensor = s; }
        public virtual State Transition(Activate signal) { return this; }
        public virtual State Transition(Deactivate signal) { return this; }
        
    }
    class Active : SensorState
    {
        private static Active instance = null;
        private Active(Sensor s) : base(s) { }

        public static Active Instance(Sensor s)
        {
            instance ??= new Active(s);
            instance.StartActivity();
            return instance; 
        }

        private readonly Random rand = new();
        private bool awake;

        protected override void StartActivity()
        {
            awake = true;
            base.StartActivity();
        }
        protected override void Activity()
        {
            Console.WriteLine("sensor is active");
            awake = true;
            while (awake)
            {
                if (rand.Next() % 100 < 15)
                {
                    sensor.Engine.Send(Blockage.Instance());
                }
                Thread.Sleep(500);
            }
        }
        public override void StopActivity()
        {
            awake= false;
            base.StopActivity();
            Console.WriteLine("sensor is passive");
        }

        public override State Transition(Deactivate signal)
        {
            StopActivity();
            return Passive.Instance(sensor);
        }

    }

    class Passive : SensorState
    {
        private static Passive instance = null;
        private Passive(Sensor s) : base(s) { }

        public static Passive Instance(Sensor s)
        {
            instance ??= new Passive(s);
            return instance;
        }

        public override State Transition(Activate signal)
        {
            return Active.Instance(sensor);
        }
    }
}
