#!/usr/bin/env escript
-export([main/1]).

main([X]) ->
    J = list_to_integer(X),
    io:format("~w~n", [lists:sum(aux(J))]).

aux(N) -> aux(1, N, []).

aux(N, N, Acc) -> Acc;
aux(X, N, Acc) ->
    case num_matches(X) of
        true ->
            aux(X+1, N, [X|Acc]);
        false ->
            aux(X+1, N, Acc)
    end.

num_matches(N) ->
    is_multiple(3, N) orelse is_multiple(5, N).

is_multiple(_, 0) -> false;
is_multiple(N, X) ->
    X rem N == 0.
