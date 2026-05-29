//Author:   Gregorics Tibor
//Date:     2024.05.15.
//Title:    class of statemachine

using System.Diagnostics;
using System.Threading;

namespace StateMachine
{
    public abstract class State 
    {
        private Thread thread;

        protected virtual void StartActivity()
        {
            thread = new (new ThreadStart(Activity));
            thread.Start();
        }
        protected virtual void Activity() { }

        public virtual void StopActivity()
        {
            thread.Join();
        }
    }

    public interface ISignal
    {
        State Transition(State state) { return state; }
    }

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

    public class InvalidStateException:System.Exception { }
    public abstract class StateMachine
    {
        protected State currentState;
        
        private readonly Thread thread;
        private readonly EventQueue<ISignal> eventQueue = new ();

        public StateMachine()
        {
            thread = new Thread(new ThreadStart(StateMachineProcess));
        }
        public void Start()
        {
            thread.Start();
        }
        public void Send(ISignal signal)
        {
            eventQueue.Enqueue(signal);
        }

        protected void StateMachineProcess()
        {
            while (true)
            {
                try
                {
                    ISignal signal = eventQueue.Dequeue();
                    if (signal.Equals(Final.Instance())) break;
                    currentState = signal.Transition(currentState);
                }
                catch (System.InvalidOperationException) { }
            }
        }

        public void Stop()
        {
            Send(Final.Instance());
            thread.Join();
        }
    }
}
