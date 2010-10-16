#!/usr/bin/env escript
-export([main/1]).

main([Arg]) ->
    Numbers = lib30:powers(list_to_integer(Arg)),
    io:format("~p~n", [Numbers]).
