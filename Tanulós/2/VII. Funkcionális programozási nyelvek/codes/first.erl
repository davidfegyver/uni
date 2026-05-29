-module(first).
-export([foo/0, foo/1]).

foo() -> 1.

foo(X) -> X + 1.
% melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> 1+2.
% 3
% 2> 1+
%    1.
% 2
% 3> 1+
%    1.
% 2
% 4> length("abcd).
%    ").
% 7
% 5> ok.
% ok
% 6> erlang:length([]).
% 0
% 7> length([]).
% 0
% 8> q().
% ok
% 9> %                                                                            melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> 
% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> processes().
% [<0.0.0>,<0.1.0>,<0.2.0>,<0.3.0>,<0.4.0>,<0.5.0>,<0.6.0>,
%  <0.7.0>,<0.8.0>,<0.11.0>,<0.43.0>,<0.45.0>,<0.46.0>,
%  <0.47.0>,<0.49.0>,<0.50.0>,<0.51.0>,<0.52.0>,<0.53.0>,
%  <0.55.0>,<0.56.0>,<0.57.0>,<0.58.0>,<0.59.0>,<0.60.0>,
%  <0.61.0>,<0.62.0>,<0.63.0>,<0.64.0>|...]
% 2> length(processes()).
% 48
% 3> self().
% <0.87.0>
% 4> rp(processes()).
% [<0.0.0>,<0.1.0>,<0.2.0>,<0.3.0>,<0.4.0>,<0.5.0>,<0.6.0>,
%  <0.7.0>,<0.8.0>,<0.11.0>,<0.43.0>,<0.45.0>,<0.46.0>,
%  <0.47.0>,<0.49.0>,<0.50.0>,<0.51.0>,<0.52.0>,<0.53.0>,
%  <0.55.0>,<0.56.0>,<0.57.0>,<0.58.0>,<0.59.0>,<0.60.0>,
%  <0.61.0>,<0.62.0>,<0.63.0>,<0.64.0>,<0.65.0>,<0.66.0>,
%  <0.67.0>,<0.68.0>,<0.69.0>,<0.70.0>,<0.71.0>,<0.72.0>,
%  <0.73.0>,<0.74.0>,<0.75.0>,<0.76.0>,<0.77.0>,<0.79.0>,
%  <0.80.0>,<0.83.0>,<0.84.0>,<0.85.0>,<0.87.0>]
% ok
% 5> v(1).
% [<0.0.0>,<0.1.0>,<0.2.0>,<0.3.0>,<0.4.0>,<0.5.0>,<0.6.0>,
%  <0.7.0>,<0.8.0>,<0.11.0>,<0.43.0>,<0.45.0>,<0.46.0>,
%  <0.47.0>,<0.49.0>,<0.50.0>,<0.51.0>,<0.52.0>,<0.53.0>,
%  <0.55.0>,<0.56.0>,<0.57.0>,<0.58.0>,<0.59.0>,<0.60.0>,
%  <0.61.0>,<0.62.0>,<0.63.0>,<0.64.0>|...]
% 6> v(4).
% ok
% 7> io:format("alma").
% almaok
% 8> v(7).
% ok
% 9> io:format("alma~n").
% alma
% ok
% 10> self().
% <0.87.0>
% 11> 1/0.
% ** exception error: an error occurred when evaluating an arithmetic expression
%      in operator  '/'/2
%         called as 1 / 0
% 12> self().
% <0.99.0>
% 13> 1+1.
% 2
% 14> observer:start().
% ok
% 15> libc++abi: terminating due to uncaught exception of type wxe_badarg
%                                                                        zsh: abort      erl
% melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> 
% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % pwd
% /Users/melindatoth/Desktop/fp2
% melindatoth@MacBook-Pro fp2 % erl 
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> pwd().
% /Users/melindatoth/Desktop/fp2
% ok
% 2> ls().
% first.erl     slides        
% ok
% 3> c(first).
% {ok,first}
% 4> ls().
% first.beam     first.erl      slides         
% ok
% 5> c(first).
% first.erl:3:1: Warning: function foo/0 is unused
% %    3| foo() -> 1.
% %     | ^

% first.erl:5:1: Warning: function foo/1 is unused
% %    5| foo(X) -> X + 1.
% %     | ^

% {ok,first}
% 6> c(first).
% {ok,first}
% 7> first:foo().
% 1
% 8> first:foo(12).
% 13
% 9> x.
% x
% 10> beam_disasm:file(first).
% {beam_file,first,
%            [{foo,0,2},{foo,1,4},{module_info,0,6},{module_info,1,8}],
%            [{vsn,[36796637052643873764416195727192863087]}],
%            [{version,"9.0"},
%             {options,[]},
%             {source,"/Users/melindatoth/Desktop/fp2/first.erl"}],
%            [{function,foo,0,2,
%                       [{label,1},
%                        {line,1},
%                        {func_info,{atom,first},{atom,foo},0},
%                        {label,2},
%                        {move,{integer,1},{x,0}},
%                        return]},
%             {function,foo,1,4,
%                       [{line,2},
%                        {label,3},
%                        {func_info,{atom,first},{atom,foo},1},
%                        {label,4},
%                        {gc_bif,'+',{f,0},1,[{x,0},{integer,1}],{x,0}},
%                        return]},
%             {function,module_info,0,6,
%                       [{line,0},
%                        {label,5},
%                        {func_info,{atom,first},{atom,module_info},0},
%                        {label,6},
%                        {move,{atom,first},{x,0}},
%                        {call_ext_only,1,{extfunc,erlang,get_module_info,1}}]},
%             {function,module_info,1,8,
%                       [{line,0},
%                        {label,7},
%                        {func_info,{atom,first},{atom,module_info},1},
%                        {label,8},
%                        {move,{x,0},{x,1}},
%                        {move,{atom,first},{x,0}},
%                        {call_ext_only,2,
%                                       {extfunc,erlang,get_module_info,2}}]}]}
% 11> 
