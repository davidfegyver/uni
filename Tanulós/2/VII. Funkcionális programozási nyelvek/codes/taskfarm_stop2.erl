-module(taskfarm_stop2).

run(F, L) ->
    WorkerNum = erlang:system_info(logical_processors_available),
    Disp = spawn(fun() -> dispatcher(L, WorkerNum) end),
    Coll = spawn(fun() -> collector([]) end),
    Worker = fun() -> worker(F, Disp, Coll) end,
    WorkerPids = [spawn(Worker) || _ <- lists:seq(1, WorkerNum)],
    Sup = spawn_link(fun() -> supervisor_init(WorkerPids, Worker) end),
    {Coll, Disp}.

supervisor_init(WorkerPids, Worker) ->
    process_flag(trap_exit, true),
    [link(W) || W <- WorkerPids],
    supervisor(Worker).

supervisor(Worker) ->
    receive
        {'EXIT', _Pid, Reason} when Reason/=normal->
            spawn_link(Worker),
            supervisor(Worker)
    end. 

collector(Result) ->
    receive
        stop -> io:format("Collector terminated~n. Result: ~p~n", [Result]);
        {result, Data, Value} -> collector([{Data, Value} | Result]);
        {give_me, From} ->
            From ! {subresult, Result},
            collector(Result)
    end.

dispatcher([E | Es], N) ->
    receive
        {free, WPid} -> 
            WPid ! {data, E},
            dispatcher(Es, N)
    end;
dispatcher([], 0) ->    
    io:format("Dispatcher terminated~n");
dispatcher([], N) ->
    receive
        {free, WPid} ->
            WPid ! stop,
            dispatcher([], N-1)
    end.


worker(F, Disp, Coll) ->
    Disp ! {free, self()},
    receive
        stop -> 
            io:format("Worker terminated: ~p~n", [self()]);
        {data, Data} -> 
            Coll ! {result, Data, F(Data)}, 
            worker(F, Disp, Coll)
    end.