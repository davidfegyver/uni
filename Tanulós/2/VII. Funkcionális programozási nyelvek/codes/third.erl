-module(third).
-compile(export_all).

count(E, [E | Rest]) ->
    1 + count(E, Rest);
count(E, [_ | Rest]) ->
    count(E, Rest);
count(_, []) ->
    0.

count_(E, L) ->
    length([ 1 || H <- L, E =:= H ]).

freq1(L) ->
    List = lists:uniq([ {E, count(E, L)} || E <- L]).%,
    %List = lists:uniq(lists:map(fun(E) -> {E, count(E, L)} end, L)).

freq2([]) -> [];
freq2([H | Rest]) ->
    [{H, 1+ count(H, Rest)} | freq2([X || X <- Rest, X /= H])].

count_del(E, [E | Rest]) ->
    {Sum, Rem} = count_del(E, Rest),
    {Sum+1, Rem};
count_del(E, [R | Rest]) ->
    {Sum, Rem} = count_del(E, Rest),
    {Sum, [R | Rem]};
count_del(_, []) ->
    {0, []}.

freq3([H | Rest]) ->
    {Sum, Rem} = count_del(H, Rest),
    [{H, Sum+1} | freq3(Rem)];
freq3([]) -> [].

freq4(L) -> freq4(L, []).

