-module(server_skeleton).

%% client interface
-export([]).

-export([start/1, stop/0]).

-export([init/1, loop/1, terminate/1]).

start(Args) ->
    register(server, spawn_link(?MODULE, init, [Args])).

stop() ->
    server ! stop. 

init( Args) ->
    InitState = initialize_state(Args),
    loop(InitState).

loop(State)->
    receive
        stop ->
            terminate(State);
        {handle, Msg} -> %% synchronous, asynchronous
            NewState = handle_req(Msg, State),
            ?MODULE:loop(NewState)
        % ....
        % _Other ->
        %     an_unhandled_message
        %     %loop(State)
    end.

terminate(_State)->
    do_cleanup.

initialize_state(_Args) ->
    do_init.

handle_req(_Msg, _State)->
    do_sth.
