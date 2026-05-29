-module(fourth).
%% error handling
%% dynamic calls
%% funs, HOFs
%% recursive lambda
%% parallel comprehension
%% 
gcd(A, B) ->
    Fun = fun(_, X, X) -> X;
             (Func, X, Y) when X > Y -> Func(Func, X-Y, Y);
             (Func, X, Y) -> Func(Func, X, Y-X)
        end,
    Fun2 = fun F(X, X) -> X;
             F(X, Y) when X > Y -> F(X-Y, Y);
             F(X, Y) -> F(X, Y-X)
        end,
    {Fun(Fun, A, B), Fun2(A,B)}.

eval() ->
    try
        {ok, Mod} = io:read("Module name> "),
        Exports = Mod:module_info(exports),
        {ok, Fun} = io:read("Function name> "),
        {Fun, Arity} = lists:keyfind(Fun, 1, Exports),
        Args = [begin 
                    {ok, Par} = io:read("Argument "++integer_to_list(X) ++ "> "),
                    Par
                end  || X<- lists:seq(1, Arity)]
        % Args2 = lists:map(fun(X) -> 
        %                     {ok, Par} = io:read("Argument "++integer_to_list(X) ++ "> "),
        %                     Par
        % end, lists:seq(1, Arity))
    of 
       _ -> apply(Mod, Fun, Args)
    catch 
        % EClass:EType -> ...
        % EClass:EType:StackTrace -> {EClass, EType, StackTrace}
        _:{badmatch, false} -> "Function does not exist";
        _:{badmatch, _}:_ -> "The provided input is not an Erlang term";
        _:badarg -> "Module name is not an atom";
        _:undef -> "Module does not exist"
    after 
        io:format("ALmaaaaaaaaa~n")
    end,
    io:format("ALmaaaaaaaaa2~n").

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> third:freq2(alma).
% ** exception error: no function clause matching third:freq2(alma) (third.erl:18)
% 2> catch third:freq2(alma).
% {'EXIT',{function_clause,[{third,freq2,
%                                  [alma],
%                                  [{file,"third.erl"},{line,18}]},
%                           {erl_eval,do_apply,7,
%                                     [{file,"erl_eval.erl"},{line,924}]},
%                           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%                           {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%                           {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%                           {shell,eval_loop,4,
%                                  [{file,"shell.erl"},{line,878}]}]}}
% 3> catch lists:max([]).
% {'EXIT',{function_clause,[{lists,max,
%                                  [[]],
%                                  [{file,"lists.erl"},{line,637}]},
%                           {erl_eval,do_apply,7,
%                                     [{file,"erl_eval.erl"},{line,924}]},
%                           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%                           {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%                           {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%                           {shell,eval_loop,4,
%                                  [{file,"shell.erl"},{line,878}]}]}}
% 4> catch hd([]).
% {'EXIT',{badarg,[{erlang,hd,
%                          [[]],
%                          [{error_info,#{module => erl_erts_errors}}]},
%                  {erl_eval,do_apply,7,[{file,"erl_eval.erl"},{line,924}]},
%                  {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%                  {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%                  {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%                  {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}}
% 5> hd([]).
% ** exception error: bad argument
%      in function  hd/1
%         called as hd([])
%         *** argument 1: not a nonempty list
% 6> hd(alma).
% ** exception error: bad argument
%      in function  hd/1
%         called as hd(alma)
%         *** argument 1: not a nonempty list
% 7> length(alma).
% ** exception error: bad argument
%      in function  length/1
%         called as length(alma)
%         *** argument 1: not a list
% 8> X = 2.
% 2
% 9> X = 1.
% ** exception error: no match of right hand side value 1
% 10> catch X = 1.
% {'EXIT',{{badmatch,1},
%          [{erl_eval,expr,6,[{file,"erl_eval.erl"},{line,672}]},
%           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%           {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%           {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%           {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}}
% 11> catch third:freq2222(alma).
% {'EXIT',{undef,[{third,freq2222,[alma],[]},
%                 {erl_eval,do_apply,7,[{file,"erl_eval.erl"},{line,924}]},
%                 {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%                 {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%                 {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%                 {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}}
% 12> catch 1/0.
% {'EXIT',{badarith,[{erlang,'/',
%                            [1,0],
%                            [{error_info,#{module => erl_erts_errors}}]},
%                    {erl_eval,do_apply,7,[{file,"erl_eval.erl"},{line,924}]},
%                    {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%                    {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%                    {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%                    {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}}
% 13> Fun = fun(X) -> X + 3 end.
% #Fun<erl_eval.42.113135111>
% 14> Fun2 = lists:nth/2.
% * 1:8: illegal expression
% 15> Fun2 = fun lists:nth/2.
% fun lists:nth/2
% 16> Fun(45).
% 48
% 17> length([]).
% 0
% 18> Mod = lists.
% lists
% 19> Fun = max.
% ** exception error: no match of right hand side value max
% 20> Mod:Fun([3]).
% ** exception error: no function clause matching 
%                     erl_internal:bif(lists,#Fun<erl_eval.42.113135111>,1) (erl_internal.erl:262)
% 21> FunName = max.
% max
% 22> Mod:FunName([3]).
% 3
% 23> Fun2(3, [a,b,c,d]).
% c
% 24> Fun2(3).
% ** exception error: lists:nth/2 called with one argument
% 25> catch Fun2(3).
% {'EXIT',{{badarity,{fun lists:nth/2,[3]}},
%          [{shell,apply_fun,3,[{file,"shell.erl"},{line,1172}]},
%           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%           {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%           {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%           {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}}
% 26> Mod(3).
% ** exception error: bad function lists
% 27> catch Mod(3).
% {'EXIT',{{badfun,lists},
%          [{shell,apply_fun,3,[{file,"shell.erl"},{line,1172}]},
%           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%           {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%           {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%           {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}}
% 28> Mod#{alma=>2}.
% ** exception error: bad map: lists
%      in function  maps:put/3
%         called as maps:put(k,v,lists)
%         *** argument 3: not a map
% 29> catch Mod#{alma=>2}.
% {'EXIT',{{badmap,lists},
%          [{maps,put,
%                 [k,v,lists],
%                 [{error_info,#{module => erl_stdlib_errors}}]},
%           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,466}]},
%           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%           {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%           {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%           {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}}
% 30> Map = #{}.
% #{}
% 31> #{alma:=Value} = Map.
% ** exception error: no match of right hand side value #{}
% 32> catch #{alma:=Value} = Map.
% {'EXIT',{{badmatch,#{}},
%          [{erl_eval,expr,6,[{file,"erl_eval.erl"},{line,672}]},
%           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%           {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%           {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%           {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}}
% 33> catch Map#{alma=>Value}.
% * 1:18: variable 'Value' is unbound
% 34> catch Map#{alma=>value}.
% #{alma => value}
% 35> catch Map#{alma:=value}.
% {'EXIT',{{badkey,alma},
%          [{maps,update,
%                 [alma,value,#{}],
%                 [{error_info,#{module => erl_stdlib_errors}}]},
%           {erl_eval,'-expr/6-fun-0-',2,
%                     [{file,"erl_eval.erl"},{line,470}]},
%           {lists,foldl,3,[{file,"lists.erl"},{line,2466}]},
%           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,467}]},
%           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%           {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%           {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%           {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}}
% 36> catch [ A || A<-alma].
% {'EXIT',{{bad_generator,alma},
%          [{erl_eval,eval_generate,9,
%                     [{file,"erl_eval.erl"},{line,1314}]},
%           {erl_eval,eval_lc,7,[{file,"erl_eval.erl"},{line,937}]},
%           {erl_eval,expr,6,[{file,"erl_eval.erl"},{line,656}]},
%           {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%           {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%           {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}}
% 37> [ A || A<-alma].
% ** exception error: bad generator alma
% 38> io:read("Module name> ").
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Module name> lists.
% {ok,lists}
% 39> io:read("Module name> ").
% Module name> 1+2
%              .
% {error,{1,erl_parse,"bad term"}}
% 40> throw(alma).
% ** exception throw: alma
% 41> exit(self(), kill).
% ** exception exit: killed
% 42> c(fourth).
% fourth.erl:8:1: Warning: function eval/0 is unused
% %    8| eval() ->
% %     | ^

% {ok,fourth}
% 43> c(fourth, [export_all]).
% {ok,fourth}
% 44> fourth:eval().
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Module name> 1+
%              .
% {error,{badmatch,{error,{2,erl_parse,
%                          ["syntax error before: ","'.'"]}}},
%        [{fourth,eval,0,[{file,"fourth.erl"},{line,10}]},
%         {erl_eval,do_apply,7,[{file,"erl_eval.erl"},{line,924}]},
%         {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%         {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%         {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}
% 45> self().
% <0.142.0>
% 46> 1/0.
% ** exception error: an error occurred when evaluating an arithmetic expression
%      in operator  '/'/2
%         called as 1 / 0
% 47> self().
% <0.156.0>
% 48> fourth:eval().
% Module name> 1+.
% {error,{badmatch,{error,{1,erl_parse,
%                          ["syntax error before: ","'.'"]}}},
%        [{fourth,eval,0,[{file,"fourth.erl"},{line,10}]},
%         {erl_eval,do_apply,7,[{file,"erl_eval.erl"},{line,924}]},
%         {shell,exprs,7,[{file,"shell.erl"},{line,937}]},
%         {shell,eval_exprs,7,[{file,"shell.erl"},{line,893}]},
%         {shell,eval_loop,4,[{file,"shell.erl"},{line,878}]}]}
% 49> self().
% <0.156.0>
% 50> c(fourth, [export_all]).
% {ok,fourth}
% 51> fourth:eval().
% Module name> 1+.
% bad_input
% 52> fourth:eval().
% Module name> lists.
% Function name> max.
% 3
% 53> fourth:eval().
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Module name> alma.
% Function name> foo.
% ** exception error: undefined function alma:foo/1
% 54> fourth:module_info().
% [{module,fourth},
%  {exports,[{eval,0},{module_info,0},{module_info,1}]},
%  {attributes,[{vsn,[221370078116258455033774400944705430641]}]},
%  {compile,[{version,"9.0"},
%            {options,[export_all]},
%            {source,"/Users/melindatoth/Desktop/fp2/fourth.erl"}]},
%  {md5,<<166,138,83,131,98,222,65,109,38,109,167,30,139,
%         40,228,113>>}]
% 55> fourth:module_info(exports).
% [{eval,0},{module_info,0},{module_info,1}]
% 56> fourth:eval().
% Module name> alma. 
% Function name> 
%                foo.
% ** exception error: undefined function alma:foo/1
% 57> fourth:eval().
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Module name> 1.
% Function name> jo.
% ** exception error: bad argument
%      in function  apply/3
%         called as apply(1,jo,[[1,2,3]])
%         *** argument 1: not an atom
%      in call from fourth:eval/0 (fourth.erl:13)
% 58> apply(Mod, FunName, [[1,2,3]]).
% 3
% 59> FunName.
% max
% 60> Mod:FunName([1,2,3]).
% 3
% 61> ArgList = [[1,2,3]].
% [[1,2,3]]
% 62> apply(Mod, FunName, ArgList).
% 3
% 63> c(fourth, [export_all]).
% fourth.erl:12:15: Warning: variable 'Arity' is unused
% %   12|         {Fun, Arity} = lists:keyfind(Fun, 1, Mod:module_info(exports))
% %     |               ^

% {ok,fourth}
% 64> fourth:eval().
% Module name> 1.
% Function name> foo.
% "Module name is not an atom"
% 65> c(fourth, [export_all]).
% fourth.erl:13:15: Warning: variable 'Arity' is unused
% %   13|         {Fun, Arity} = lists:keyfind(Fun, 1, Exports)
% %     |               ^

% {ok,fourth}
% 66> fourth:eval().
% Module name> 1.
% "Module name is not an atom"
% 67> fourth:eval().
% Module name> alma.
% ** exception error: undefined function alma:module_info/1
%      in function  fourth:eval/0 (fourth.erl:11)
% 68> c(fourth, [export_all]).
% fourth.erl:13:15: Warning: variable 'Arity' is unused
% %   13|         {Fun, Arity} = lists:keyfind(Fun, 1, Exports)
% %     |               ^

% {ok,fourth}
% 69> fourth:eval().
% Module name> alma.
% "Module does not exist"
% 70> fourth:eval().
% Module name> lists.
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Function name> maxxx.
% "The provided input is not an Erlang term"
% 71> c(fourth, [export_all]).
% fourth.erl:13:15: Warning: variable 'Arity' is unused
% %   13|         {Fun, Arity} = lists:keyfind(Fun, 1, Exports)
% %     |               ^

% {ok,fourth}
% 72> fourth:eval().
% Module name> lists.
% Function name> maxxx.
% "Function does not exist"
% 73> c(fourth, [export_all]).
% {ok,fourth}
% 74> fourth:eval().
% Module name> lists.
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Function name> nth.
% Argument 1> 22.
% Argument 2> [2,34].
% ** exception error: undefined function lists:nth/1
% 75> c(fourth, [export_all]).
% fourth.erl:15:22: syntax error before: '||'
% %   15|                 Par  || X<- lists:seq(1, Arity)]
% %     |                      ^

% error
% 76> c(fourth, [export_all]).
% {ok,fourth}
% 77> fourth:eval().
% Module name> lists.
% Function name> nth.
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Argument 1> 2.
% Argument 2> [3,4,5].
% ** exception error: undefined function lists:nth/1
% 78> c(fourth, [export_all]).
% {ok,fourth}
% 79> fourth:eval().
% Module name> lists.
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Function name> nth.
% Argument 1> 1.
% Argument 2> [4,5].
% 4
% 80> fourth:eval().
% Module name> lists.
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Function name> max.
% Argument 1> [].
% ** exception error: no function clause matching lists:max([]) (lists.erl:637)
% 81> fourth:eval().
% Module name> erlang.
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Function name> length.
% Argument 1> [].
% 0
% 82> fourth:eval().
% Module name> erlang.
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Function name> length.
% Argument 1> alma.
% ** exception error: bad argument
%      in function  length/1
%         called as length(alma)
%         *** argument 1: not a list
% 83> c(fourth, [export_all]).
% {ok,fourth}
% 84> fourth:eval().
% Module name> lists.
% Function name> max.
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Argument 1> [1].
% ALmaaaaaaaaa1
% 85> v(84).
% 1
% 86> fourth:eval().
% Module name> 1.
% ALmaaaaaaaaa"Module name is not an atom"
% 87> fourth:eval().
% Module name> lists.
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Function name> max.
% Argument 1> [].
% ALmaaaaaaaaa** exception error: no function clause matching lists:max([]) (lists.erl:637)
%      in function  fourth:eval/0 (fourth.erl:19)
% 88> c(fourth, [export_all]).
% fourth.erl:30:32: syntax error before: 
% %   30|     io:format("ALmaaaaaaaaa2~n")
% %     |                                ^

% error
% 89> c(fourth, [export_all]).
% {ok,fourth}
% 90> fourth:eval().
% Module name> 1.
% ALmaaaaaaaaa
% ALmaaaaaaaaa2
% ok
% 91> fourth:eval().
% Module name> lists.
% Function name> max.
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% Argument 1> [].
% ALmaaaaaaaaa
% ** exception error: no function clause matching lists:max([]) (lists.erl:637)
%      in function  fourth:eval/0 (fourth.erl:19)
% 92> c(fourth, [export_all]).
% fourth.erl:13:5: syntax error before: Fun
% %   13|     Fun(A, B).
% %     |     ^

% error
% 93> c(fourth, [export_all]).
% fourth.erl:10:35: variable 'Fun' is unbound
% %   10|              (X, Y) when X > Y -> Fun(X-Y, Y);
% %     |                                   ^

% fourth.erl:11:24: variable 'Fun' is unbound
% %   11|              (X, Y) -> Fun(X, Y-X)
% %     |                        ^

% error
% 94> c(fourth, [export_all]).
% {ok,fourth}
% 95> c(fourth, [export_all]).
% {ok,fourth}
% 96> fourth:gcd(12, 6).
% ** exception error: fourth:'-gcd/2-fun-0-'/3 called with two arguments
%      in function  fourth:'-gcd/2-fun-0-'/3 (fourth.erl:10)
% 97> c(fourth, [export_all]).
% {ok,fourth}
% 98> fourth:gcd(12, 6).
% 6
% 99> [{A, B} || A <- [1,2,3], B <- [a,b,c]].
% [{1,a},{1,b},{1,c},{2,a},{2,b},{2,c},{3,a},{3,b},{3,c}]
% 100> [{A, B} || A <- [1,2,3] && B <- [a,b,c]].
% [{1,a},{2,b},{3,c}]
% 101> 
