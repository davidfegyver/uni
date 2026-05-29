-module(taskfarm_reg).

run(F, L) ->
    WorkerNum = erlang:system_info(logical_processors_available),
    register(dispatcher, spawn(fun() -> dispatcher(L, WorkerNum) end)),
    register(collector, spawn(fun() -> collector([]) end)),
    Worker = fun() -> worker(F) end,
    WorkerPids = [spawn(Worker) || _ <- lists:seq(1, WorkerNum)],
    spawn_link(fun() -> supervisor_init(WorkerPids, Worker) end).

supervisor_init(WorkerPids, Worker) ->
    process_flag(trap_exit, true),
    [link(W) || W <- WorkerPids],
    supervisor(Worker).

supervisor(Worker) ->
    receive
        {'EXIT', _Pid, Reason} when Reason/=normal->
            spawn_link(Worker),
            supervisor(Worker)
    end. 

collector(Result) ->
    receive
        stop -> io:format("Collector terminated~n. Result: ~p~n", [Result]);
        {result, Data, Value} -> collector([{Data, Value} | Result]);
        {give_me, From} ->
            From ! {subresult, Result},
            collector(Result)
    end.

dispatcher([E | Es], N) ->
    receive
        {free, WPid} -> 
            WPid ! {data, E},
            dispatcher(Es, N)
    end;
dispatcher([], 0) ->    
    io:format("Dispatcher terminated~n");
dispatcher([], N) ->
    receive
        {free, WPid} ->
            WPid ! stop,
            dispatcher([], N-1)
    end.


worker(F) ->
    dispatcher ! {free, self()},
    receive
        stop -> 
            io:format("Worker terminated: ~p~n", [self()]);
        {data, Data} -> 
            collector ! {result, Data, F(Data)}, 
            worker(F)
    end.


% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> erlang:system_info(cores_available).
% ** exception error: bad argument
%      in function  erlang:system_info/1
%         called as erlang:system_info(cores_available)
%         *** argument 1: invalid system info item
% 2> erlang:system_info(logical_processors_available).
% 8
% 3> c(taskfarm, [export_all]).
% taskfarm.erl:6:27: function collector/1 undefined
% %    6|     Coll = spawn(fun() -> collector([]) end),
% %     |                           ^

% taskfarm.erl:12:13: function get_sender/0 undefined
% %   12|             get_sender() ! {data, E},
% %     |             ^

% taskfarm.erl:16:15: Warning: the format string requires an argument list with 1 argument, but no argument list is given
% %   16|     io:format("All input sent~p").
% %     |               ^

% error
% 4> c(taskfarm, [export_all]).
% taskfarm.erl:6:27: function collector/1 undefined
% %    6|     Coll = spawn(fun() -> collector([]) end),
% %     |                           ^

% taskfarm.erl:16:15: Warning: the format string requires an argument list with 1 argument, but no argument list is given
% %   16|     io:format("All input sent~p").
% %     |               ^

% error
% 5> c(taskfarm, [export_all]).
% taskfarm.erl:6:27: function collector/1 undefined
% %    6|     Coll = spawn(fun() -> collector([]) end),
% %     |                           ^

