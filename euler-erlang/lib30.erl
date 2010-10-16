-module(lib30).
-export([powers/1]).

powers(Max) ->
    powers(5, Max, 10, []).

powers(_Pow, Max, Max, Acc) ->
    lists:sum(Acc);
powers(Pow, Max, N, Acc) ->
    A = lists:map(fun(X) -> euler:pow(list_to_integer([X]),Pow) end, 
                  integer_to_list(N)),
    case lists:sum(A) == N of
        true ->
            powers(Pow, Max, N+1, [N | Acc]);
        false ->
            powers(Pow, Max, N+1, Acc)
    end.
