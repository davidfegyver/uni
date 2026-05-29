-module(jobserver).
%% jobserver, -define, request, result, upgrade
%% Server interface
-export([start/1, stop/0, upgrade/0]).
%% Server callback
-export([init/1, loop/2]).
%% Client interface
-export([request/3, reply/1]).

-define(SRV, jobsrv).
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
    register(?SRV, spawn_link(?MODULE, init, [JobsNum])).

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
    ?SRV ! {reply, JobRef, self()},
    receive
        {value, JobRef, Result} -> Result
    after
        5000 -> request_failed
    end.

% -define(NAME, foo() -> ).
% -define(CONT, 1 ; foo() -> ).
% -define(DOT, 2).

% ?NAME ?CONT ?DOT.

% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(jobserver).
% jobserver.erl:6:1: Warning: function start/0 is unused
% %    6| start() ->
% %     | ^

% jobserver.erl:9:1: Warning: function request/0 is unused
% %    9| request() ->
% %     | ^

% {ok,jobserver}
% 2> c(jobserver).
% jobserver.erl:7:15: undefined macro 'SRuV'
% %    7|     register(?SRuV, spawn(fun() -> ok end)).
% %     |               ^

% jobserver.erl:9:1: Warning: function request/0 is unused
% %    9| request() ->
% %     | ^

% error
% 3> c(jobserver).
% jobserver.erl:3:2: function start/1 undefined
% %    3| -export([start/1]).
% %     |  ^

% jobserver.erl:13:1: Warning: function request/0 is unused
% %   13| request() ->
% %     | ^

% error
% 4> c(jobserver).
% jobserver.erl:13:1: Warning: function request/0 is unused
% %   13| request() ->
% %     | ^

% {ok,jobserver}
% 5> jobserver:start(23).
% Value "JobsNum": 23
% true
% 6> jobserver:start(23).
% Value "JobsNum": 23
% true
% 7> c(jobserver).
% jobserver.erl:13:7: Warning: variable 'JobsNum' is unused
% %   13| start(JobsNum) ->
% %     |       ^

% jobserver.erl:17:1: Warning: function request/0 is unused
% %   17| request() ->
% %     | ^

% {ok,jobserver}
% 8> c(jobserver, []).
% jobserver.erl:17:1: Warning: function request/0 is unused
% %   17| request() ->
% %     | ^

% {ok,jobserver}
% 9> c(jobserver, []).
% jobserver.erl:14:7: Warning: variable 'JobsNum' is unused
% %   14| start(JobsNum) ->
% %     |       ^

% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% {ok,jobserver}
% 10> c(jobserver, [{d, debug}]).
% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% {ok,jobserver}
% 11> c(jobserver, [{u, debug}]).
% jobserver.erl:14:7: Warning: variable 'JobsNum' is unused
% %   14| start(JobsNum) ->
% %     |       ^

% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% {ok,jobserver}
% 12> c(jobserver, [{d, debug}]).
% jobserver.erl:25:12: syntax error before: '.'
% %   25| ?NAME?CONT?DOT.
% %     |            ^

% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% error
% 13> c(jobserver, [{d, debug}]).
% jobserver.erl:25:12: syntax error before: '.'
% %   25| ?NAME?CONT?DOT.
% %     |            ^

% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% error
% 14> c(jobserver, [{d, debug}]).
% jobserver.erl:25:14: syntax error before: '.'
% %   25| ?NAME ?CONT ?DOT.
% %     |              ^

% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% error
% 15> c(jobserver, [{d, debug}]).
% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% jobserver.erl:26:1: Warning: function foo/0 is unused
% %   26| foo() -> 1 ; foo() -> 2.
% %     | ^

% jobserver.erl:26:14: Warning: this clause for foo/0 cannot match because a previous clause at line 26 always matches
% %   26| foo() -> 1 ; foo() -> 2.
% %     |              ^

% {ok,jobserver}
% 16> c(jobserver, [{d, debug}]).
% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% jobserver.erl:25:2: Warning: function foo/0 is unused
% %   25| ?NAME ?CONT ?DOT.
% %     |  ^

% jobserver.erl:25:8: Warning: this clause for foo/0 cannot match because a previous clause at line 25 always matches
% %   25| ?NAME ?CONT ?DOT.
% %     |        ^

% {ok,jobserver}
% 17> c(jobserver, [{d, debug}]).
% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% jobserver.erl:25:2: Warning: function foo/0 is unused
% %   25| ?NAME ?DOT.
% %     |  ^

% {ok,jobserver}
% 18> c(jobserver, [{d, debug}]).
% jobserver.erl:25:8: syntax error before: '-'
% %   25| ?NAME ?CONT ?DOT.
% %     |        ^

% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% error
% 19> c(jobserver, [{d, debug}]).
% jobserver.erl:18:1: Warning: function request/0 is unused
% %   18| request() ->
% %     | ^

