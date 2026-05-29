-module(dnc).

parfind(_, []) -> not_found;
parfind(K, [{K, Value}]) -> Value;
parfind(_, [_]) -> not_found;
parfind(K, List) ->
    Main = self(),
    {List1, List2} = lists:split(length(List) div 2, List),
    spawn(fun() -> Main ! {first, parfind(K, List1)} end),
    spawn(fun() -> Main ! {second, parfind(K, List2)} end),
    receive 
        {first, not_found} -> 
            receive 
                {second, Value} -> Value
            end;
        {first, Value} -> Value
    end.


sfib(1) -> 1;
sfib(2) -> 1;
sfib(N) -> sfib(N-1) + sfib(N-2).

sfib_dnc(N) ->
    sdnc(N, {%fun(1) -> true; (2) -> true; (_) -> false end
             %fun(X) when X =:= 1; X =:= 2 -> true; (_) -> false end
             fun(X) -> (X =:= 1) orelse (X =:= 2) end,
             fun(_) -> 1 end,
             fun(X) -> [X-1, X-2] end,
             fun lists:sum/1 %% fun([A, B]) -> A + B end
            }).

fib(N, Fun) ->
    gen_dnc(N, {fun(X) -> (X =:= 1) orelse (X =:= 2) end,
             fun(_) -> 1 end,
             fun(X) -> [X-1, X-2] end,
             fun lists:sum/1 %% fun([A, B]) -> A + B end
            }, Fun).

sfib_dnc_(N) ->
    gen_dnc(N, {fun(X) -> (X =:= 1) orelse (X =:= 2) end,
             fun(_) -> 1 end,
             fun(X) -> [X-1, X-2] end,
             fun lists:sum/1 %% fun([A, B]) -> A + B end
            }, fun lists:map/2).

gen_dnc(Problem, {IsBase, Base, Divide, Combine} = Funs, MapFun) ->
    case IsBase(Problem) of
        true -> Base(Problem);
        _ ->
            SubProblems = Divide(Problem),
            SubResults = MapFun(fun(P) -> gen_dnc(P, Funs, MapFun) end, SubProblems), 
            Combine(SubResults)
    end.

sdnc(Problem, {IsBase, Base, Divide, Combine} = Funs) ->
    case IsBase(Problem) of
        true -> Base(Problem);
        _ ->
            SubProblems = Divide(Problem),
            SubResults =lists:map(fun(P) -> sdnc(P, Funs) end, SubProblems), 
            Combine(SubResults)
    end.

pdnc(Problem, {IsBase, Base, Divide, Combine} = Funs) ->
    case IsBase(Problem) of
        true -> Base(Problem);
        _ ->
            SubProblems = Divide(Problem),
            SubResults =par:parmap(fun(P) -> pdnc(P, Funs) end, SubProblems), 
            Combine(SubResults)
    end.

qs([]) -> [];
qs([H]) -> [H];
qs([H|Hs]) ->
    Lesser = [E || E <- Hs, E < H],
    Greater = [E || E <- Hs, E >= H],
    qs(Lesser) ++ qs([H]) ++ qs(Greater). 

qs_dnc(L, Fun) ->
    gen_dnc(L, {fun([_, _ | _]) -> false; (_) -> true end, %fun([]) -> true, ([_]) -> true; (_) -> false end, %fun(X) -> length(X) < 2 end
        fun(X) -> X end,
        fun([X|Xs]) -> [[E || E <- Xs, E < X], [X], [E || E <- Xs, E >= X]] end,
        fun lists:append/1}, Fun).


% melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(dnc, [export_all]).
% {ok,dnc}
% 2> c(par, [export_all]).
% {ok,par}
% 3> timer:tc(par, seqmap, [fun dnc:sfib/1, [35,36,37]]).
% {216946,[9227465,14930352,24157817]}
% 4> timer:tc(par, seqmap, [fun dnc:sfib/1, [35,36,37,38,39]]).
% {605974,[9227465,14930352,24157817,39088169,63245986]}
% 5> timer:tc(par, parmap, [fun dnc:sfib/1, [35,36,37,38,39]]).
% {275258,[9227465,14930352,24157817,39088169,63245986]}
% 6> timer:tc(par, parmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {637808,
%  [9227465,14930352,24157817,39088169,63245986,102334155,
%   102334155,102334155]}
% 7> timer:tc(par, seqmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {1751800,
%  [9227465,102334155,14930352,102334155,24157817,39088169,
%   63245986,102334155]}
% 8> timer:tc(par, ordparmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {514812,
%  [9227465,102334155,14930352,102334155,24157817,39088169,
%   63245986,102334155]}
% 9> timer:tc(par, ordparmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {515756,
%  [9227465,102334155,14930352,102334155,24157817,39088169,
%   63245986,102334155]}
% 10> timer:tc(par, ordparmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {610102,
%  [9227465,102334155,14930352,102334155,24157817,39088169,
%   63245986,102334155]}
% 11> timer:tc(par, ordparmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {516710,
%  [9227465,102334155,14930352,102334155,24157817,39088169,
%   63245986,102334155]}
% 12> timer:tc(par, parmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {518488,
%  [9227465,14930352,24157817,39088169,63245986,102334155,
%   102334155,102334155]}
% 13> timer:tc(par, parmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {608555,
%  [9227465,14930352,24157817,39088169,63245986,102334155,
%   102334155,102334155]}
% 14> timer:tc(par, parmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {510791,
%  [9227465,14930352,24157817,39088169,63245986,102334155,
%   102334155,102334155]}
% 15> observer:start().
% ok
% 16> timer:tc(par, parmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {557959,
%  [9227465,14930352,24157817,39088169,63245986,102334155,
%   102334155,102334155]}
% 17> timer:tc(par, seqmap, [fun dnc:sfib/1, [35,40, 36, 40, 37,38,39, 40]]).
% {1826260,
%  [9227465,102334155,14930352,102334155,24157817,39088169,
%   63245986,102334155]}
% 18> libc++abi: terminating due to uncaught exception of type wxe_badarg
%                                                                        zsh: abort      erl
% melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> observer:start().
% ok
% 2> 
% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                                   melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(dnc, [export_all]).
% {ok,dnc}
% 2> c(dnc, [export_all]).
% {ok,dnc}
% 3> dnc:sfib_dnc(12).
% 144
% 4> dnc:sfib(12).
% 144
% 5> c(dnc, [export_all]).
% dnc.erl:41:55: Warning: variable 'MapFun' is unused
% %   41| pdnc(Problem, {IsBase, Base, Divide, Combine} = Funs, MapFun) ->
% %     |                                                       ^

% {ok,dnc}
% 6> c(dnc, [export_all]).
% {ok,dnc}
% 7> dnc:sfib_dnc2(12).
% ** exception error: undefined function dnc:sfib_dnc2/1
% 8> dnc:sfib_dnc_(12).
% 144
% 9> c(dnc, [export_all]).
% {ok,dnc}
% 10> dnc:fib(12, fun lists:map/2).
% 144
% 11> dnc:fib(12, fun par:parmap/2).
% 144
% 12> dnc:fib(12, fun par:ordparmap/2).
% 144
% 13> dnc:fib(30, fun par:ordparmap/2).
% 832040
% 14> c(dnc, [export_all]).
% {ok,dnc}
% 15> dnc:fib(3§, fun lists:map/2).
% * 1:10: syntax error before: '§'
% 15> dnc:fib(30, fun lists:map/2).
% 832040
% 16> dnc:fib(30, fun par:ordparmap/2).
% 832040
% 17> dnc:fib(40, fun par:ordparmap/2).
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                                   melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> dnc:fib(30, fun lists:map/2).
% 832040
% 2> dnc:fib(30, fun par:ordparmap/2).
% 832040
% 3> h(lists, append, 1).

%   -spec append(ListOfLists) -> List1
%                   when
%                       ListOfLists :: [List],
%                       List :: [T],
%                       List1 :: [T],
%                       T :: term().

%   Returns a list in which all sublists of ListOfLists have been
%   concatenated.

% Examples

%     1> lists:append([[1, 2, 3], [a, b], [4, 5, 6]]).
%     [1,2,3,a,b,4,5,6]
% ok
% 4> c(dnc, [export_all]).
% dnc.erl:67:31: variable 'Hs' is unbound
% %   67|         fun(X) -> [[E || E <- Hs, E < X], [X], [E || E <- Hs, E >= X]] end,
% %     |                               ^

% dnc.erl:67:59: variable 'Hs' is unbound
% %   67|         fun(X) -> [[E || E <- Hs, E < X], [X], [E || E <- Hs, E >= X]] end,
% %     |                                                           ^

% dnc.erl:68:9: illegal expression
% %   68|         lists:append/1}, Fun).
% %     |         ^

% error
% 5> c(dnc, [export_all]).
% dnc.erl:68:9: illegal expression
% %   68|         lists:append/1}, Fun).
% %     |         ^

% error
% 6> c(dnc, [export_all]).
% {ok,dnc}
% 7> dnc:qs([a,c,s,s,e,f]).
% [a,c,e,f,s,s]
% 8> dnc:qs([5,3,2,6,78]).
% [2,3,5,6,78]
% 9> dnc:qs_dnc([5,3,2,6,78], fun lists:map/2).
% [2,3,5,6,78]
% 10> dnc:qs_dnc([5,3,2,6,78], fun par:parmap/2).
% [5,2,3,6,78]
% 11> dnc:qs_dnc([5,3,2,6,78], fun par:ordparmap/2).
% [2,3,5,6,78]
% 12> h(lists, split, 2).

%   -spec split(N, List1) -> {List2, List3}
%                  when
%                      N :: non_neg_integer(),
%                      List1 :: [T],
%                      List2 :: [T],
%                      List3 :: [T],
%                      T :: term().

%   Splits List1 into List2, containing the first N elements, and 
%   List3, containing the rest.

% Examples

%     1> lists:split(3, [1,2,3,4,5,6,7]).
%     {[1,2,3],[4,5,6,7]}
% ok
% 13> 11 div 2.
% 5
% 14> c(dnc, [export_all]).
% {ok,dnc}
% 15> dnc:parfind(alma, [{korte, 12}, {alma, 24}, {narancs, 13}]).
% 24
% 16> dnc:parfind(almas, [{korte, 12}, {alma, 24}, {narancs, 13}]).
% not_found
% 17> dnc:parfind(almas, [{korte, 12}, {alma, 24}, {narancs, 13}, {alma, 45}]).
% not_found
% 18> dnc:parfind(alma, [{korte, 12}, {alma, 24}, {narancs, 13}, {alma, 45}]).
% 24
% 19> flush().
% Shell got {second,45}
% ok
% 20> dnc:fib(alma, fun par:ordparmap/2).
% ** exception error: an error occurred when evaluating an arithmetic expression
%      in operator  -/2
%         called as alma - 1
%      in call from dnc:'-fib/2-fun-0-'/1 (dnc.erl:36)
%      in call from dnc:gen_dnc/3 (dnc.erl:51)
% 21> par:parmap(fun(X) -> X+1 end, [1,2]).
% [2,3]
% 22> par:parmap(fun(X) -> X+1 end, [1,alma]).
% =ERROR REPORT==== 18-Mar-2026::13:14:02.577839 ===
% Error in process <0.2127372.0> with exit value:
% {badarith,[{erlang,'+',[alma,1],[{error_info,#{module => erl_erts_errors}}]},
%            {par,'-parmap/2-fun-1-',3,[{file,"par.erl"},{line,20}]}]}

% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                                   melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(error, [export_all]).
% {ok,error}
% 2> error:parmap(fun(X) -> X+1 end, [1,alma]).
% =ERROR REPORT==== 18-Mar-2026::13:15:47.830921 ===
% Error in process <0.95.0> with exit value:
% {badarith,[{erlang,'+',[alma,1],[{error_info,#{module => erl_erts_errors}}]},
%            {error,'-parmap/2-fun-1-',3,[{file,"error.erl"},{line,5}]}]}


% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                                   melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> self().
% <0.87.0>
% 2> spawn(fun() -> 1/0 end).
% <0.90.0>
% =ERROR REPORT==== 18-Mar-2026::13:16:45.093644 ===
% Error in process <0.90.0> with exit value:
% {badarith,[{erlang,'/',[1,0],[{error_info,#{module => erl_erts_errors}}]}]}

% 3> self().
% <0.87.0>
% 4> flush().
% ok
% 5> spawn_link(fun() -> 1/0 end).
% =ERROR REPORT==== 18-Mar-2026::13:17:29.596452 ===
% Error in process <0.94.0> with exit value:
% {badarith,[{erlang,'/',[1,0],[{error_info,#{module => erl_erts_errors}}]}]}

% ** exception exit: badarith
%      in operator  '/'/2
%         called as 1 / 0
% 6> self().
% <0.95.0>
% 7> process_flag(trap_exit, true).
% false
% 8> process_flag(trap_exit, true).
% true
% 9> spawn_link(fun() -> 1/0 end).
% <0.100.0>
% =ERROR REPORT==== 18-Mar-2026::13:19:01.058131 ===
% Error in process <0.100.0> with exit value:
% {badarith,[{erlang,'/',[1,0],[{error_info,#{module => erl_erts_errors}}]}]}

% 10> flush().
% Shell got {'EXIT',<0.100.0>,
%               {badarith,
%                   [{erlang,'/',
%                        [1,0],
%                        [{error_info,#{module => erl_erts_errors}}]}]}}
% ok
% 11> spawn_link(fun() -> 1/1 end).
% <0.103.0>
% 12> flush().
% Shell got {'EXIT',<0.103.0>,normal}
% ok
% 13> spawn_monitor(fun() -> 1/1 end).
% {<0.106.0>,#Ref<0.3955914447.967835651.231939>}
% 14> flush().
% Shell got {'DOWN',#Ref<0.3955914447.967835651.231939>,process,<0.106.0>,
%                   normal}
% ok
% 15> monitor(process, <0.34455667.0>).
% #Ref<0.3955914447.967835651.231985>
% 16> flush().
% Shell got {'DOWN',#Ref<0.3955914447.967835651.231985>,process,<0.34455667.0>,
%                   noproc}
% ok
% 17> c(error, [export_all]).
% {ok,error}
% 18> error:parmap(fun(X) -> X+1 end, [1,alma]).
% [2,
%  {'DOWN',#Ref<0.3955914447.967835651.232310>,process,
%          <0.116.0>,normal}]
% =ERROR REPORT==== 18-Mar-2026::13:26:40.131768 ===
% Error in process <0.117.0> with exit value:
% {badarith,[{erlang,'+',[alma,1],[{error_info,#{module => erl_erts_errors}}]},
%            {error,'-parmap/2-fun-1-',3,[{file,"error.erl"},{line,5}]}]}

% 19> flush().
% Shell got {'DOWN',#Ref<0.3955914447.967835651.232311>,process,<0.117.0>,
%               {badarith,
%                   [{erlang,'+',
%                        [alma,1],
%                        [{error_info,#{module => erl_erts_errors}}]},
%                    {error,'-parmap/2-fun-1-',3,
%                        [{file,"error.erl"},{line,5}]}]}}
% ok
% 20> error:parmap(fun(X) -> X+1 end, [1,alma]).
% [2,
%  {'DOWN',#Ref<0.3955914447.967835651.232354>,process,
%          <0.120.0>,normal}]
% =ERROR REPORT==== 18-Mar-2026::13:27:25.993053 ===
% Error in process <0.121.0> with exit value:
% {badarith,[{erlang,'+',[alma,1],[{error_info,#{module => erl_erts_errors}}]},
%            {error,'-parmap/2-fun-1-',3,[{file,"error.erl"},{line,5}]}]}

% 21> flush().
% Shell got {'DOWN',#Ref<0.3955914447.967835651.232355>,process,<0.121.0>,
%               {badarith,
%                   [{erlang,'+',
%                        [alma,1],
%                        [{error_info,#{module => erl_erts_errors}}]},
%                    {error,'-parmap/2-fun-1-',3,
%                        [{file,"error.erl"},{line,5}]}]}}
% ok
% 22> flush().
% ok
% 23> c(error, [export_all]).
% {ok,error}
% 24> error:parmap(fun(X) -> X+1 end, [1,alma]).
% [2,error]
% =ERROR REPORT==== 18-Mar-2026::13:29:25.777546 ===
% Error in process <0.131.0> with exit value:
% {badarith,[{erlang,'+',[alma,1],[{error_info,#{module => erl_erts_errors}}]},
%            {error,'-parmap/2-fun-1-',3,[{file,"error.erl"},{line,5}]}]}

% 25> flush().
% Shell got {'DOWN',#Ref<0.3955914447.967835651.232482>,process,<0.130.0>,
%                   normal}
% ok
% 26> c(error, [export_all]).
% {ok,error}
% 27> error:parmap(fun(X) -> X+1 end, [1,alma]).
% [2,error]
% =ERROR REPORT==== 18-Mar-2026::13:34:51.091333 ===
% Error in process <0.140.0> with exit value:
% {badarith,[{erlang,'+',[alma,1],[{error_info,#{module => erl_erts_errors}}]},
%            {error,'-parmap/2-fun-1-',3,[{file,"error.erl"},{line,16}]}]}

% 28> error:ordparmap(fun(X) -> X+1 end, [1,alma]).
% =ERROR REPORT==== 18-Mar-2026::13:34:58.526460 ===
% Error in process <0.143.0> with exit value:
% {badarith,[{erlang,'+',[alma,1],[{error_info,#{module => erl_erts_errors}}]},
%            {error,'-ordparmap/2-fun-1-',3,[{file,"error.erl"},{line,5}]}]}

% ** exception error: no function clause matching error:recv([]) (error.erl:8)
% 29> c(error, [export_all]).
% {ok,error}
% 30> error:ordparmap(fun(X) -> X+1 end, [1,alma]).
% [2]
% =ERROR REPORT==== 18-Mar-2026::13:35:17.113442 ===
% Error in process <0.152.0> with exit value:
% {badarith,[{erlang,'+',[alma,1],[{error_info,#{module => erl_erts_errors}}]},
%            {error,'-ordparmap/2-fun-1-',3,[{file,"error.erl"},{line,5}]}]}

% 31> flush().
% Shell got {'DOWN',#Ref<0.3955914447.967835650.231455>,process,<0.151.0>,
%                   normal}
% ok
% 32> c(error, [export_all]).
% {ok,error}
% 33> flush().
% ok
% 34> error:ordparmap(fun(X) -> X+1 end, [1,alma]).
% [2]
% =ERROR REPORT==== 18-Mar-2026::13:37:42.795461 ===
% Error in process <0.162.0> with exit value:
% {badarith,[{erlang,'+',[alma,1],[{error_info,#{module => erl_erts_errors}}]},
%            {error,'-ordparmap/2-fun-1-',3,[{file,"error.erl"},{line,5}]}]}

% 35> flush().
% ok
% 36> 