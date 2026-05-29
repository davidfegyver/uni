-module(second).
-export([sum/1, foo/0, sum_mul/1, sum_mul2/1]).

% @spec(sum(pos_integer()) -> pos_integer()).
-spec(sum(pos_integer()) -> pos_integer()).
sum(1) -> % sum(X) when X == 1
    1;
sum(X) when X > 0, is_integer(X) ->
    X + sum(X-1).
% sum(_) -> undefined.

foo() -> sum([]) / 12.

sum_list([]) -> 0;
sum_list([H|T]) -> H + sum_list(T).

sum_mul([]) -> 0;
sum_mul([A]) -> A;
sum_mul([A,B | Rem]) ->
    sum_mul_([A+B | Rem]).

sum_mul_([A]) -> A;
sum_mul_([A,B | Rem]) ->
    sum_mul([A*B | Rem]).

sum_mul2([]) -> 0;
sum_mul2([A]) -> A;
sum_mul2([A, B]) -> A + B;
sum_mul2([A, B, C | Tail]) ->
    sum_mul2([(A+B)*C | Tail]).

sum_mul3(L) ->
    sum_mul3(L, add).

sum_mul3([], _) -> 0;
sum_mul3([A], _) -> A;
sum_mul3([A,B | Rem], add) ->
    sum_mul3([A+B | Rem], mul);
sum_mul3([A,B | Rem], mul) ->
    sum_mul3([A*B | Rem], add).

gcd(X, X) -> %when X==Y -> 
    X;
gcd(X, Y) when X > Y ->
    gcd(X-Y, Y);
gcd(X, Y) ->
    gcd(X, Y-X).

% Last login: Wed Feb 18 10:54:42 on ttys004
% melindatoth@MacBook-Pro ~ % cd Desktop/fp2 
% melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(first).
% {ok,first}
% 2> first:foo(12).
% {value,13}
% 3> c(first).
% {ok,first}
% 4> first:foo(12).
% {value,13}
% 5> first:foo(1).
% 42
% 6> pwd().
% /Users/melindatoth/Desktop/fp2
% ok
% 7> ls().
% .DS_Store      first.beam     first.erl      second.erl     slides         

% ok
% 8> ls.
% ls
% 9> c("second.erl").
% {ok,second}
% 10> c(second).
% {ok,second}
% 11> c("/Users/melindatoth/Desktop/fp2/second.erl")
%     .
% {ok,second}
% 12> c("../fp2/second.erl")
%     .
% {ok,second}
% 13> cd("..")
%     .
% /Users/melindatoth/Desktop
% ok
% 14> cd("alma").
% /Users/melindatoth/Desktop
% ok
% 15> ls().
% .DS_Store                                    
% .localized                                   
% HAB25                                        
%....
% ~$sec_cod_rules.xlsx                         

% ok
% 16> os:cmd("ls").
% [72,65,66,50,53,10,72,65,66,50,53,46,122,105,112,10,77,65,
%  66,10,77,69,71,72,73,769,86,79,769|...]
% 17> io:format("~p~n", [os:cmd("ls")]).
% [72,65,66,50,53,10,72,65,66,50,53,46,122,105,112,10,77,65,66,10,77,69,71,72,
%  73,769,86,79,769,95,69,76,84,69,95,84,75,80,95,90,97,769,114,111,769,95,50,
%  54,48,49,49,52,46,112,100,102,10,77,82,75,10,83,99,114,101,101,110,83,10,83,
%  99,114,101,101,110,115,104,111,116,32,50,48,50,54,45,48,50,45,49,55,32,97,
%  116,32,49,54,46,49,49,46,52,53,46,112,110,103,10,83,99,114,101,101,110,115,
%  104,111,116,32,50,48,50,54,45,48,50,45,49,55,32,97,116,32,49,54,46,49,49,46,
%  53,54,46,112,110,103,10,84,75,80,50,48,50,49,95,116,101,769,109,97,118,101,
%  122,101,116,111,779,107,110,101,107,46,100,111,99,120,10,97,115,115,101,115,
%  109,101,110,116,46,100,111,99,120,10,100,100,115,10,100,101,112,119,115,95,
%  50,54,10,101,114,108,119,115,95,50,53,10,102,112,50,10,105,99,102,112,10,109,
%  101,110,116,111,114,97,769,108,116,95,109,101,115,116,101,114,107,101,769,
%  112,122,101,769,115,95,106,97,118,97,115,108,97,116,95,107,101,115,122,46,
%  100,111,99,120,10,112,114,105,118,10,112,114,111,106,101,107,116,108,97,98,
%  111,114,46,100,111,99,120,10,115,101,99,95,99,111,100,95,114,117,108,101,115,
%  46,120,108,115,120,10,126,36,101,115,116,105,111,110,110,97,105,114,101,32,
%  102,111,114,32,112,97,114,116,110,101,114,115,45,32,72,117,110,103,97,114,
%  121,46,100,111,99,120,10,126,36,115,101,99,95,99,111,100,95,114,117,108,101,
%  115,46,120,108,115,120,10]
% ok
% 18> io:format("~s~n", [os:cmd("ls")]).
% ** exception error: bad argument
%      in function  io:format/2
%         called as io:format("~s~n",
%                             [[72,65,66,50,53,10,72,65,66,50,53,46,122,105,112,
%                               10,77,65,66,10,77,69,71,72,73,769|...]])
%         *** argument 1: failed to format string
% 19> c("../fp2/second.erl").
% ../fp2/second.erl: no such file or directory
% error
% 20> pwd().
% /Users/melindatoth/Desktop
% ok
% 21> cd("./fp2").
% /Users/melindatoth/Desktop/fp2
% ok
% 22> c("../fp2/second.erl").
% {ok,second}
% 23> c(second).
% {ok,second}
% 24> code:get_path().
% ["/opt/homebrew/Cellar/elixir/1.18.4/lib/elixir/lib/elixir/ebin",
%  ".",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/kernel-10.3.1/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/stdlib-7.0.1/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/xmerl-2.1.5/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/wx-2.5/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/tools-4.1.2/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/tftp-1.2.3/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/syntax_tools-4.0/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/ssl-11.3.1/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/ssh-5.3.1/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/snmp-5.19/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/sasl-4.3/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/runtime_tools-2.2/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/reltool-1.0.2/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/public_key-1.18.1/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/parsetools-2.7/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/os_mon-2.11/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/odbc-2.16/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/observer-2.18/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/mnesia-4.24/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/megaco-4.8/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/inets-9.4/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/ftp-1.2.4/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/eunit-2.10/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/et-1.7.2/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/erts-16.0.1/ebin",
%  "/opt/homebrew/Cellar/erlang/28.0.1/lib/erlang/lib/erl_interface-5.6/ebin",
%  [...]|...]
% 25> c(second).
% {ok,second}
% 26> c(second).
% second.erl:9:1: Warning: function foo/0 is unused
% %    9| foo() -> sum([]).
% %     | ^

