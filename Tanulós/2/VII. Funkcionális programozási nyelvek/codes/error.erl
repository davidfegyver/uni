-module(error).

ordparmap(F, L) ->
    Main = self(),
    PidRefs = [spawn_monitor(fun() -> Main ! {value, self(), F(E)} end) || E <- L],
    recv(PidRefs).

recv([]) -> [];
recv([{Pid, Ref} | PidRefs]) ->
    receive 
        {'DOWN', Ref, _, _, Reason} when Reason /= normal -> recv(PidRefs); 
        {'DOWN', _, _, _, normal} -> recv([{Pid, Ref} | PidRefs]);
        {value, Pid, A} -> [A | recv(PidRefs)] 
    end.

parmap(F, L) ->
    Main = self(),
    [spawn_monitor(fun() -> Main ! {value, F(E)} end) || E <- L],
    [receive 
        {'DOWN', _, _, _, Reason} when Reason/= normal -> error; 
        {value, A} -> A 
    end || _ <- L].