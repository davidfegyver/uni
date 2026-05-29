-module(chat).
-behaviour(gen_server).

-export([start_srv/0, stop/0]).
-export([init/1, handle_call/3, handle_cast/2]).

-include("chat.hrl").

start_srv() ->
    gen_server:start_link(?SRV, ?MODULE, [], []).

stop() ->
    gen_server:cast(?SRV, stop).

init(_) ->
    process_flag(trap_exit, true),
    {ok, #{}}. %% Pid => UserName

handle_call({login, User, Name}, {_From, _Ref}, State) when map_size(State) < 20 ->
    link(User),
    {reply, ok, State#{User=>Name}};
handle_call({login, _, _}, _, State) ->
    {reply, deny, State}.

handle_cast({logout, User}, State) ->
    {noreply, maps:remove(User, State)};
handle_cast({msg, User, Text}, State) ->
    #{User:=Name} = State,
    NewText = Name ++ ": " ++ Text,
    maps:foreach(fun(U, _) -> U ! {print, NewText} end, State),
    {noreply, State};
handle_cast(stop, State) ->
    {stop, normal, State}.

