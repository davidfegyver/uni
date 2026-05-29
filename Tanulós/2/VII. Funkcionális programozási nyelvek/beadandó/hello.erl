-module (hello).
-export([greet/1]).

greet(Name) -> 
    io:format("Hello, world: ~s~n",[Name]).





%%-compile([debug_info, export_all]).