% error
% 6> c(taskfarm, [export_all]).
% {ok,taskfarm}
% 7> taskfarm:run(fun(X) -> X + 1 end, [3,4,5]).
% All input sent
% <0.110.0>
% 8> <0.110.0> ! {give_me, self()}.
% {give_me,<0.89.0>}
% 9> flush().
% Shell got {subresult,[{4,5},{3,4},{5,6}]}
% ok
% 10> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).10> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).
% <0.123.0>
% =ERROR REPORT==== 25-Mar-2026::12:43:29.302058 ===
% Error in process <0.124.0> with exit value:
% {badarg,[{erlang,atom_to_list,[3],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,31}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:43:29.302096 ===
% Error in process <0.125.0> with exit value:
% {badarg,[{erlang,atom_to_list,[4],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,31}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:43:29.302099 ===
% Error in process <0.126.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,31}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:43:29.302102 ===
% Error in process <0.127.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,31}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:43:29.302104 ===
% Error in process <0.128.0> with exit value:
% {badarg,[{erlang,atom_to_list,[6],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,31}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:43:29.302106 ===
% Error in process <0.129.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,31}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:43:29.302109 ===
% Error in process <0.130.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,31}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:43:29.302111 ===
% Error in process <0.131.0> with exit value:
% {badarg,[{erlang,atom_to_list,"\b",
%                  [{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,31}]}]}

% 11> [8].
% "\b"
% 12> is_process_alive(<0.123.0>).
% true
% 13> <0.123.0> ! {give_me, self()}.
% {give_me,<0.89.0>}
% 14> flush().
% Shell got {subresult,[]}
% ok
% 15> c(taskfarm, [export_all]).
% taskfarm.erl:9:20: function supervisor/2 undefined, did you mean supervisor/1?
% %    9|     spawn(fun() -> supervisor(WorkerPids, Worker) end),
% %     |                    ^

% taskfarm.erl:18:18: Warning: variable 'Pid' is unused
% %   18|         {'EXIT', Pid, Reason} when Reason/=normal->
% %     |                  ^

% error
% 16> c(taskfarm, [export_all]).
% taskfarm.erl:18:18: Warning: variable 'Pid' is unused
% %   18|         {'EXIT', Pid, Reason} when Reason/=normal->
% %     |                  ^

% {ok,taskfarm}
% 17> c(taskfarm, [export_all]).
% {ok,taskfarm}
% 18> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).18> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).
% <0.152.0>
% =ERROR REPORT==== 25-Mar-2026::12:55:42.127688 ===
% Error in process <0.153.0> with exit value:
% {badarg,[{erlang,atom_to_list,[3],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:55:42.127727 ===
% Error in process <0.154.0> with exit value:
% {badarg,[{erlang,atom_to_list,[4],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:55:42.127736 ===
% Error in process <0.155.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:55:42.127742 ===
% Error in process <0.156.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:55:42.127745 ===
% Error in process <0.157.0> with exit value:
% {badarg,[{erlang,atom_to_list,[6],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:55:42.127749 ===
% Error in process <0.158.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:55:42.127754 ===
% Error in process <0.159.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% 19> <0.152.0> ! {give_me, self()}.
% {give_me,<0.89.0>}
% 20> flush().
% Shell got {subresult,[]}
% ok
% 21> i().
% Pid                   Initial Call                          Heap     Reds Msgs
% Registered            Current Function                     Stack              
% <0.0.0>               erl_init:start/2                       987     6349    0
% init                  init:loop/1                              2              
% <0.1.0>               erts_code_purger:start/0                 5    43105    0
% erts_code_purger      erlang:hibernate/3                       1              
% <0.2.0>               erts_literal_area_collector:start        5    42693    0
%                       erlang:hibernate/3                       1              
% <0.3.0>               erts_dirty_process_signal_handler      233     2295    0
%                       erts_dirty_process_signal_handler        2              
% <0.4.0>               erts_dirty_process_signal_handler      233       13    0
%                       erts_dirty_process_signal_handler        2              
% <0.5.0>               erts_dirty_process_signal_handler      233       13    0
%                       erts_dirty_process_signal_handler        2              
% <0.6.0>               erts_trace_cleaner:start/0               5       14    0
%                       erlang:hibernate/3                       1              
% <0.7.0>               prim_file:start/0                      233       12    0
%                       prim_file:helper_loop/0                  1              
% <0.8.0>               socket_registry:start/0                233       14    0
% socket_registry       socket_registry:loop/1                   4              
% <0.11.0>              erlang:apply/2                         610    12317    0
% erl_prim_loader       erl_prim_loader:loop/3                   6              
% more (y/n)? (y) y
% <0.43.0>              logger_server:init/1                   987      790    0
% logger                gen_server:loop/5                        9              
% <0.45.0>              erlang:apply/2                        2586     1393    0
% application_controlle gen_server:loop/5                        6              
% <0.46.0>              application_master:init/3              376       79    0
%                       application_master:main_loop/2           6              
% <0.47.0>              application_master:start_it/4          233      996    0
%                       application_master:loop_it/4             6              
% <0.49.0>              supervisor:kernel/1                    274     5685    0
% kernel_sup            gen_server:loop_hibernate/4              8              
% <0.50.0>              erlang:apply/2                       46422   193771    0
% code_server           code_server:loop/1                       4              
% <0.51.0>              supervisor_bridge:standard_error/      233       64    0
% standard_error_sup    gen_server:loop/5                        9              
% <0.52.0>              erlang:apply/2                         233      546    0
% standard_error        standard_error:server_loop/1             4              
% <0.53.0>              file_server:init/1                    2586     2087    0
% file_server_2         gen_server:loop/5                        9              
% <0.55.0>              prim_tty:writer/1                      233       29    0
% standard_error_writer prim_tty:writer_loop/2                   7              
% <0.56.0>              inet_db:init/1                         233      631    0
% inet_db               gen_server:loop/5                        9              
% Command is taking a long time, type Ctrl+G, then enter 'i' to interrupt
% more (y/n)? (y) y
% <0.57.0>              rpc:init/1                             233       48    0
% rex                   gen_server:loop/5                        9              
% <0.58.0>              erlang:apply/2                         233      252    0
%                       rpc:nodes_observer_loop/1                4              
% <0.59.0>              global:init/1                          376      657    0
% global_name_server    gen_server:loop/5                        9              
% <0.60.0>              erlang:apply/2                         233       45    0
%                       global:loop_the_locker/1                 3              
% <0.61.0>              erlang:apply/2                         233       13    0
%                       global:loop_the_registrar/0              2              
% <0.62.0>              global_group:init/1                    233      286    0
% global_group          gen_server:loop/5                        9              
% <0.63.0>              erlang:apply/2                         233       12    0
% global_group_check    global_group:global_group_check_d        1              
% <0.64.0>              gen_event:init_it/6                    233      301    0
% erl_signal_server     gen_event:fetch_msg/6                   10              
% <0.65.0>              supervisor_bridge:user_sup/1           233      546    0
%                       gen_server:loop/5                        9              
% <0.66.0>              user_drv:init/1                       1598   583158    0
% user_drv              gen_statem:loop/3                        8              
% <0.67.0>              prim_tty:writer/1                      233     8825    0
% user_drv_writer       prim_tty:writer_loop/2                   7              
% more (y/n)? (y) y
% <0.68.0>              prim_tty:reader/1                     2586    13890    0
% user_drv_reader       prim_tty:reader_loop/2                  11              
% <0.69.0>              group:init/1                          1598     7460    0
% user                  gen_statem:loop/3                        8              
% <0.70.0>              group:init/1                       1439468  1700944    0
% {group,{shell,start,[ gen_statem:loop/3                        8              
% <0.71.0>              supervisor:logger_sup/1                114      681    0
% logger_sup            gen_server:loop_hibernate/4              8              
% <0.72.0>              erlang:apply/2                        2586    21041    0
%                       shell:shell_rep/6                       18              
% <0.73.0>              logger_handler_watcher:init/1          233       69    0
% logger_handler_watche gen_server:loop/5                        9              
% <0.74.0>              logger_olp:init/1                     2586    39191    0
% logger_proxy          gen_server:loop/5                        9              
% <0.75.0>              kernel_config:init/1                   233       68    0
%                       gen_server:loop/5                        9              
% <0.76.0>              kernel_refc:init/1                     233       87    0
% kernel_refc           gen_server:loop/5                        9              
% <0.77.0>              supervisor:kernel/1                     94      588    0
% kernel_safe_sup       gen_server:loop_hibernate/4              8              
% <0.79.0>              logger_olp:init/1                     1598     1038    0
% logger_std_h_default  gen_server:loop/5                        9              
% more (y/n)? (y) y
% <0.80.0>              erlang:apply/2                         233      536    0
%                       logger_std_h:file_ctrl_loop/1            4              
% <0.83.0>              supervisor:disk_log_sup/1              376      164    0
% disk_log_sup          gen_server:loop/5                        9              
% <0.84.0>              disk_log_server:init/1                 610      163    0
% disk_log_server       gen_server:loop/5                        9              
% <0.85.0>              disk_log:init/2                       6772    33123    0
%                       disk_log:loop/1                          5              
% <0.89.0>              erlang:apply/2                        2586   109621    0
%                       c:pinfo/2                               51              
% <0.151.0>             erlang:apply/2                         233       31    0
%                       taskfarm:dispatcher/1                    3              
% <0.152.0>             erlang:apply/2                         233       17    0
%                       taskfarm:collector/1                     2              
% Total                                                    1523616  2835751    0
%                                                              359              
% ok
% 22> c(taskfarm, [export_all]).
% {ok,taskfarm}
% 23> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).23> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).
% <0.172.0>
% =ERROR REPORT==== 25-Mar-2026::12:59:36.556687 ===
% Error in process <0.173.0> with exit value:
% {badarg,[{erlang,atom_to_list,[3],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:59:36.556711 ===
% Error in process <0.174.0> with exit value:
% {badarg,[{erlang,atom_to_list,[4],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:59:36.556715 ===
% Error in process <0.175.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:59:36.556724 ===
% Error in process <0.179.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:59:36.556725 ===
% Error in process <0.176.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:59:36.556730 ===
% Error in process <0.177.0> with exit value:
% {badarg,[{erlang,atom_to_list,[6],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:59:36.556739 ===
% Error in process <0.178.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::12:59:36.556744 ===
% Error in process <0.180.0> with exit value:
% {badarg,[{erlang,atom_to_list,"\b",
%                  [{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% 24> <0.172.0> ! {give_me, self()}.
% {give_me,<0.89.0>}
% 25> flush().
% Shell got {subresult,[]}
% ok
% 26> observer:start().
% ok
% 27> c(taskfarm, [export_all]).
% {ok,taskfarm}
% 28> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).28> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).
% {<0.6707.0>,<0.6716.0>}
% =ERROR REPORT==== 25-Mar-2026::13:01:20.493801 ===
% Error in process <0.6708.0> with exit value:
% {badarg,[{erlang,atom_to_list,[3],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:01:20.493827 ===
% Error in process <0.6709.0> with exit value:
% {badarg,[{erlang,atom_to_list,[4],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:01:20.493804 ===
% Error in process <0.6714.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:01:20.493831 ===
% Error in process <0.6710.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:01:20.493838 ===
% Error in process <0.6711.0> with exit value:
% {badarg,[{erlang,atom_to_list,[6],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:01:20.493842 ===
% Error in process <0.6712.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:01:20.493848 ===
% Error in process <0.6713.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% 29> is_process_alive(<0.6716.0>).
% false
% 30> c(taskfarm, [export_all]).
% {ok,taskfarm}
% 31> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).31> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).
% =ERROR REPORT==== 25-Mar-2026::13:02:52.937370 ===
% Error in process <0.8388.0> with exit value:
% {badarg,[{erlang,atom_to_list,[3],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:02:52.937404 ===
% Error in process <0.8389.0> with exit value:
% {badarg,[{erlang,atom_to_list,[4],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% ** exception exit: badarg
%      in function  atom_to_list/1
%         called as atom_to_list(3)
%         *** argument 1: not an atom
%      in call from taskfarm:worker/3 (taskfarm.erl:44)
% =ERROR REPORT==== 25-Mar-2026::13:02:52.937420 ===
% Error in process <0.8390.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:02:52.937429 ===
% Error in process <0.8391.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:02:52.937436 ===
% Error in process <0.8392.0> with exit value:
% {badarg,[{erlang,atom_to_list,[6],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:02:52.937441 ===
% Error in process <0.8393.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:02:52.937446 ===
% Error in process <0.8394.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:02:52.937452 ===
% Error in process <0.8395.0> with exit value:
% {badarg,[{erlang,atom_to_list,"\b",
%                  [{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,44}]}]}

% 32> c(taskfarm, [export_all]).
% {ok,taskfarm}
% 33> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).33> taskfarm:run(fun erlang:atom_to_list/1, [3,4,5,5,6,7,7,8,8,89,alma, korte]).
% All input sent
% {<0.11807.0>,<0.11816.0>}
% =ERROR REPORT==== 25-Mar-2026::13:06:26.840378 ===
% Error in process <0.11808.0> with exit value:
% {badarg,[{erlang,atom_to_list,[3],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,45}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:06:26.840389 ===
% Error in process <0.11809.0> with exit value:
% {badarg,[{erlang,atom_to_list,[4],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,45}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:06:26.840405 ===
% Error in process <0.11813.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,45}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:06:26.840406 ===
% Error in process <0.11810.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,45}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:06:26.840409 ===
% Error in process <0.11814.0> with exit value:
% {badarg,[{erlang,atom_to_list,[7],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,45}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:06:26.840410 ===
% Error in process <0.11811.0> with exit value:
% {badarg,[{erlang,atom_to_list,[5],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,45}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:06:26.840414 ===
% Error in process <0.11812.0> with exit value:
% {badarg,[{erlang,atom_to_list,[6],[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,45}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:06:26.840418 ===
% Error in process <0.11815.0> with exit value:
% {badarg,[{erlang,atom_to_list,"\b",
%                  [{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,45}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:06:26.840444 ===
% Error in process <0.11817.0> with exit value:
% {badarg,[{erlang,atom_to_list,"\b",
%                  [{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,45}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:06:26.840456 ===
% Error in process <0.11818.0> with exit value:
% {badarg,[{erlang,atom_to_list,"Y",[{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm,worker,3,[{file,"taskfarm.erl"},{line,45}]}]}

% 34> <0.11807.0> ! {give_me, self()}.
% {give_me,<0.8397.0>}
% 35> flush().
% Shell got {subresult,[{korte,"korte"},{alma,"alma"}]}
% ok
% 36> c(taskfarm, [export_all]).
% {ok,taskfarm}
% 37> taskfarm:run(fun(X) -> X + 1 end, [3,4,5]).
% All input sent
% {<0.19126.0>,<0.19135.0>}
% 38> 
% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erl
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> c(taskfarm, [export_all]).
% {ok,taskfarm}
% 2> taskfarm:run(fun(X) -> X + 1 end, [3,4,5]).
% All input sent
% {<0.95.0>,<0.104.0>}
% 3> observer:start().
% ok
% 4> erlang:process_info(<0.97.0>).
% [{current_function,{taskfarm,worker,3}},
%  {initial_call,{erlang,apply,2}},
%  {status,waiting},
%  {message_queue_len,0},
%  {links,[<0.104.0>]},
%  {dictionary,[]},
%  {trap_exit,false},
%  {error_handler,error_handler},
%  {priority,normal},
%  {group_leader,<0.70.0>},
%  {total_heap_size,233},
%  {heap_size,233},
%  {stack_size,5},
%  {reductions,84},
%  {garbage_collection,[{max_heap_size,#{error_logger => true,
%                                        include_shared_binaries => false,
%                                        kill => true,size => 0}},
%                       {min_bin_vheap_size,46422},
%                       {min_heap_size,233},
%                       {fullsweep_after,65535},
%                       {minor_gcs,0}]},
%  {suspending,[]}]
% 5> c(taskfarm_stop, [export_all]).
% taskfarm_stop.erl:44:53: syntax error before: '.'
% %   44|         stop -> io:format("Dispatcher terminated~n").
% %     |                                                     ^

% taskfarm_stop.erl:45:5: syntax error before: 'end'
% %   45|     end.
% %     |     ^

% taskfarm_stop.erl:5:27: function dispatcher/1 undefined
% %    5|     Disp = spawn(fun() -> dispatcher(L) end),
% %     |                           ^

% taskfarm_stop.erl:9:5: Warning: variable 'Sup' is unused
% %    9|     Sup = spawn_link(fun() -> supervisor_init(WorkerPids, Worker) end),
% %     |     ^

% error
% 6> c(taskfarm_stop, [export_all]).
% taskfarm_stop.erl:9:5: Warning: variable 'Sup' is unused
% %    9|     Sup = spawn_link(fun() -> supervisor_init(WorkerPids, Worker) end),
% %     |     ^

% {ok,taskfarm_stop}
% 7> taskfarm_stop:run(fun(X) -> X + 1 end, [3,4,5]).
% Worker terminated: <0.6595.0>
% Worker terminated: <0.6592.0>
% Worker terminated: <0.6593.0>
% Worker terminated: <0.6594.0>
% Worker terminated: <0.6596.0>
% Worker terminated: <0.6599.0>
% Worker terminated: <0.6597.0>
% Worker terminated: <0.6598.0>
% {<0.6591.0>,<0.6590.0>}
% 8> <0.6590.0> ! stop.
% Dispatcher terminated
% stop
% 9> <0.6591.0> ! stop.
% Collector terminated
% . Result: [{5,6},{4,5},{3,4}]
% stop
% 10> erlang:process_info(<0.97.0>).
% [{current_function,{taskfarm,worker,3}},
%  {initial_call,{erlang,apply,2}},
%  {status,waiting},
%  {message_queue_len,0},
%  {links,[<0.104.0>]},
%  {dictionary,[]},
%  {trap_exit,false},
%  {error_handler,error_handler},
%  {priority,normal},
%  {group_leader,<0.70.0>},
%  {total_heap_size,233},
%  {heap_size,233},
%  {stack_size,5},
%  {reductions,99},
%  {garbage_collection,[{max_heap_size,#{error_logger => true,
%                                        include_shared_binaries => false,
%                                        kill => true,size => 0}},
%                       {min_bin_vheap_size,46422},
%                       {min_heap_size,233},
%                       {fullsweep_after,65535},
%                       {minor_gcs,0}]},
%  {suspending,[]}]
% 11> erlang:process_info(<0.97.0>, messages).
% {messages,[]}
% 12> self() ! ok.
% ok
% 13> flush().
% Shell got ok
% ok
% 14> flush().
% ok
% 15> self() ! ok.
% ok
% 16> erlang:process_info(self(), messages).
% {messages,[ok]}
% 17> erlang:process_info(self(), messages).
% {messages,[ok]}
% 18> erlang:process_info(self(), messages).
% {messages,[ok]}
% 19> erlang:process_info(self(), messages).
% {messages,[ok]}
% 20> flush().
% Shell got ok
% ok
% 21> erlang:process_info(self(), messages).
% {messages,[]}
% 22> c(taskfarm_stop2, [export_all]).
% taskfarm_stop2.erl:9:5: Warning: variable 'Sup' is unused
% %    9|     Sup = spawn_link(fun() -> supervisor_init(WorkerPids, Worker) end),
% %     |     ^

% {ok,taskfarm_stop2}
% 23> c(taskfarm_stop2, [export_all]).
% taskfarm_stop2.erl:9:5: Warning: variable 'Sup' is unused
% %    9|     Sup = spawn_link(fun() -> supervisor_init(WorkerPids, Worker) end),
% %     |     ^

% {ok,taskfarm_stop2}
% 24> c(taskfarm_reg, [export_all]).
% taskfarm_reg.erl:55:13: function worker/3 undefined, did you mean worker/1?
% %   55|             worker(F, Disp, Coll)
% %     |             ^

% taskfarm_reg.erl:55:23: variable 'Disp' is unbound
% %   55|             worker(F, Disp, Coll)
% %     |                       ^

% taskfarm_reg.erl:55:29: variable 'Coll' is unbound
% %   55|             worker(F, Disp, Coll)
% %     |                             ^

% error
% 25> c(taskfarm_reg, [export_all]).
% {ok,taskfarm_reg}
% 26> taskfarm_reg:run(fun(X) -> X + 1 end, [3,4,5]).
% <0.17555.0>
% =ERROR REPORT==== 25-Mar-2026::13:30:27.285084 ===
% Error in process <0.17547.0> with exit value:
% {badarg,[{erlang,send,
%                  [dipatcher,{free,<0.17547.0>}],
%                  [{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm_reg,worker,1,[{file,"taskfarm_reg.erl"},{line,49}]}]}

% =ERROR REPORT==== 25-Mar-2026::13:30:27.285112 ===
% Error in process <0.17553.0> with exit value:
% {badarg,[{erlang,send,
%                  [dipatcher,{free,<0.17553.0>}],
%                  [{error_info,#{module => erl_erts_errors}}]},
%          {taskfarm_reg,worker,1,[{file,"taskfarm_reg.erl"},{line,49}]}]}

% ....

% 27> 
% BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
%        (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
% ^C%                                                                             melindatoth@MacBook-Pro fp2 % erlerl
% zsh: command not found: erlerl
% melindatoth@MacBook-Pro fp2 % erl   
% Erlang/OTP 28 [erts-16.0.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

% Hello
% Eshell V16.0.1 (press Ctrl+G to abort, type help(). for help)
% 1> <0.2334.0> ! ok.
% ok
% 2> dipatcher ! ok.
% ** exception error: bad argument
%      in operator  !/2
%         called as dipatcher ! ok
% 3> c(taskfarm_reg, [export_all]).
% {ok,taskfarm_reg}
% 4> taskfarm_reg:run(fun(X) -> X + 1 end, [3,4,5]).
% Worker terminated: <0.104.0>
% Worker terminated: <0.105.0>
% Worker terminated: <0.106.0>
% Worker terminated: <0.102.0>
% Worker terminated: <0.103.0>
% Dispatcher terminated
% Worker terminated: <0.99.0>
% Worker terminated: <0.100.0>
% Worker terminated: <0.101.0>
% <0.107.0>
% 5> collector ! {give_me, self()}.
% {give_me,<0.90.0>}
% 6> flush().
% Shell got {subresult,[{5,6},{4,5},{3,4}]}
% ok
% 7> 
