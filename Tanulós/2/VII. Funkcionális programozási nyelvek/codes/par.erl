-module(par).

%% !: asszinkron, nem ad hibat nem letezo folyamatra
%% receive: blokkol, szelektiv, FIFO
%% 
ring(N) ->
    Last = lists:foldl(fun(_, Prev) -> 
        spawn(fun() -> receive ok -> Prev ! ok end end)
    end, self(), lists:seq(1, N)),
    Last ! ok,
    receive
        ok -> finished
    end.

seqmap(F, L) ->
    [F(E) || E <- L]. %% apply(F, E)

parmap(F, L) ->
    Main = self(),
    [spawn(fun() -> Main ! F(E) end) || E <- L],
    [receive A -> A end || _ <- L].

ordparmap(F, L) ->
    Main = self(),
    Pids = [spawn(fun() -> Main ! {self(), F(E)} end) || E <- L],
    [receive {Pid, A} -> A end || Pid <- Pids].

ordparmap2(F, L) ->
    Main = self(),
    Input = lists:enumerate(L),
    [spawn(fun() -> Main ! {I, F(E)} end) || {I, E} <- Input],
    [receive {I, A} -> A end || {I, _} <- Input].

ordparmap1(F, L) ->
    Main = self(),
    [spawn(fun() -> Main ! {E, F(E)} end) || E <- L],
    [receive {E, A} -> A end || E <- L].

% A:  B ! ok, C ! nok
% C: receive nok -> B ! nok end, 
% 
% Last login: Wed Mar 11 10:43:38 on ttys003
% melindatoth@MacBook-Pro ~ % cd Desktop/fp2 
% melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> processes().
% [<0.0.0>,<0.1.0>,<0.2.0>,<0.3.0>,<0.4.0>,<0.5.0>,<0.6.0>,
%  <0.7.0>,<0.8.0>,<0.11.0>,<0.43.0>,<0.45.0>,<0.46.0>,
%  <0.47.0>,<0.49.0>,<0.50.0>,<0.51.0>,<0.52.0>,<0.53.0>,
%  <0.55.0>,<0.56.0>,<0.57.0>,<0.58.0>,<0.59.0>,<0.60.0>,
%  <0.61.0>,<0.62.0>,<0.63.0>,<0.64.0>|...]
% 2> observer:start().
% ok
% 3> self().
% <0.87.0>
% 4> length([]).
% 0
% 5> self().
% <0.87.0>
% 6> length(alma).
% ** exception error: bad argument
%      in function  length/1
%         called as length(alma)
%         *** argument 1: not a list
% 7> self().
% <0.13934.0>
% 8> Fun = fun() -> io:format("Mypid: ~p~n", [self()]) end.
% #Fun<erl_eval.43.113135111>
% 9> Fun().
% Mypid: <0.13934.0>
% ok
% 10> apply(Fun, []).
% Mypid: <0.13934.0>
% ok
% 11> io:format("Mypid: ~p~n", [self()]).
% Mypid: <0.13934.0>
% ok
% 12> 1/0.
% ** exception error: an error occurred when evaluating an arithmetic expression
%      in operator  '/'/2
%         called as 1 / 0
% 13> Fun().
% Mypid: <0.18153.0>
% ok
% 14> apply(Fun, []).
% Mypid: <0.18153.0>
% ok
% 15> spawn(Fun).
% Mypid: <0.19939.0>
% <0.19939.0>
% 16> [apply(Fun) || _ <- lists:seq(1, 1000)].
% ** exception error: undefined shell command apply/1
% 17> [apply(Fun, []) || _ <- lists:seq(1, 1000)].
% Mypid: <0.22841.0>
% Mypid: <0.22841.0>
% Mypid: <0.22841.0>
% ....

% 17> [apply(Fun, []) || _ <- lists:seq(1, 10000000)].

% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% *** ERROR: Shell process terminated! ***
% =ERROR REPORT==== 11-Mar-2026::13:01:15.309511 ===
% Too many processes