% freq4([H | Rest], Visited) ->
%     V = case lists:member(H, Visited) of
%         true -> V = freq4(Rest, Visited);
%         false -> V = [{H, 1+count(H, Rest)} | freq4(Rest, [H|Visited])
%     end, 
%     V;
% freq4([], _) ->
%     [].
freq4([H | Rest], Visited) ->
    case lists:member(H, Visited) of
        true -> freq4(Rest, Visited);
        false -> [{H, 1+count(H, Rest)} | freq4(Rest, [H|Visited])]
    end;
freq4([], _) ->
    [].

freq5(L) ->
    freq5(L, []).

freq5([H | Rest], Acc) ->
    case lists:keymember(H, 1,  Acc) of
        true -> freq5(Rest, Acc);
        false -> freq5(Rest, [{H, count(H, Rest) + 1} | Acc])
    end;
freq5([], Acc) ->
    Acc.

freq6(L) -> freq6(L, []).

freq6([H | Rest], Acc) ->
    case lists:keyfind(H, 1,  Acc) of
        {H, Count} -> freq6(Rest, [{H, Count+1} | lists:keydelete(H, 1, Acc)]);
        false -> freq6(Rest, [{H, 1} | Acc])
    end;
freq6([], Acc) ->
    Acc.

freq7(L) -> freq7(L, #{}).

freq7([H|Rest], Acc) ->
    case Acc of
        #{H := Count} -> freq7(Rest, Acc#{H:=Count+1});
        _ -> freq7(Rest, Acc#{H=>1})
    end;
freq7([], Acc) -> 
    Acc. %% maps:to_list(Acc)

% Last login: Wed Feb 25 11:07:13 on ttys002
% melindatoth@MacBook-Pro ~ % cd Desktop/fp2 
% melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(second).
% second.erl:14:1: Warning: function sum_list/1 is unused
% %   14| sum_list([]) -> 0;
% %     | ^

% second.erl:32:1: Warning: function sum_mul3/1 is unused
% %   32| sum_mul3(L) ->
% %     | ^

% second.erl:35:1: Warning: function sum_mul3/2 is unused
% %   35| sum_mul3([], _) -> 0;
% %     | ^

% second.erl:42:1: Warning: function gcd/2 is unused
% %   42| gcd(X, Y) when X==Y -> 
% %     | ^

% {ok,second}
% 2> c(second, [export_all]).
% {ok,second}
% 3> second:gcd(3,3).
% 3
% 4> second:gcd(3,18).
% 3
% 5> second:gcd(12,18).
% 6
% 6> c(second, [export_all]).
% {ok,second}
% 7> second:gcd(12,18).
% 6
% 8> second:gcd(3,3).
% 3
% 9> second:gcd(3,3.0).
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt

% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> 3 == 3.0.
% true
% 2> c(second, [export_all]).
% {ok,second}
% 3> second:gcd(3,3.0).
% 3
% 4> 3 > 3.0.
% false
% 5> 3 =:= 3.0.
% false
% 6> [1,2,1,3] -> [{1, 2}, {2, 1}, {3, 1}].
% * 1:11: syntax error before: '->'
% 6> c(third).
% third.erl:3:1: Warning: function count/2 is unused
% %    3| count(E, [E | Rest]) ->
% %     | ^

% third.erl:10:1: Warning: function freq1/1 is unused
% %   10| freq1(L) ->
% %     | ^

% {ok,third}
% 7> c(third, [export_all]).
% {ok,third}
% 8> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 9> third:freq([1,2,1,3]).
% ** exception error: undefined function third:freq/1
% 10> third:freq1([1,2,1,3]).
% [2,1,2,1]
% 11> third:freq1([1,2,1,3]).
% [2,1,2,1]
% 12> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 13> third:freq1([1,2,1,3]).
% [{1,2},{2,1},{1,2},{3,1}]
% 14> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% third.erl:11:8: Warning: variable 'E' is unused
% %   11| count_(E, L) ->
% %     |        ^

% third.erl:12:19: Warning: variable 'E' is unused
% %   12|     length([ 1 || E <- L ]).
% %     |                   ^

% third.erl:12:19: Warning: variable 'E' shadowed in generate
% %   12|     length([ 1 || E <- L ]).
% %     |                   ^

% {ok,third}
% 15> third:freq1([1,2,1,3]).
% [{1,4},{2,4},{1,4},{3,4}]
% 16> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% third.erl:13:19: Warning: variable 'E' is unused
% %   13|     length([ 1 || E <- L ]).
% %     |                   ^

% third.erl:13:19: Warning: variable 'E' shadowed in generate
% %   13|     length([ 1 || E <- L ]).
% %     |                   ^

% {ok,third}
% 17> third:freq1([1,2,1,3]).
% ** exception error: no match of right hand side value 1
%      in function  third:count_/2 (third.erl:12)
%      in call from third:'-freq1/1-lc$^0/1-0-'/2 (third.erl:16)
%      in call from third:'-freq1/1-lc$^0/1-0-'/2 (third.erl:16)
% 18> beam_disasm:file(third).
% {beam_file,third,
%            [{count,2,2},
%             {count_,2,6},
%             {freq1,1,9},
%             {module_info,0,11},
%             {module_info,1,13}],
%            [{vsn,[15829951787246902991394405807962612963]}],
%            [{version,"9.0"},
%             {options,[]},
%             {source,"/Users/melindatoth/Desktop/fp2/third.erl"}],
%            [{function,count,2,2,
%                       [{label,1},
%                        {line,1},
%                        {func_info,{atom,third},{atom,count},2},
%                        {label,2},
%                        {test,is_nonempty_list,{f,4},[{x,1}]},
%                        {get_list,{x,1},{x,2},{x,1}},
%                        {test,is_eq_exact,{f,3},[{x,2},{x,0}]},
%                        {allocate,0,2},
%                        {line,2},
%                        {call,2,{third,count,2}},
%                        {gc_bif,'+',{f,0},1,[{...}|...],{...}},
%                        {deallocate,0},
%                        return,
%                        {label,3},
%                        {call_only,2,...},
%                        {label,...},
%                        {...}|...]},
%             {function,count_,2,6,
%                       [{line,3},
%                        {label,5},
%                        {func_info,{atom,third},{atom,count_},2},
%                        {label,6},
%                        {test,is_eq_exact,{f,7},[{x,0},{integer,1}]},
%                        {allocate,0,2},
%                        {move,{x,1},{x,0}},
%                        {line,4},
%                        {call,1,{third,'-count_/2-lc$^0/1-0-',1}},
%                        {gc_bif,length,{f,0},1,[{...}],{...}},
%                        {deallocate,0},
%                        return,
%                        {label,7},
%                        {line,5},
%                        {badmatch,...}]},
%             {function,freq1,1,9,
%                       [{line,6},
%                        {label,8},
%                        {func_info,{atom,third},{atom,freq1},1},
%                        {label,9},
%                        {move,{x,0},{x,1}},
%                        {call_only,2,{third,'-freq1/1-lc$^0/1-0-',2}}]},
%             {function,module_info,0,11,
%                       [{line,0},
%                        {label,10},
%                        {func_info,{atom,third},{atom,module_info},0},
%                        {label,11},
%                        {move,{atom,third},{x,0}},
%                        {call_ext_only,1,{extfunc,erlang,get_module_info,1}}]},
%             {function,module_info,1,13,
%                       [{line,0},
%                        {label,12},
%                        {func_info,{atom,third},{atom,module_info},1},
%                        {label,13},
%                        {move,{x,0},{x,1}},
%                        {move,{atom,third},{x,0}},
%                        {call_ext_only,2,
%                                       {extfunc,erlang,get_module_info,...}}]},
%             {function,'-freq1/1-lc$^0/1-0-',2,15,
%                       [{line,7},
%                        {label,14},
%                        {func_info,{atom,third},{atom,'-freq1/1-lc$^0/1-0-'},2},
%                        {label,15},
%                        {test,is_nonempty_list,{f,16},[{x,0}]},
%                        {allocate,3,2},
%                        {move,{x,1},{y,2}},
%                        {get_list,{x,0},{y,...},{...}},
%                        {move,{y,...},{...}},
%                        {call,2,...},
%                        {move,...},
%                        {...}|...]},
%             {function,'-count_/2-lc$^0/1-0-',1,19,
%                       [{line,4},
%                        {label,18},
%                        {func_info,{atom,third},
%                                   {atom,'-count_/2-lc$^0/1-0-'},
%                                   1},
%                        {label,19},
%                        {test,is_nonempty_list,{f,20},[{x,...}]},
%                        {allocate,0,1},
%                        {get_tl,{x,0},{x,...}},
%                        {call,1,{...}},
%                        {test_heap,2,...},
%                        {put_list,...},
%                        {...}|...]}]}
% 19> rp(beam_disasm:file(third)).
% {beam_file,third,
%            [{count,2,2},
%             {count_,2,6},
%             {freq1,1,9},
%             {module_info,0,11},
%             {module_info,1,13}],
%            [{vsn,[15829951787246902991394405807962612963]}],
%            [{version,"9.0"},
%             {options,[]},
%             {source,"/Users/melindatoth/Desktop/fp2/third.erl"}],
%            [{function,count,2,2,
%                       [{label,1},
%                        {line,1},
%                        {func_info,{atom,third},{atom,count},2},
%                        {label,2},
%                        {test,is_nonempty_list,{f,4},[{x,1}]},
%                        {get_list,{x,1},{x,2},{x,1}},
%                        {test,is_eq_exact,{f,3},[{x,2},{x,0}]},
%                        {allocate,0,2},
%                        {line,2},
%                        {call,2,{third,count,2}},
%                        {gc_bif,'+',
%                                {f,0},
%                                1,
%                                [{tr,{x,0},{t_integer,{0,'+inf'}}},{integer,1}],
%                                {x,0}},
%                        {deallocate,0},
%                        return,
%                        {label,3},
%                        {call_only,2,{third,count,2}},
%                        {label,4},
%                        {test,is_nil,{f,1},[{x,1}]},
%                        {move,{integer,0},{x,0}},
%                        return]},
%             {function,count_,2,6,
%                       [{line,3},
%                        {label,5},
%                        {func_info,{atom,third},{atom,count_},2},
%                        {label,6},
%                        {test,is_eq_exact,{f,7},[{x,0},{integer,1}]},
%                        {allocate,0,2},
%                        {move,{x,1},{x,0}},
%                        {line,4},
%                        {call,1,{third,'-count_/2-lc$^0/1-0-',1}},
%                        {gc_bif,length,
%                                {f,0},
%                                1,
%                                [{tr,{x,0},{t_list,any,any}}],
%                                {x,0}},
%                        {deallocate,0},
%                        return,
%                        {label,7},
%                        {line,5},
%                        {badmatch,{integer,1}}]},
%             {function,freq1,1,9,
%                       [{line,6},
%                        {label,8},
%                        {func_info,{atom,third},{atom,freq1},1},
%                        {label,9},
%                        {move,{x,0},{x,1}},
%                        {call_only,2,{third,'-freq1/1-lc$^0/1-0-',2}}]},
%             {function,module_info,0,11,
%                       [{line,0},
%                        {label,10},
%                        {func_info,{atom,third},{atom,module_info},0},
%                        {label,11},
%                        {move,{atom,third},{x,0}},
%                        {call_ext_only,1,{extfunc,erlang,get_module_info,1}}]},
%             {function,module_info,1,13,
%                       [{line,0},
%                        {label,12},
%                        {func_info,{atom,third},{atom,module_info},1},
%                        {label,13},
%                        {move,{x,0},{x,1}},
%                        {move,{atom,third},{x,0}},
%                        {call_ext_only,2,{extfunc,erlang,get_module_info,2}}]},
%             {function,'-freq1/1-lc$^0/1-0-',2,15,
%                       [{line,7},
%                        {label,14},
%                        {func_info,{atom,third},{atom,'-freq1/1-lc$^0/1-0-'},2},
%                        {label,15},
%                        {test,is_nonempty_list,{f,16},[{x,0}]},
%                        {allocate,3,2},
%                        {move,{x,1},{y,2}},
%                        {get_list,{x,0},{y,1},{y,0}},
%                        {move,{y,1},{x,0}},
%                        {call,2,{third,count_,2}},
%                        {move,{y,0},{x,2}},
%                        {move,{y,2},{x,1}},
%                        {move,{x,0},{y,2}},
%                        {trim,1,2},
%                        {move,{x,2},{x,0}},
%                        {call,2,{third,'-freq1/1-lc$^0/1-0-',2}},
%                        {test_heap,5,1},
%                        {put_tuple2,{x,1},{list,[{y,0},{y,1}]}},
%                        {put_list,{x,1},{x,0},{x,0}},
%                        {deallocate,2},
%                        return,
%                        {label,16},
%                        {test,is_nil,{f,17},[{x,0}]},
%                        return,
%                        {label,17},
%                        {test_heap,3,1},
%                        {put_tuple2,{x,0},{list,[{atom,bad_generator},{x,0}]}},
%                        {call_ext_only,1,{extfunc,erlang,error,1}}]},
%             {function,'-count_/2-lc$^0/1-0-',1,19,
%                       [{line,4},
%                        {label,18},
%                        {func_info,{atom,third},
%                                   {atom,'-count_/2-lc$^0/1-0-'},
%                                   1},
%                        {label,19},
%                        {test,is_nonempty_list,{f,20},[{x,0}]},
%                        {allocate,0,1},
%                        {get_tl,{x,0},{x,0}},
%                        {call,1,{third,'-count_/2-lc$^0/1-0-',1}},
%                        {test_heap,2,1},
%                        {put_list,{integer,1},{x,0},{x,0}},
%                        {deallocate,0},
%                        return,
%                        {label,20},
%                        {test,is_nil,{f,21},[{x,0}]},
%                        return,
%                        {label,21},
%                        {test_heap,3,1},
%                        {put_tuple2,{x,0},{list,[{atom,bad_generator},{x,0}]}},
%                        {call_ext_only,1,{extfunc,erlang,error,1}}]}]}
% ok
% 20> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 21> third:freq1([1,2,1,3]).
% [{1,2},{2,1},{1,2},{3,1}]
% 22> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 23> third:freq1([1,2,1,3]).
% [{1,2},{2,1},{3,1}]
% 24> c(third).
% third.erl:16:5: syntax error before: List
% %   16|     List = lists:uniq(lists:map(fun(E) -> {1, count(E, L)} end, L)).
% %     |     ^

% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% error
% 25> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 26> third:freq1([1,2,1,3]).
% ** exception error: no match of right hand side value [{1,2},{1,1}]
%      in function  third:freq1/1 (third.erl:16)
% 27> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 28> third:freq1([1,2,1,3]).
% [{1,2},{2,1},{3,1}]
% 29> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 30> third:freq2([1,2,1,3]).
% [{1,2},{2,1},{1,1},{3,1}]
% 31> lists:delete(1, [1,1]).
% [1]
% 32> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 33> third:freq2([1,2,1,3]).
% [{1,2},{2,1},{3,1}]
% 34> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 35> third:freq3([1,2,1,3]).
% [{1,2},{2,1},{3,1}]
% 36> c(third).
% third.erl:38:33: illegal guard expression
% %   38| freq4([H | Rest], Visited) when lists:member(H, Visited) ->
% %     |                                 ^

% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% third.erl:38:8: Warning: variable 'H' is unused
% %   38| freq4([H | Rest], Visited) when lists:member(H, Visited) ->
% %     |        ^

% error
% 37> c(third).
% third.erl:50:5: syntax error before: 'end'
% %   50|     end;
% %     |     ^

% third.erl:36:13: function freq4/2 undefined, did you mean freq4/1?
% %   36| freq4(L) -> freq4(L, []).
% %     |             ^

% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% error
% 38> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 39> third:freq4([1,2,1,3]).
% [{1,2},{2,1},{3,1}]
% 40> h(lists, keymember, 3).

%   -spec keymember(Key, N, TupleList) -> boolean()
%                      when
%                          Key :: term(),
%                          N :: pos_integer(),
%                          TupleList :: [Tuple],
%                          Tuple :: tuple().

%   Returns true if TupleList contains a tuple whose Nth element
%   compares equal to Key; otherwise, returns false.

% Examples
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% more (y/n)? (y) n
% ok
% 41> c(third).
% third.erl:57:18: syntax error before: ','
% %   57| freq5(([H | Rest], Acc) ->
% %     |                  ^

% third.erl:55:5: function freq5/2 undefined, did you mean freq5/1?
% %   55|     freq5(L, []).
% %     |     ^

% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% error
% 42> h(lists, keymember, 3).

%   -spec keymember(Key, N, TupleList) -> boolean()
%                      when
%                          Key :: term(),
%                          N :: pos_integer(),
%                          TupleList :: [Tuple],
%                          Tuple :: tuple().

%   Returns true if TupleList contains a tuple whose Nth element
%   compares equal to Key; otherwise, returns false.

% Examples
% more (y/n)? (y) n
% ok
% 43> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 44> third:freq5([1,2,1,3]).
% [{3,1},{2,1},{1,2}]
% 45> h(lists, keyfind, 3).

%   -spec keyfind(Key, N, TupleList) -> Tuple | false
%                    when
%                        Key :: term(),
%                        N :: pos_integer(),
%                        TupleList :: [Tuple],
%                        Tuple :: tuple().

%   Searches the list of tuples TupleList for a tuple whose Nth
%   element compares equal to Key.

%   Returns Tuple if such a tuple is found; otherwise, returns 
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% more (y/n)? (y) c(third).n
% more (y/n)? (y) n
% ok
% 46> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 47> third:freq6([1,2,1,3]).
% [{3,1},{2,1},{1,1}]
% 48> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 49> third:freq6([1,2,1,3]).
% [{3,1},{1,2},{2,1},{1,1}]
% 50> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 51> third:freq6([1,2,1,3]).
% [{3,1},{1,2},{2,1}]
% 52> #{alma => 12}.
% #{alma => 12}
% 53> #{alma => 12, korte => 34}.
% #{alma => 12,korte => 34}
% 54> [{alma, 12}, {korte, 34}].
% [{alma,12},{korte,34}]
% 55> Map = #{alma => 12, korte => 34}.
% #{alma => 12,korte => 34}
% 56> #{alma => LL} = Map.
% * 1:8: illegal pattern, did you mean to use `:=`?
% 57> #{alma := LL} = Map.
% #{alma => 12,korte => 34}
% 58> LL.
% 12
% 59> Map#{alma=>42}.
% #{alma => 42,korte => 34}
% 60> Map.
% #{alma => 12,korte => 34}
% 61> Map#{alma:=42}.
% #{alma => 42,korte => 34}
% 62> Map#{almaaaa=>42}.
% #{alma => 12,korte => 34,almaaaa => 42}
% 63> Map#{alma=>42}.
% #{alma => 42,korte => 34}
% 64> Map#{almaaaa:=42}.
% ** exception error: bad key: almaaaa
%      in function  maps:update/3
%         called as maps:update(almaaaa,42,#{alma => 12,korte => 34})
%         *** argument 1: not present in map
%      in call from erl_eval:'-expr/6-fun-0-'/2 (erl_eval.erl:470)
%      in call from lists:foldl/3 (lists.erl:2466)
% 65> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% {ok,third}
% 66> third:freq6([1,2,1,3]).
% [{3,1},{1,2},{2,1}]
% 67> third:freq7([1,2,1,3]).
% #{1 => 2,2 => 1,3 => 1}
% 68> timer:tc(third, freq7, [lists:seq(1, 1000)]).
% {296,
%  #{631 => 1,641 => 1,830 => 1,965 => 1,642 => 1,467 => 1,
%    54 => 1,939 => 1,319 => 1,955 => 1,531 => 1,792 => 1,
%    18 => 1,169 => 1,513 => 1,648 => 1,926 => 1,96 => 1,
%    426 => 1,552 => 1,960 => 1,371 => 1,522 => 1,94 => 1,
%    666 => 1,359 => 1,944 => 1,...}}
% 69> timer:tc(third, freq7, [lists:seq(1, 10000)]).
% {4733,
%  #{3399 => 1,2430 => 1,8304 => 1,7206 => 1,5732 => 1,3058 => 1,
%    8341 => 1,8646 => 1,8670 => 1,5951 => 1,631 => 1,9480 => 1,
%    6543 => 1,6526 => 1,3628 => 1,5833 => 1,3650 => 1,8226 => 1,
%    641 => 1,2704 => 1,6493 => 1,1910 => 1,1907 => 1,9531 => 1,
%    3769 => 1,3328 => 1,2335 => 1,...}}
% 70> timer:tc(third, freq6, [lists:seq(1, 10000)]).
% {88492,
%  [{10000,1},
%   {9999,1},
%   {9998,1},
%   {9997,1},
%   {9996,1},
%   {9995,1},
%   {9994,1},
%   {9993,1},
%   {9992,1},
%   {9991,1},
%   {9990,1},
%   {9989,1},
%   {9988,1},
%   {9987,1},
%   {9986,1},
%   {9985,1},
%   {9984,1},
%   {9983,1},
%   {9982,1},
%   {9981,1},
%   {9980,1},
%   {9979,1},
%   {9978,1},
%   {9977,1},
%   {9976,1},
%   {9975,...},
%   {...}|...]}
% 71> timer:tc(third, freq6, [lists:seq(1, 100000)]).
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% {5468234,
%  [{100000,1},
%   {99999,1},
%   {99998,1},
%   {99997,1},
%   {99996,1},
%   {99995,1},
%   {99994,1},
%   {99993,1},
%   {99992,1},
%   {99991,1},
%   {99990,1},
%   {99989,1},
%   {99988,1},
%   {99987,1},
%   {99986,1},
%   {99985,1},
%   {99984,1},
%   {99983,1},
%   {99982,1},
%   {99981,1},
%   {99980,1},
%   {99979,1},
%   {99978,1},
%   {99977,1},
%   {99976,1},
%   {99975,...},
%   {...}|...]}
% 72> timer:tc(third, freq7, [lists:seq(1, 100000)]).
% {48224,
%  #{38649 => 1,3399 => 1,70024 => 1,91962 => 1,90816 => 1,
%    2430 => 1,58338 => 1,90323 => 1,94274 => 1,52914 => 1,
%    26268 => 1,74871 => 1,49592 => 1,85884 => 1,57993 => 1,
%    38555 => 1,28080 => 1,74764 => 1,50061 => 1,60216 => 1,
%    58596 => 1,47656 => 1,47814 => 1,43917 => 1,89092 => 1,
%    25219 => 1,33506 => 1,...}}
% 73> c(third).
% third.erl:2:2: Warning: export_all flag enabled - all functions will be exported
% %    2| -compile(export_all).
% %     |  ^

% third.erl:15:5: Warning: variable 'List' is unused
% %   15|     List = lists:uniq([ {E, count(E, L)} || E <- L]).%,
% %     |     ^

% {ok,third}
% 74> timer:tc(third, freq1, [lists:seq(1, 100000)]).
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% {9519806,
%  [{1,1},
%   {2,1},
%   {3,1},
%   {4,1},
%   {5,1},
%   {6,1},
%   {7,1},
%   {8,1},
%   {9,1},
%   {10,1},
%   {11,1},
%   {12,1},
%   {13,1},
%   {14,1},
%   {15,1},
%   {16,1},
%   {17,1},
%   {18,1},
%   {19,1},
%   {20,1},
%   {21,1},
%   {22,1},
%   {23,1},
%   {24,1},
%   {25,1},
%   {26,...},
%   {...}|...]}
% 75> 
