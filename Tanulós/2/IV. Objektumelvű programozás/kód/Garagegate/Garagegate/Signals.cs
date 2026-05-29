//Author:   Gregorics Tibor
//Date:     2021.11.15.
//Title:    signals

using StateMachine;
using System;

namespace Garagegate
{
//    public enum Signal { final, up, down, stop, unrolled, coiled, blockage, activate, deactivate };

    public class UnknownSignalException : Exception {}

    public class Final : ISignal
    {
        private static Final instance = null;
        private Final() { }
        public static Final Instance()
        {
            instance ??= new Final();
            return instance;
        }
    }

    public class Open : ISignal
    {
        private static Open instance = null;
        private Open() { }

        public static Open Instance()
        {
            instance ??= new Open();
            return instance;
        }

        public State Transition(State state)
        {
            return (state as EngineState).Transition(this);
        }
    }

    public class Close : ISignal
    {
        private static Close instance = null;
        private Close() { }
        public static Close Instance()
        {
            instance ??= new Close();
            return instance;
        }

        public State Transition(State state)
        {
            return (state as EngineState).Transition(this);
        }
    }

    public class Stop : ISignal
    {
        private static Stop instance = null;
        private Stop() { }
        public static Stop Instance()
        {
            instance ??= new Stop();
            return instance;
        }

        public State Transition(State state)
        {
            return (state as EngineState).Transition(this);
        }
    }

    public class Unrolled : ISignal
    {
        private static Unrolled instance = null;
        private Unrolled() { }
        public static Unrolled Instance()
        {
            instance ??= new Unrolled();
            return instance;
        }

        public State Transition(State state)
        {
            return (state as EngineState).Transition(this);
        }
    }

    public class Coiled : ISignal
    {
        private static Coiled instance = null;
        private Coiled() { }
        public static Coiled Instance()
        {
            instance ??= new Coiled();
            return instance;
        }

        public State Transition(State state)
        {
            return (state as EngineState).Transition(this);
        }
    }

    public class Blockage : ISignal
    {
        private static Blockage instance = null;
        private Blockage() { }
        public static Blockage Instance()
        {
            instance ??= new Blockage();
            return instance;
        }

        public State Transition(State state)
        {
           return (state as EngineState).Transition(this);
        }
    }

    public class Activate : ISignal
    {
        private static Activate instance = null;
        private Activate() { }
        public static Activate Instance()
        {
            instance ??= new Activate();
            return instance;
        }

        public State Transition(State state)
        {
            return (state as SensorState).Transition(this);
        }
    }

    public class Deactivate : ISignal
    {
        private static Deactivate instance = null;
        private Deactivate() { }
        public static Deactivate Instance()
        {
            instance ??= new Deactivate();
            return instance;
        }

        public State Transition(State state)
        {
            return (state as SensorState).Transition(this);
        }
    }

}
