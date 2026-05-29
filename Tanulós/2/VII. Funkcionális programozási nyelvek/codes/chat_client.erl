-module(chat_client).
-export([login/1, logout/0, send/1]).

-include("chat.hrl").

login(Name) when is_list(Name) ->
    case gen_server:call(?SRV, {login, self(), Name}) of
        ok -> client_loop();
        deny -> "Connection denied"
    end.

logout() ->
    gen_server:cast(?SRV, {logout, self()}).

send(Text) ->
    gen_server:cast(?SRV, {msg, self(), Text}).

client_loop() ->
    ok.