% jobserver.erl:25:2: Warning: function foo/0 is unused
% %   25| ?NAME ?CONT ?DOT.
% %     |  ^

% jobserver.erl:25:8: Warning: this clause for foo/0 cannot match because a previous clause at line 25 always matches
% %   25| ?NAME ?CONT ?DOT.
% %     |        ^

% {ok,jobserver}
% 20> c(jobserver, [{d, debug}]).
% jobserver.erl:20:18: variable 'JN' is unbound, did you mean 'Jn'?
% %   20|     ?MODULE:loop(JN, #{}).
% %     |                  ^

% jobserver.erl:18:6: Warning: variable 'Jn' is unused
% %   18| init(Jn) -> 
% %     |      ^

% jobserver.erl:20:6: Warning: function jobserver:loop/2 is not exported
% %   20|     ?MODULE:loop(JN, #{}).
% %     |      ^

% jobserver.erl:22:1: Warning: function loop/2 is unused
% %   22| loop(JN, State) ->
% %     | ^

% jobserver.erl:27:18: Warning: variable 'Pid' is unused
% %   27|         {'EXIT', Pid, Reason} ->
% %     |                  ^

% jobserver.erl:27:23: Warning: variable 'Reason' is unused
% %   27|         {'EXIT', Pid, Reason} ->
% %     |                       ^

% jobserver.erl:30:14: Warning: function jobserver:loop/2 is not exported
% %   30|             ?MODULE:loop(JN, State)
% %     |              ^

% jobserver.erl:33:1: Warning: function request/0 is unused
% %   33| request() ->
% %     | ^

% error
% 21> c(jobserver, [{d, debug}]).
% jobserver.erl:20:6: Warning: function jobserver:loop/2 is not exported
% %   20|     ?MODULE:loop(JobN, #{}).
% %     |      ^

% jobserver.erl:22:1: Warning: function loop/2 is unused
% %   22| loop(JobN, State) ->
% %     | ^

% jobserver.erl:27:18: Warning: variable 'Pid' is unused
% %   27|         {'EXIT', Pid, Reason} ->
% %     |                  ^

% jobserver.erl:27:23: Warning: variable 'Reason' is unused
% %   27|         {'EXIT', Pid, Reason} ->
% %     |                       ^

% jobserver.erl:30:14: Warning: function jobserver:loop/2 is not exported
% %   30|             ?MODULE:loop(JobN, State)
% %     |              ^

% jobserver.erl:33:1: Warning: function request/0 is unused
% %   33| request() ->
% %     | ^

% {ok,jobserver}
% 22> c(jobserver, [{d, debug}]).
% jobserver.erl:27:18: Warning: variable 'Pid' is unused
% %   27|         {'EXIT', Pid, Reason} ->
% %     |                  ^

% jobserver.erl:27:23: Warning: variable 'Reason' is unused
% %   27|         {'EXIT', Pid, Reason} ->
% %     |                       ^

% jobserver.erl:33:1: Warning: function request/0 is unused
% %   33| request() ->
% %     | ^

% {ok,jobserver}
% 23> c(jobserver, [{d, debug}]).
% jobserver.erl:8:2: function request/3 undefined, did you mean request/0?
% %    8| -export([request/3]).
% %     |  ^

% jobserver.erl:32:18: Warning: variable 'Pid' is unused
% %   32|         {'EXIT', Pid, Reason} ->
% %     |                  ^

% jobserver.erl:32:23: Warning: variable 'Reason' is unused
% %   32|         {'EXIT', Pid, Reason} ->
% %     |                       ^

% jobserver.erl:38:1: Warning: function request/0 is unused
% %   38| request() ->
% %     | ^

% error
% 24> c(jobserver, [{d, debug}]).
% jobserver.erl:32:18: Warning: variable 'Pid' is unused
% %   32|         {'EXIT', Pid, Reason} ->
% %     |                  ^

% jobserver.erl:32:23: Warning: variable 'Reason' is unused
% %   32|         {'EXIT', Pid, Reason} ->
% %     |                       ^

% jobserver.erl:38:9: Warning: variable 'Mod' is unused
% %   38| request(Mod, Fun, Args) ->
% %     |         ^

% jobserver.erl:38:14: Warning: variable 'Fun' is unused
% %   38| request(Mod, Fun, Args) ->
% %     |              ^

% jobserver.erl:38:19: Warning: variable 'Args' is unused
% %   38| request(Mod, Fun, Args) ->
% %     |                   ^

% {ok,jobserver}
% 25> c(jobserver, [{d, debug}]).
% jobserver.erl:58:8: syntax error before: '.'
% %   58|     Ref.
% %     |        ^

% jobserver.erl:8:2: function request/3 undefined
% %    8| -export([request/3]).
% %     |  ^

% jobserver.erl:49:18: Warning: variable 'Pid' is unused
% %   49|         {'EXIT', Pid, Reason} ->
% %     |                  ^

% jobserver.erl:49:23: Warning: variable 'Reason' is unused
% %   49|         {'EXIT', Pid, Reason} ->
% %     |                       ^

% jobserver.erl:60:1: Warning: function reply/1 is unused
% %   60| reply(JobRef) ->
% %     | ^

% error
% 26> c(jobserver, [{d, debug}]).
% jobserver.erl:57:47: variable 'Arg' is unbound, did you mean 'Args'?
% %   57|     ?SRV ! {job, Ref = make_ref(), {Mod, Fun, Arg}},
% %     |                                               ^

% jobserver.erl:49:18: Warning: variable 'Pid' is unused
% %   49|         {'EXIT', Pid, Reason} ->
% %     |                  ^

% jobserver.erl:49:23: Warning: variable 'Reason' is unused
% %   49|         {'EXIT', Pid, Reason} ->
% %     |                       ^

% jobserver.erl:56:19: Warning: variable 'Args' is unused
% %   56| request(Mod, Fun, Args) ->
% %     |                   ^

% jobserver.erl:60:1: Warning: function reply/1 is unused
% %   60| reply(JobRef) ->
% %     | ^

% error
% 27> c(jobserver, [{d, debug}]).
% jobserver.erl:49:18: Warning: variable 'Pid' is unused
% %   49|         {'EXIT', Pid, Reason} ->
% %     |                  ^

% jobserver.erl:49:23: Warning: variable 'Reason' is unused
% %   49|         {'EXIT', Pid, Reason} ->
% %     |                       ^

% jobserver.erl:60:1: Warning: function reply/1 is unused
% %   60| reply(JobRef) ->
% %     | ^

% {ok,jobserver}
% 28> jobserver:start(23).
% Value "JobsNum": 23
% true
% 29> Ref = jobserver:request(erlang, length, [[]]).
% #Ref<0.292147798.2097414149.88482>
% 30> c(jobserver, [{d, debug}]).
% jobserver.erl:49:18: Warning: variable 'Pid' is unused
% %   49|         {'EXIT', Pid, Reason} ->
% %     |                  ^

% jobserver.erl:49:23: Warning: variable 'Reason' is unused
% %   49|         {'EXIT', Pid, Reason} ->
% %     |                       ^

% {ok,jobserver}
% 31> jobserver:reply(Ref).
% {value,#Ref<0.292147798.2097414149.88482>,0}
% 32> c(jobserver, [{d, debug}]).
% jobserver.erl:49:18: Warning: variable 'Pid' is unused
% %   49|         {'EXIT', Pid, Reason} ->
% %     |                  ^

% jobserver.erl:49:23: Warning: variable 'Reason' is unused
% %   49|         {'EXIT', Pid, Reason} ->
% %     |                       ^

% jobserver.erl:63:17: Warning: variable 'Ref' is unused
% %   63|         {value, Ref, Result} -> Result
% %     |                 ^

% ** exception exit: killed
% 33> whereis(jobsrv).
% undefined
% 34> c(jobserver, [{d, debug}]).
% jobserver.erl:53:45: syntax error before: ','
% %   53|             Remove = maps:remove(Pid, State),
% %     |                                             ^

% jobserver.erl:6:2: function loop/2 undefined
% %    6| -export([init/1, loop/2]).
% %     |  ^

% jobserver.erl:70:17: Warning: variable 'Ref' is unused
% %   70|         {value, Ref, Result} -> Result
% %     |                 ^

% error
% 35> c(jobserver, [{d, debug}]).
% jobserver.erl:53:34: variable 'Pid' is unbound
% %   53|             Remove = maps:remove(Pid, State),
% %     |                                  ^

% jobserver.erl:70:17: Warning: variable 'Ref' is unused
% %   70|         {value, Ref, Result} -> Result
% %     |                 ^

% error
% 36> c(jobserver, [{d, debug}]).
% jobserver.erl:70:17: Warning: variable 'Ref' is unused
% %   70|         {value, Ref, Result} -> Result
% %     |                 ^

% {ok,jobserver}
% 37> c(jobserver, [{d, debug}]).
% {ok,jobserver}
% 38> jobserver:start(23).
% Value "JobsNum": 23
% true
% 39> f().
% ok
% 40> Ref.
% * 1:1: variable 'Ref' is unbound
% 41> Ref = jobserver:request(erlang, length, [[]]).
% #Ref<0.292147798.2097414149.88844>
% Value "OtherMsg": {'EXIT',<0.247.0>,normal}
% 42> jobserver:reply(Ref).
% 0
% 43> f().
% ok
% 44> Ref = jobserver:request(timer, sleep, [10000]).
% #Ref<0.292147798.2097414149.88926>
% 45> jobserver:reply(Ref).
% not_ready
% 46> jobserver:reply(Ref).
% not_ready
% Value "OtherMsg": {'EXIT',<0.251.0>,normal}
% 47> jobserver:reply(Ref).
% ok
% 48> f().
% ok
% 49> Ref = jobserver:request(timer, sleaaaep, [10000]).
% Value "FailingPid": <0.257.0>
% #Ref<0.292147798.2097414149.89020>
% =ERROR REPORT==== 15-Apr-2026::13:18:03.735500 ===
% Error in process <0.257.0> with exit value:
% {undef,[{timer,sleaaaep,[10000],[]},
%         {jobserver,'-loop/2-fun-0-',4,[{file,"jobserver.erl"},{line,38}]}]}

% 50> jobserver:reply(Ref).
% failed
% 51> jobserver:reply(make_ref()).
% =ERROR REPORT==== 15-Apr-2026::13:18:43.157403 ===
% Error in process <0.243.0> with exit value:
% {{badmatch,#{#Ref<0.292147798.2097414149.88844> => 0,
%              #Ref<0.292147798.2097414149.88926> => ok,
%              #Ref<0.292147798.2097414149.89020> => failed}},
%  [{jobserver,loop,2,[{file,"jobserver.erl"},{line,44}]}]}

% ** exception exit: {badmatch,#{#Ref<0.292147798.2097414149.88844> => 0,
%                                #Ref<0.292147798.2097414149.88926> => ok,
%                                #Ref<0.292147798.2097414149.89020> => failed}}
%      in function  jobserver:loop/2 (jobserver.erl:44)
% 52> h(erlang, is_map_key, 2).

%   -spec is_map_key(Key, Map) -> boolean() when Key :: term(), Map :: map().

% Since:
%   OTP 21.0

%   Returns true if map Map contains Key and returns false if it does not contain the Key.

%   Failure: A {badmap,Map} exception is raised if Map is not a map.

% Examples

%     > Map = #{"42" => value}.
%     #{"42" => value}
%     1> is_map_key("42", Map).
%     true
%     2> is_map_key(value, Map).
%     false
%     3> is_map_key(value, no_map).
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% more (y/n)? (y) h(erlang, is_map_key, 2).x
% more (y/n)? (y) n
% ok
% 53> c(jobserver, [{d, debug}]).
% {ok,jobserver}
% 54> f().
% ok
% 55> jobserver:reply(make_ref()).
% ** exception error: bad argument
%      in function  erlang:send/2
%         called as erlang:send(jobsrv,
%                               {reply,#Ref<0.292147798.2097414149.89310>,<0.260.0>})
%         *** argument 1: invalid destination
%      in call from jobserver:reply/1 (jobserver.erl:68)
% 56> jobserver:start(23).
% Value "JobsNum": 23
% true
% 57> jobserver:reply(make_ref()).
% Value "OtherMsg": {reply,#Ref<0.292147798.2097414149.89378>,<0.269.0>}
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                                                                                    melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(jobserver, [{d, debug}]).
% {ok,jobserver}
% 2> jobserver:start(23).
% Value "JobsNum": 23
% true
% 3> jobserver:reply(make_ref()).
% Value "OtherMsg": {reply,#Ref<0.4154980409.229638148.246465>,<0.87.0>}
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% request_failed
% 4> 1/0.
% Value "FailingPid": <0.87.0>
% =ERROR REPORT==== 15-Apr-2026::13:26:45.416978 ===
% Error in process <0.94.0> with exit value:
% {{badmatch,#{}},[{jobserver,loop,2,[{file,"jobserver.erl"},{line,52}]}]}

% ** exception error: an error occurred when evaluating an arithmetic expression
%      in operator  '/'/2
%         called as 1 / 0
% 5> c(jobserver, [{d, debug}]).
% {ok,jobserver}
% 6> jobserver:start(23).
% Value "JobsNum": 23
% true
% 7> 1/0.
% Value "OtherMsg": {'EXIT',<0.97.0>,
%                       {badarith,
%                           [{erlang,'/',
%                                [1,0],
%                                [{error_info,#{module => erl_erts_errors}}]},
%                            {erl_eval,do_apply,7,
%                                [{file,"erl_eval.erl"},{line,924}]},
%                            {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%                            {shell,eval_exprs,7,
%                                [{file,"shell.erl"},{line,893}]},
%                            {shell,eval_loop,4,
%                                [{file,"shell.erl"},{line,878}]}]}}
% Value "OtherMsg": {'EXIT',<0.97.0>,normal}
% ** exception error: an error occurred when evaluating an arithmetic expression
%      in operator  '/'/2
%         called as 1 / 0
% 8> whereis(jobsrv).
% <0.104.0>
% 9> 
