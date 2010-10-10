#!/usr/bin/env escript
-export([main/1]).

main([X]) ->
    J = list_to_integer(X),
    io:format("~w~n", [squares_sum(J) - sum_squares(J)]).

sum_squares(N) ->
    sum_squares(1, N+1, 0).

sum_squares(N, N, Acc) -> Acc;
sum_squares(X, N, Acc) ->
    sum_squares(X+1, N, Acc + (X*X)).

squares_sum(N) ->
    J = (N * (N+1)) div 2,
    J * J.
