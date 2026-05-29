-module(jobserver_distr).
%% jobserver, -define, request, result, upgrade
%% Server interface
-export([start/1, stop/0, upgrade/0]).
%% Server callback
-export([init/1, loop/2]).
%% Client interface
-export([request/3, reply/1]).

-define(SRV, {?MODULE, 'server@MacBook-Pro'}).
%-define(debug, true).
%-undef(debug).
-ifdef(debug).
-define(DBG(X), io:format("Value ~p: ~p~n", [??X, X])).
-else.
-define(DBG(X), ok).
-endif.

%% Server interface
start(JobsNum) ->
    ?DBG(JobsNum),
    register(?MODULE, spawn_link(?MODULE, init, [JobsNum])).

stop() ->
    ?SRV ! stop.

upgrade() ->
    ?SRV ! upgrade.

%% Server callback
init(JobN) -> 
    process_flag(trap_exit, true),
    ?MODULE:loop(JobN, #{}).

loop(JobN, State) ->
    receive
        {job, Ref, {M,F,A}} ->
            Pid = spawn_link(fun() -> ?SRV ! {result, self(), Ref, apply(M, F, A)} end),
            loop(JobN, State#{Ref => not_ready, Pid => Ref});
        {result, Pid, Ref, Result} ->
            Remove = maps:remove(Pid, State),
            loop(JobN, Remove#{Ref=>Result});
        {reply, Ref, From} when is_map_key(Ref, State) ->
            #{Ref:=Value} = State,
            From ! {value, Ref, Value},
            loop(JobN, State);
        stop ->
            Log = "Server terminated",
            ?DBG(Log);
        {'EXIT', FailingPid, Reason} when Reason /= normal, is_map_key(FailingPid, State) ->
            ?DBG(FailingPid),
            #{FailingPid := Ref} = State,
            Remove = maps:remove(FailingPid, State),
            loop(JobN, Remove#{Ref=>failed});
        upgrade ->
            ?MODULE:loop(JobN, State);
        OtherMsg -> 
            ?DBG(OtherMsg),
            loop(JobN, State)
    end.

%% Client interface
request(Mod, Fun, Args) ->
    ?SRV ! {job, Ref = make_ref(), {Mod, Fun, Args}},
    Ref.

reply(JobRef) ->
    timer:sleep(500),
    ?SRV ! {reply, JobRef, self()},
    receive
        {value, JobRef, Result} -> Result
    after
        5000 -> request_failed
    end.

% [spawn(fun() -> Result = jobserver_distr:reply(jobserver_distr:request(lists, seq, [1,N])), io:format("~p: ~p~n", [self(), Result]) end) || N <- lists:seq(1, 10)].