% =ERROR REPORT==== 11-Mar-2026::13:01:15.309533 ===
% Error in process <0.56623191.0> with exit value:
% {system_limit,[{erlang,spawn_link,
%                        [erlang,apply,[#Fun<shell.1.25725971>,[]]],
%                        [{error_info,#{module => erl_erts_errors}}]},
%                {erlang,spawn_link,1,[]},
%                {shell,get_command,6,[{file,"shell.erl"},{line,459}]},
%                {shell,server_loop,8,[{file,"shell.erl"},{line,338}]}]}

% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% *** ERROR: Shell process terminated! ***
% =ERROR REPORT==== 11-Mar-2026::13:01:15.353500 ===
% Too many processes


% =ERROR REPORT==== 11-Mar-2026::13:01:15.353518 ===
% Error in process <0.59768902.0> with exit value:
% {system_limit,[{erlang,spawn_link,
%                        [erlang,apply,[#Fun<shell.1.25725971>,[]]],
%                        [{error_info,#{module => erl_erts_errors}}]},
%                {erlang,spawn_link,1,[]},
%                {shell,get_command,6,[{file,"shell.erl"},{line,459}]},
%                {shell,server_loop,8,[{file,"shell.erl"},{line,338}]}]}


% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> erlang:system_info(process_limit).
% 1048576
% 2> erlang:system_info(process_count).
% 48
% 3> 
% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl +P 100000000
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> erlang:system_info(process_limit).
% 134217727
% 2> timer:tc(par, ring, [10000000]).
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% {19169277,finished}
% 3> timer:tc(par, ring, [1000000]).
% {1154419,finished}
% 4> c(par, [export_all]).
% {ok,par}
% 5> par:seqmap(fun(X) -> X + 1 end, [1,2,3,4,5]).
% [2,3,4,5,6]
% 6> par:parmap(fun(X) -> X + 1 end, [1,2,3,4,5]).
% [<0.11000098.0>,<0.11000099.0>,<0.11000100.0>,
%  <0.11000101.0>,<0.11000102.0>]
% 7> self() ! ok.
% ok
% 8> flush().
% Shell got ok
% ok
% 9> self() ! ok.
% ok
% 10> self() ! ok.
% ok
% 11> self() ! ok.
% ok
% 12> flush().
% Shell got ok
% Shell got ok
% Shell got ok
% ok
% 13> c(par, [export_all]).
% {ok,par}
% 14> par:parmap(fun(X) -> X + 1 end, [1,2,3,4,5]).
% [<0.11000115.0>,<0.11000116.0>,<0.11000117.0>,
%  <0.11000118.0>,<0.11000119.0>]
% 15> flush().
% ok
% 16> c(par, [export_all]).
% {ok,par}
% 17> par:parmap(fun(X) -> X + 1 end, [1,2,3,4,5]).
% [<0.11000127.0>,<0.11000128.0>,<0.11000129.0>,
%  <0.11000130.0>,<0.11000131.0>]
% 18> flush().
% Shell got 3
% Shell got 2
% Shell got 6
% Shell got 4
% Shell got 5
% ok
% 19> c(par, [export_all]).
% {ok,par}
% 20> par:parmap(fun(X) -> X + 1 end, [1,2,3,4,5]).
% [2,3,4,5,6]
% 21> par:parmap(fun(X) -> X + 1 end, [1,2,3,4,5,4,3,2,1,2,3,34]).
% [2,3,4,5,6,5,4,3,2,3,4,35]
% 22> par:parmap(fun(X) -> X + 1 end, lists:seq(1,100)).
% [2,3,53,4,5,54,6,55,7,56,8,9,57,10,11,12,81,58,13,82,14,83,
%  84,85,86,87,88,89,90|...]
% 23> self() ! 1.
% 1
% 24> self() ! 2.
% 2
% 25> self() ! 3.
% 3
% 26> flush().
% Shell got 1
% Shell got 2
% Shell got 3
% ok
% 27> c(par, [export_all]).
% {ok,par}
% 28> par:ordparmap(fun(X) -> X + 1 end, lists:seq(1,100)).
% [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,
%  24,25,26,27,28,29,30|...]
% 29> lists:enumerate([a,b,c]).
% [{1,a},{2,b},{3,c}]
% 30> c(par, [export_all]).
% {ok,par}
% 31> par:ordparmap(fun(X) -> X + 1 end, lists:seq(1,100)).
% [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,
%  24,25,26,27,28,29,30|...]
% 32> make_ref().
% #Ref<0.2978355286.1283194883.230453>
% 33> pid(0, 12, 0).
% <0.12.0>
% 34> pid(0, 12, 0).
% <0.12.0>
% 35> make_ref().
% #Ref<0.2978355286.1283194883.230484>
% 36> make_ref().
% #Ref<0.2978355286.1283194881.231197>
% 37> make_ref().
% #Ref<0.2978355286.1283194881.231211>
% 38> 
