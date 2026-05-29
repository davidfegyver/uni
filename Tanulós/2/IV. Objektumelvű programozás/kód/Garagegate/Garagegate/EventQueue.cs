//Author:   Gregorics Tibor
//Date:     2023.01.03.
//Title:    class of threadsafe queues


using System.Collections.Generic;
using System.Threading;

namespace StateMachine
{
	class EventQueue <ISignal>
    {
		private readonly Queue<ISignal> queue = new ();
		private readonly object criticalSection = new (); 

		public bool Empty()
		{
			return queue.Count == 0;
		}

		public void Enqueue(ISignal e)
		{
			Monitor.Enter(criticalSection);
			queue.Enqueue(e);
			Monitor.Pulse(criticalSection); 
			Monitor.Exit(criticalSection);
		}

        public ISignal Dequeue()
        {
            ISignal e;
            Monitor.Enter(criticalSection);
            if (queue.Count==0) Monitor.Wait(criticalSection);
			e = queue.Peek();
            queue.Dequeue();
            Monitor.Exit(criticalSection);
            return e;
        }

    }
}

