#!/usr/bin/env escript
-export([main/1]).

main([Arg]) ->
    Numbers = lib145:numbers(list_to_integer(Arg)),
    io:format("~p~n", [Numbers]).