% {ok,second}
% 27> c(second).
% {ok,second}
% 28> c(second).
% {ok,second}
% 29> c(second).
% second.erl:5:11: type posjjk_integer() undefined
% %    5| -spec(sum(posjjk_integer()) -> pos_integer()).
% %     |           ^

% error
% 30> c(second).
% second.erl:5:2: spec for undefined function suum/1
% %    5| -spec(suum(pos_integer()) -> pos_integer()).
% %     |  ^

% error
% 31> c(second).
% {ok,second}
% 32> second:sum([]).
% ** exception error: an error occurred when evaluating an arithmetic expression
%      in operator  -/2
%         called as [] - 1
%      in call from second:sum/1 (second.erl:9)
% 33> second:sum(-2).

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(second).
% {ok,second}
% 2> second:sum(-3).
% ** exception error: no function clause matching second:sum(-3) (second.erl:6)
% 3> second:sum([]).
% ** exception error: an error occurred when evaluating an arithmetic expression
%      in operator  -/2
%         called as [] - 1
%      in call from second:sum/1 (second.erl:9)
% 4> c(second).
% {ok,second}
% 5> second:sum([]).
% ** exception error: no function clause matching second:sum([]) (second.erl:6)
% 6> erlang:+(1,2).
% * 1:8: syntax error before: '+'
% 6> erlang:'+'(1,2).
% 3
% 7> 23.
% 23
% 8> 2#10101.
% 21
% 9> <<2>>.
% <<2>>
% 10> <<1,2>>.
% <<1,2>>
% 11> X = <<1,2>>.
% <<1,2>>
% 12> X = <<1:4,2:4>>.
% ** exception error: no match of right hand side value <<18>>
% 13> XX = <<1:4,2:4>>.
% <<18>>
% 14> atom.
% atom
% 15> 1==2.
% false
% 16> false == true.
% false
% 17> A = {X, XX}.
% {<<1,2>>,<<18>>}
% 18> A.
% {<<1,2>>,<<18>>}
% 19> element(2,A).
% <<18>>
% 20> {K, L} = A.
% {<<1,2>>,<<18>>}
% 21> {_, L} = A.
% {<<1,2>>,<<18>>}
% 22> [a,b,c,d].
% [a,b,c,d]
% 23> [12,13 | [23,24]].
% [12,13,23,24]
% 24> [12,13 | X].
% [12,13|<<1,2>>]
% 25> c(second).
% second.erl:14:1: function sum/1 already defined
% %   14| sum([]) -> 0;
% %     | ^

% error
% 26> c(second).
% second.erl:14:1: Warning: function sum_list/1 is unused
% %   14| sum_list([]) -> 0;
% %     | ^

% {ok,second}
% 27> second:sum_mul([2,3,4,4,5]).
% 120
% 28> c(second).
% second.erl:14:1: Warning: function sum_list/1 is unused
% %   14| sum_list([]) -> 0;
% %     | ^

% {ok,second}
% 29> second:sum_mul2([2,3,4,4,5]).
% 120
% 30> c(second, [export_all]).
% {ok,second}
% 31> second:sum_mul3([2,3,4,4,5]).
% 120
% 32> c(second, [export_all]).
% {ok,second}
% 33> second:gcd(12, 18).
% 6
% 34> 

