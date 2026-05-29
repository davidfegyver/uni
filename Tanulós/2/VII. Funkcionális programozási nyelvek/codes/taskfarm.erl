-module(taskfarm).

run(F, L) ->
    WorkerNum = erlang:system_info(logical_processors_available),
    Disp = spawn(fun() -> dispatcher(L) end),
    Coll = spawn(fun() -> collector([]) end),
    Worker = fun() -> worker(F, Disp, Coll) end,
    WorkerPids = [spawn(Worker) || _ <- lists:seq(1, WorkerNum)],
    Sup = spawn_link(fun() -> supervisor_init(WorkerPids, Worker) end),
    {Coll, Sup}.

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
        {result, Data, Value} -> collector([{Data, Value} | Result]);
        {give_me, From} ->
            From ! {subresult, Result},
            collector(Result)
    end.

dispatcher([E | Es]) ->
    receive
        {free, WPid} -> 
            WPid ! {data, E},
            dispatcher(Es)
    end;
dispatcher([]) ->
    io:format("All input sent~n").

worker(F, Disp, Coll) ->
    Disp ! {free, self()},
    receive
        {data, Data} -> 
            Coll ! {result, Data, F(Data)}, 
            worker(F, Disp, Coll)
    end.