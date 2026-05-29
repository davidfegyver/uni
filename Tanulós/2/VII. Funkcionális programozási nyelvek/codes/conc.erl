-module(conc).
-export([fib/1, start/0, fibcache/1]).
sfib(1) -> 1;
sfib(2) -> 1;
sfib(N) -> sfib(N-1) + sfib(N-2).

%% conc dnc
%% jobserver, -define, request, result, upgrade
%% 
fib(N) ->
    fibcache ! {get, N, self()},
    receive
        {result, N, Fib} -> Fib
    end.

start() ->
    register(fibcache, spawn_link(conc, fibcache, [#{1=>1, 2=>1}])). %%spawn(fun() -> fibcache(#{1=>1, 2=>1}) end).

fibcache(State) ->
    receive
        {update, N, Fib} ->
            conc:fibcache(State#{N=>Fib});
        {get, N, From} ->
            case State of
                #{N:=Fib} -> 
                    io:format("State~p~n", [State]),
                    From ! {result, N, Fib},
                    conc:fibcache(State);
                _ -> 
                    spawn(fun() -> 
                        Fib1 = fib(N-1), Fib2 = fib(N-2),
                        fibcache ! {update, N-1, Fib1},
                        fibcache ! {update, N-2, Fib2},
                        fibcache ! {update, N, Fib1 + Fib2},
                        From ! {result, N, Fib1 + Fib2}
                    end),
                    conc:fibcache(State)
            end;
        upgrade -> conc:fibcache(State)
    end.

fibcache_sfib(State) ->
    receive
        {get, N, From} ->
            case State of
                #{N:=Fib} -> 
                    From ! {result, N, Fib},
                    fibcache(State);
                _ -> 
                    FibN1 = sfib(N-1), FibN2 = sfib(N-2),
                    %FibN1 = fib(N-1), FibN2 = fib(N-2),
                    From ! {result, N, FibN1 + FibN2},
                    fibcache(State#{N => FibN1 + FibN2})
            end
    end.


% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(conc).
% conc.erl:24:29: function sfib/1 undefined, did you mean fib/1?
% %   24|                     FibN1 = sfib(N-1), FibN2 = sfib(N-2),
% %     |                             ^

% conc.erl:24:48: function sfib/1 undefined, did you mean fib/1?
% %   24|                     FibN1 = sfib(N-1), FibN2 = sfib(N-2),
% %     |                                                ^

% conc.erl:16:1: Warning: function fibcache/1 is unused
% %   16| fibcache(State) ->
% %     | ^

% error
% 2> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:19:1: Warning: function fibcache/1 is unused
% %   19| fibcache(State) ->
% %     | ^

% {ok,conc}
% 3> conc:start().
% =ERROR REPORT==== 8-Apr-2026::12:25:14.504670 ===
% Error in process <0.98.0> with exit value:
% {undef,[{conc,fibcache,[#{1 => 1,2 => 1}],[]}]}

% <0.98.0>
% 4> conc:start().
% <0.100.0>
% =ERROR REPORT==== 8-Apr-2026::12:25:39.819315 ===
% Error in process <0.100.0> with exit value:
% {undef,[{conc,fibcache,[#{1 => 1,2 => 1}],[]}]}

% 5> c(conc).
% {ok,conc}
% 6> conc:start().
% <0.107.0>
% 7> c(conc).
% {ok,conc}
% 8> conc:start().
% true
% 9> conc:fib(30).
% 832040
% 10> conc:fib(40).
% 102334155
% 11> conc:fib(41).
% 165580141
% 12> conc:fib(41).
% 165580141
% 13> conc:fib(41).
% 165580141
% 14> conc:fib(41).
% 165580141
% 15> conc:fib(41).
% 165580141
% 16> conc:fib(41).
% 165580141
% 17> conc:fib(42).
% 267914296
% 18> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% {ok,conc}
% 19> conc:start().
% ** exception error: bad argument
%      in function  register/2
%         called as register(fibcache,<0.130.0>)
%         *** argument 1: name is in use
%      in call from conc:start/0 (conc.erl:17)
% 20> whereis(fibcache).
% <0.114.0>
% 21> exit(whereis(fibcache), kill).
% true
% 22> whereis(fibcache).
% undefined
% 23> conc:start().
% true
% 24> conc:fib(30).
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(conc).
% conc.erl:31:25: syntax error before: fibcache
% %   31|                         fibcache ! {update, N-1, Fib1},
% %     |                         ^

% conc.erl:2:2: function fibcache/1 undefined, did you mean fibcache_sfib/1?
% %    2| -export([fib/1, start/0, fibcache/1]).
% %     |  ^

% conc.erl:45:21: function fibcache/1 undefined, did you mean fibcache_sfib/1?
% %   45|                     fibcache(State);
% %     |                     ^

% conc.erl:50:21: function fibcache/1 undefined, did you mean fibcache_sfib/1?
% %   50|                     fibcache(State#{N => FibN1 + FibN2})
% %     |                     ^

% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:39:1: Warning: function fibcache_sfib/1 is unused
% %   39| fibcache_sfib(State) ->
% %     | ^

% error
% 2> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:39:1: Warning: function fibcache_sfib/1 is unused
% %   39| fibcache_sfib(State) ->
% %     | ^

% {ok,conc}
% 3> conc:start().
% true
% 4> conc:fib(30).
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> conc:fib(1).
% ** exception error: bad argument
%      in function  erlang:send/2
%         called as erlang:send(fibcache,{get,1,<0.87.0>})
%         *** argument 1: invalid destination
%      in call from conc:fib/1 (conc.erl:11)
% 2> conc:start().
% true
% 3> conc:fib(1).
% 1
% 4> conc:fib(2).
% 1
% 5> conc:fib(3).
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> conc:start().
% true
% 2> conc:fib(3).
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> dbg:tracer().
% {ok,<0.89.0>}
% 2> dbg:p(conc, proc).
% {error,{bad_flags,[proc]}}
% 3> dbg:p(new, p).
% {ok,[{matched,nonode@nohost,0}]}
% (<0.93.0>) spawned <0.72.0> {erlang,apply,[#Fun<shell.1.25725971>,[]]}
% (<0.93.0>) getting_linked <0.72.0>
% 4> conc:start().
% (<0.93.0>) exit {ok,[{call,{1,1},{remote,{1,5},{atom,{1,1},conc},{atom,{1,6},start}},[]}]}
% (<0.94.0>) spawned <0.87.0> {conc,fibcache,[#{1 => 1,2 => 1}]}
% true
% (<0.94.0>) register fibcache
% (<0.95.0>) spawned <0.72.0> {erlang,apply,[#Fun<shell.1.25725971>,[]]}
% (<0.95.0>) getting_linked <0.72.0>
% 5> conc:fib(2).
% (<0.95.0>) exit {ok,[{call,{1,1},
%            {remote,{1,5},{atom,{1,1},conc},{atom,{1,6},fib}},
%            [{integer,{1,10},2}]}]}
% ...

% 7> conc:fib(2).
% (<0.97.0>) << {io_reply,#Ref<0.2780392469.1883766785.162796>,
%                         {ok,[{atom,[{text,"conc"},{location,{1,1}}],conc},
%                              {':',[{text,":"},{location,{1,5}}]},
%                              {atom,[{text,"fib"},{location,{1,6}}],fib},
%                              {'(',[{text,"("},{location,{1,9}}]},
%                              {integer,[{text,"2"},{location,{1,10}}],2},
%                              {')',[{text,")"},{location,{1,11}}]},
%                              {dot,[{text,".\n"},{location,{1,12}}]}],
%                             {2,1}}}
% (<0.97.0>) <0.70.0> ! {io_request,<0.97.0>,
%                                   #Ref<0.2780392469.1883766785.162830>,
%                                   {setopts,[{line_history,false}]}}
% 1
% (<0.97.0>) << {io_reply,#Ref<0.2780392469.1883766785.162830>,ok}
% (<0.97.0>) exit {ok,[{call,{1,1},
%            {remote,{1,5},{atom,{1,1},conc},{atom,{1,6},fib}},
%            [{integer,{1,10},2}]}]}
% (<0.98.0>) spawned <0.72.0> {erlang,apply,[#Fun<shell.1.25725971>,[]]}
% (<0.98.0>) getting_linked <0.72.0>
% (<0.98.0>) <0.70.0> ! {io_request,<0.98.0>,
%                                   #Ref<0.2780392469.1883766785.162848>,
%                                   getopts}
% ...

% 8> dbg:p(all, c).
% {ok,[{matched,nonode@nohost,51}]}
% (<0.98.0>) <0.70.0> ! {io_request,<0.98.0>,
%                                   #Ref<0.2780392469.1883766785.162903>,
%                                   {setopts,[{line_history,false}]}}
% (<0.98.0>) << {io_reply,#Ref<0.2780392469.1883766785.162903>,ok}
% (<0.98.0>) exit {ok,[{call,{1,1},
%            {remote,{1,4},{atom,{1,1},dbg},{atom,{1,5},p}},
%            [{atom,{1,7},all},{atom,{1,12},c}]}]}
% (<0.99.0>) spawned <0.72.0> {erlang,apply,[#Fun<shell.1.25725971>,[]]}
% (<0.99.0>) getting_linked <0.72.0>
% (<0.99.0>) <0.70.0> ! {io_request,<0.99.0>,
%                                   #Ref<0.2780392469.1883766785.162918>,
%                                   getopts}
% ...

% 9> dbg:stop().

% 10> dbg:tracer().
% {ok,<0.101.0>}

% 11> dbg:p(all, c).
% {ok,[{matched,nonode@nohost,51}]}
% 12> dbg:tp(conc, x).
% {ok,[{matched,nonode@nohost,5},{saved,x}]}
% 13> conc:start().
% (<0.87.0>) call conc:start()
% (<0.87.0>) exception_from {conc,start,0} {error,badarg}
% (<0.106.0>) call conc:fibcache(#{1 => 1,2 => 1})
% ** exception error: bad argument
%      in function  register/2
%         called as register(fibcache,<0.106.0>)
%         *** argument 1: name is in use
%      in call from conc:start/0 (conc.erl:17)
% 14> conc:fib(2).
% (<0.107.0>) call conc:fib(2)
% (<0.107.0>) returned from conc:fib/1 -> 1
% 1
% 15> conc:fib(3).
% (<0.107.0>) call conc:fib(3)
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> dbg:tracer().
% {ok,<0.89.0>}
% 2> dbg:p(all, c).
% {ok,[{matched,nonode@nohost,50}]}

% 3> dbg:tp(conc, x).

% {ok,[{matched,nonode@nohost,5},{saved,x}]}
% 4> dbg:tpl(conc, x).
% (<0.87.0>) call conc:module_info()
% (<0.87.0>) returned from conc:module_info/0 -> [{module,conc},
%                                                 {exports,
%                                                  [{fib,1},
%                                                   {start,0},
%                                                   {fibcache,1},
%                                                   {module_info,1},
%                                                   {module_info,0}]},
%                                                 {attributes,
%                                                  [{vsn,
%                                                    [339209568733179707456644059586153001376]}]},
%                                                 {compile,
%                                                  [{version,"9.0"},
%                                                   {options,[]},
%                                                   {source,
%                                                    "/Users/melindatoth/Desktop/fp2/conc.erl"}]},
%                                                 {md5,<<"ÿ1b÷5/ï(m7Ïã×Õ± ">>}]
% {ok,[{matched,nonode@nohost,6},{saved,x}]}
% 6> conc:start().
% (<0.95.0>) call conc:start()
% (<0.95.0>) returned from conc:start/0 -> true
% (<0.97.0>) call conc:fibcache(#{1 => 1,2 => 1})
% true
% 7> conc:fib(3).
% (<0.95.0>) call conc:fib(3)
% (<0.97.0>) call conc:fibcache(#{1 => 1,2 => 1})
% (<0.99.0>) call conc:'-fibcache/1-fun-0-'(3)
% (<0.99.0>) call conc:fib(2)
% (<0.97.0>) call conc:fibcache(#{1 => 1,2 => 1})
% (<0.99.0>) returned from conc:fib/1 -> 1
% (<0.99.0>) call conc:fib(1)
% (<0.97.0>) call conc:fibcache(#{1 => 1,2 => 1})
% (<0.99.0>) returned from conc:fib/1 -> 1
% (<0.99.0>) returned from conc:'-fibcache/1-fun-0-'/1 -> {update,3,2}
% (<0.97.0>) call conc:fibcache(#{1 => 1,2 => 1})
% (<0.97.0>) call conc:fibcache(#{1 => 1,2 => 1})
% (<0.97.0>) call conc:fibcache(#{1 => 1,2 => 1,3 => 2})
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:40:1: Warning: function fibcache_sfib/1 is unused
% %   40| fibcache_sfib(State) ->
% %     | ^

% {ok,conc}
% 2> conc:start().
% true
% 3> conc:fib(3).
% 2
% 4> conc:fib(13).
% 233
% 5> conc:fib(33).
% 3524578
% 6> conc:fib(43).
% 433494437
% 7> conc:fib(44).
% 701408733
% 8> conc:fib(50).
% 12586269025
% 9> conc:fib(60).
% 1548008755920
% 10> conc:fib(80).
% 23416728348467685
% 12> dbg:tracer().
% {ok,<0.182.0>}
% 13> dbg:p(all, all).
% (<0.182.0>) <0.87.0> ! {dbg,{ok,[{matched,nonode@nohost,52}]}} (Timestamp: {1775,
%                                                                             646546,
%                                                                             615892})
% {ok,[{matched,nonode@nohost,52}]}
% (<0.182.0>) out {dbg,loop,4} (Timestamp: {1775,646546,615902})
% (<0.87.0>) in {dbg,req,1} (Timestamp: {1775,646546,615915})
% (<0.87.0>) << {dbg,{ok,[{matched,nonode@nohost,52}]}} (Timestamp: {1775,
%                                                                    646546,
%                                                                    615916})
% (<0.87.0>) <0.70.0> ! {io_request,<0.87.0>,#Ref<0.818403017.543162373.91961>,
%                                   {get_geometry,columns}} (Timestamp: {1775,
%                                                                        646546,
%                                                                        615925})
% (<0.87.0>) out {io,execute_request,3} (Timestamp: {1775,646546,615927})
% (<0.69.0>) in {gen_statem,loop,3} (Timestamp: {1775,646546,615969})
% (<0.69.0>) << {io_request,<0.184.0>,#Ref<0.818403017.543162373.91960>,getopts} (Timestamp: {1775,
%                                                                                             646546,
%                                                                                             615971})
% (<0.69.0>) <0.66.0> ! {<0.69.0>,get_unicode_state} (Timestamp: {1775,646546,
%                                                                 615974})
% ....
%                                                                                       652957})
% (<0.66.0>) gc_minor_start [{wordsize,10},
%  {old_heap_block_size,6772},
%  {heap_block_size,4185},
%  {mbuf_size,0},
%  {recent_size,447},
%  {stack_size,43},
%  {old_heap_size,2590},
%  {heap_size,4131},
%  {bin_vheap_size,1307},
%  {bin_vheap_block_size,46422},
%  {bin_old_vheap_size,296},
%  {bin_old_vheap_block_size,46422}] (Timestamp: {1775,646546,652959})
% (<0.66.0>) gc_minor_end [{wordsize,3965},
%  {old_heap_block_size,6772},
%  {heap_block_size,4185},
%  {mbuf_size,0},
%  {recent_size,166},
%  {stack_size,43},
%  {old_heap_size,2590},
%  {heap_size,166},
%  {bin_vheap_size,8},
%  {bin_vheap_block_size,46422},
%  {bin_old_vheap_size,296},
%  {bin_old_vheap_block_size,46422}] (Timestamp: {1775,646546,652962})
% ...

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % 
% melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> dbg:tracer().
% {ok,<0.89.0>}
% 2> dbg:p(new, [m]).
% {ok,[{matched,nonode@nohost,0}]}
% (<0.92.0>) <0.70.0> ! {io_request,<0.92.0>,
%                                   #Ref<0.2262371414.2422996996.169044>,
%                                   getopts}
% (<0.92.0>) << {io_reply,#Ref<0.2262371414.2422996996.169044>,
%                         [{expand_fun,fun edlin_expand:expand/2},
%                          {echo,true},
%                          {line_history,false},
%                          {log,none},
%                          {binary,false},
%                          {encoding,unicode},
%                          {terminal,true},
%                          {stdout,true},
%                          {stderr,true},
%                          {stdin,true}]}
% (<0.92.0>) <0.70.0> ! {io_request,<0.92.0>,
%                                   #Ref<0.2262371414.2422996996.169048>,
%                                   {setopts,[{line_history,true}]}}
% (<0.92.0>) << {io_reply,#Ref<0.2262371414.2422996996.169048>,ok}
% (<0.92.0>) <0.70.0> ! {io_request,<0.92.0>,
%                           #Ref<0.2262371414.2422996996.169051>,
%                           {get_until,unicode,
%                               ["3",62,32],
%                               erl_scan,tokens,
%                               [{1,1},
%                                [text,
%                                 {reserved_word_fun,
%                                     fun erl_scan:reserved_word/1}]]}}
% 3> conc:start().
% (<0.92.0>) << {io_reply,#Ref<0.2262371414.2422996996.169051>,
%                         {ok,[{atom,[{text,"conc"},{location,{1,1}}],conc},
%                              {':',[{text,":"},{location,{1,5}}]},
%                              {atom,[{text,"start"},{location,{1,6}}],start},
%                              {'(',[{text,"("},{location,{1,11}}]},
%                              {')',[{text,")"},{location,{1,12}}]},
%                              {dot,[{text,".\n"},{location,{1,13}}]}],
%                             {2,1}}}
% (<0.92.0>) <0.70.0> ! {io_request,<0.92.0>,
%                                   #Ref<0.2262371414.2422996996.169089>,
%                                   {setopts,[{line_history,false}]}}
% (<0.92.0>) << {io_reply,#Ref<0.2262371414.2422996996.169089>,ok}
% true
% (<0.94.0>) <0.70.0> ! {io_request,<0.94.0>,
%                                   #Ref<0.2262371414.2422996996.169111>,
%                                   getopts}
% (<0.94.0>) << {io_reply,#Ref<0.2262371414.2422996996.169111>,
%                         [{expand_fun,fun edlin_expand:expand/2},
%                          {echo,true},
%                          {line_history,false},
%                          {log,none},
%                          {binary,false},
%                          {encoding,unicode},
%                          {terminal,true},
%                          {stdout,true},
%                          {stderr,true},
%                          {stdin,true}]}
% (<0.94.0>) <0.70.0> ! {io_request,<0.94.0>,
%                                   #Ref<0.2262371414.2422996996.169116>,
%                                   {setopts,[{line_history,true}]}}
% (<0.94.0>) << {io_reply,#Ref<0.2262371414.2422996996.169116>,ok}
% (<0.94.0>) <0.70.0> ! {io_request,<0.94.0>,
%                           #Ref<0.2262371414.2422996996.169117>,
%                           {get_until,unicode,
%                               ["4",62,32],
%                               erl_scan,tokens,
%                               [{1,1},
%                                [text,
%                                 {reserved_word_fun,
%                                     fun erl_scan:reserved_word/1}]]}}
% 4> conc:fib(4).
% (<0.94.0>) << {io_reply,#Ref<0.2262371414.2422996996.169117>,
%                         {ok,[{atom,[{text,"conc"},{location,{1,1}}],conc},
%                              {':',[{text,":"},{location,{1,5}}]},
%                              {atom,[{text,"fib"},{location,{1,6}}],fib},
%                              {'(',[{text,"("},{location,{1,9}}]},
%                              {integer,[{text,"4"},{location,{1,10}}],4},
%                              {')',[{text,")"},{location,{1,11}}]},
%                              {dot,[{text,".\n"},{location,{1,12}}]}],
%                             {2,1}}}
% (<0.94.0>) <0.70.0> ! {io_request,<0.94.0>,
%                                   #Ref<0.2262371414.2422996996.169151>,
%                                   {setopts,[{line_history,false}]}}
% (<0.94.0>) << {io_reply,#Ref<0.2262371414.2422996996.169151>,ok}
% 3
% (<0.93.0>) << {get,4,<0.87.0>}
% (<0.95.0>) fibcache ! {get,3,<0.95.0>}
% (<0.93.0>) << {get,3,<0.95.0>}
% (<0.96.0>) fibcache ! {get,2,<0.96.0>}
% (<0.93.0>) << {get,2,<0.96.0>}
% (<0.93.0>) <0.96.0> ! {result,2,1}
% (<0.96.0>) << {result,2,1}
% (<0.96.0>) fibcache ! {get,1,<0.96.0>}
% (<0.93.0>) << {get,1,<0.96.0>}
% (<0.93.0>) <0.96.0> ! {result,1,1}
% (<0.96.0>) << {result,1,1}
% (<0.96.0>) fibcache ! {update,2,1}
% (<0.96.0>) fibcache ! {update,1,1}
% (<0.96.0>) fibcache ! {update,3,2}
% (<0.96.0>) <0.95.0> ! {result,3,2}
% (<0.93.0>) << {update,2,1}
% (<0.93.0>) << {update,1,1}
% (<0.93.0>) << {update,3,2}
% (<0.95.0>) << {result,3,2}
% (<0.95.0>) fibcache ! {get,2,<0.95.0>}
% (<0.93.0>) << {get,2,<0.95.0>}
% (<0.93.0>) <0.95.0> ! {result,2,1}
% (<0.95.0>) << {result,2,1}
% (<0.95.0>) fibcache ! {update,3,2}
% (<0.95.0>) fibcache ! {update,2,1}
% (<0.95.0>) fibcache ! {update,4,3}
% (<0.95.0>) <0.87.0> ! {result,4,3}
% (<0.93.0>) << {update,3,2}
% (<0.93.0>) << {update,2,1}
% (<0.93.0>) << {update,4,3}
% (<0.97.0>) <0.70.0> ! {io_request,<0.97.0>,
%                                   #Ref<0.2262371414.2422996996.169169>,
%                                   getopts}
% (<0.97.0>) << {io_reply,#Ref<0.2262371414.2422996996.169169>,
%                         [{expand_fun,fun edlin_expand:expand/2},
%                          {echo,true},
%                          {line_history,false},
%                          {log,none},
%                          {binary,false},
%                          {encoding,unicode},
%                          {terminal,true},
%                          {stdout,true},
%                          {stderr,true},
%                          {stdin,true}]}
% (<0.97.0>) <0.70.0> ! {io_request,<0.97.0>,
%                                   #Ref<0.2262371414.2422996995.168406>,
%                                   {setopts,[{line_history,true}]}}
% (<0.97.0>) << {io_reply,#Ref<0.2262371414.2422996995.168406>,ok}
% (<0.97.0>) <0.70.0> ! {io_request,<0.97.0>,
%                           #Ref<0.2262371414.2422996995.168407>,
%                           {get_until,unicode,
%                               ["5",62,32],
%                               erl_scan,tokens,
%                               [{1,1},
%                                [text,
%                                 {reserved_word_fun,
%                                     fun erl_scan:reserved_word/1}]]}}
% 5> dbg:tracer().
% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> conc:start().
% true
% 2> whereis(fibcache).
% <0.89.0>
% 3> dbg:tracer().
% {ok,<0.92.0>}
% 4> dbg:p(<0.89.0>, [all]).
% {ok,[{matched,nonode@nohost,1}]}
% 5> conc:fib(4).
% (<0.89.0>) in {conc,fibcache,1} (Timestamp: {1775,646899,715755})
% 3
% (<0.89.0>) << {get,4,<0.87.0>} (Timestamp: {1775,646899,715760})
% (<0.89.0>) spawn <0.96.0> as erlang:apply(#Fun<conc.0.90478314>,[]) (Timestamp: {1775,
%                                                                                  646899,
%                                                                                  715767})
% (<0.96.0>) spawned <0.89.0> {erlang,apply,[#Fun<conc.0.90478314>,[]]} (Timestamp: {1775,
%                                                                                    646899,
%                                                                                    715768})
% (<0.89.0>) out {conc,fibcache,1} (Timestamp: {1775,646899,715770})
% (<0.96.0>) in {erlang,apply,2} (Timestamp: {1775,646899,715778})
% (<0.96.0>) fibcache ! {get,3,<0.96.0>} (Timestamp: {1775,646899,715781})
% (<0.96.0>) out {conc,fib,1} (Timestamp: {1775,646899,715782})
% (<0.89.0>) in {conc,fibcache,1} (Timestamp: {1775,646899,715787})
% (<0.89.0>) << {get,3,<0.96.0>} (Timestamp: {1775,646899,715788})
% (<0.89.0>) spawn <0.97.0> as erlang:apply(#Fun<conc.0.90478314>,[]) (Timestamp: {1775,
%                                                                                  646899,
%                                                                                  715791})
% (<0.89.0>) out {conc,fibcache,1} (Timestamp: {1775,646899,715792})
% (<0.89.0>) in {conc,fibcache,1} (Timestamp: {1775,646899,715798})
% (<0.89.0>) << {get,2,<0.97.0>} (Timestamp: {1775,646899,715799})
% (<0.89.0>) <0.97.0> ! {result,2,1} (Timestamp: {1775,646899,715800})
% (<0.89.0>) out {conc,fibcache,1} (Timestamp: {1775,646899,715801})
% (<0.89.0>) in {conc,fibcache,1} (Timestamp: {1775,646899,715849})
% (<0.89.0>) << {get,1,<0.97.0>} (Timestamp: {1775,646899,715851})
% (<0.89.0>) <0.97.0> ! {result,1,1} (Timestamp: {1775,646899,715852})
% (<0.89.0>) out {conc,fibcache,1} (Timestamp: {1775,646899,715853})
% (<0.89.0>) in {conc,fibcache,1} (Timestamp: {1775,646899,715917})
% (<0.89.0>) << {update,2,1} (Timestamp: {1775,646899,715919})
% (<0.89.0>) << {update,1,1} (Timestamp: {1775,646899,715920})
% (<0.89.0>) << {update,3,2} (Timestamp: {1775,646899,715921})
% (<0.89.0>) out {conc,fibcache,1} (Timestamp: {1775,646899,715923})
% (<0.96.0>) in {conc,fib,1} (Timestamp: {1775,646899,715925})
% (<0.96.0>) << {result,3,2} (Timestamp: {1775,646899,715926})
% (<0.96.0>) fibcache ! {get,2,<0.96.0>} (Timestamp: {1775,646899,715927})
% (<0.96.0>) out {conc,fib,1} (Timestamp: {1775,646899,715928})
% (<0.89.0>) in {conc,fibcache,1} (Timestamp: {1775,646899,715941})
% (<0.89.0>) << {get,2,<0.96.0>} (Timestamp: {1775,646899,715942})
% (<0.89.0>) <0.96.0> ! {result,2,1} (Timestamp: {1775,646899,715943})
% (<0.89.0>) out {conc,fibcache,1} (Timestamp: {1775,646899,715944})
% (<0.96.0>) in {conc,fib,1} (Timestamp: {1775,646899,715945})
% (<0.96.0>) << {result,2,1} (Timestamp: {1775,646899,715946})
% (<0.96.0>) fibcache ! {update,3,2} (Timestamp: {1775,646899,715947})
% (<0.96.0>) fibcache ! {update,2,1} (Timestamp: {1775,646899,715948})
% (<0.96.0>) fibcache ! {update,4,3} (Timestamp: {1775,646899,715949})
% (<0.96.0>) <0.87.0> ! {result,4,3} (Timestamp: {1775,646899,715950})
% (<0.96.0>) exit normal (Timestamp: {1775,646899,715951})
% (<0.96.0>) out_exited 0 (Timestamp: {1775,646899,715952})
% (<0.89.0>) in {conc,fibcache,1} (Timestamp: {1775,646899,715954})
% (<0.89.0>) << {update,3,2} (Timestamp: {1775,646899,715955})
% (<0.89.0>) << {update,2,1} (Timestamp: {1775,646899,715956})
% (<0.89.0>) << {update,4,3} (Timestamp: {1775,646899,715957})
% (<0.89.0>) out {conc,fibcache,1} (Timestamp: {1775,646899,715958})
% 6> 
% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:41:1: Warning: function fibcache_sfib/1 is unused
% %   41| fibcache_sfib(State) ->
% %     | ^

% {ok,conc}
% 2> conc:start().
% true
% 3> conc:fib(4).
% 3
% 4> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:42:1: Warning: function fibcache_sfib/1 is unused
% %   42| fibcache_sfib(State) ->
% %     | ^

% {ok,conc}
% 5> conc:fib(4).
% 3
% 6> conc:fib(4).
% 3
% 7> conc:fib(4).
% 3
% 8> conc:fib(4).
% 3
% 9> fibcache ! upgrade.
% upgrade
% 10> conc:fib(4).
% State#{1 => 1,2 => 1,3 => 2,4 => 3}
% 3
% 11> conc:fib(4).
% State#{1 => 1,2 => 1,3 => 2,4 => 3}
% 3
% 12> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:42:1: Warning: function fibcache_sfib/1 is unused
% %   42| fibcache_sfib(State) ->
% %     | ^

% {ok,conc}
% 13> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:42:1: Warning: function fibcache_sfib/1 is unused
% %   42| fibcache_sfib(State) ->
% %     | ^

% {ok,conc}
% 14> conc:fib(4).
% ** exception error: bad argument
%      in function  erlang:send/2
%         called as erlang:send(fibcache,{get,4,<0.87.0>})
%         *** argument 1: invalid destination
%      in call from conc:fib/1 (conc.erl:11)
% 15> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:42:1: Warning: function fibcache_sfib/1 is unused
% %   42| fibcache_sfib(State) ->
% %     | ^

% {ok,conc}
% 16> conc:start().
% true
% 17> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:42:1: Warning: function fibcache_sfib/1 is unused
% %   42| fibcache_sfib(State) ->
% %     | ^

% {ok,conc}
% 18> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:42:1: Warning: function fibcache_sfib/1 is unused
% %   42| fibcache_sfib(State) ->
% %     | ^

% ** exception exit: killed
% 19> conc:fib(4).
% ** exception error: bad argument
%      in function  erlang:send/2
%         called as erlang:send(fibcache,{get,4,<0.139.0>})
%         *** argument 1: invalid destination
%      in call from conc:fib/1 (conc.erl:11)
% 20> conc:start().
% true
% 21> conc:fib(4).
% State$$$$$#{1 => 1,2 => 1}
% State$$$$$#{1 => 1,2 => 1}
% State$$$$$#{1 => 1,2 => 1,3 => 2}
% 3
% 22> c(conc).
% conc.erl:3:1: Warning: function sfib/1 is unused
% %    3| sfib(1) -> 1;
% %     | ^

% conc.erl:42:1: Warning: function fibcache_sfib/1 is unused
% %   42| fibcache_sfib(State) ->
% %     | ^

% {ok,conc}
% 23> conc:fib(4).
% State$$$$$#{1 => 1,2 => 1,3 => 2,4 => 3}
% 3
% 24> conc:fib(4).
% State#{1 => 1,2 => 1,3 => 2,4 => 3}
% 3
% 25> 
