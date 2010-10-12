-module(euler).

-export([group/1, pow/2]).

group([]) ->
    [];
group([X|XS]) ->
    group(XS, [{X, 1}]).

group([], Acc) ->
    lists:reverse(Acc);
group([X|YS], [{X, N}|ZS]) ->
    group(YS, [{X, N+1}|ZS]);
group([Y|YS], [{X, N}|ZS]) ->
    group(YS, [{Y, 1}, {X, N} | ZS]).

pow(X, N) when is_integer(N), N >= 0 -> pow(X, N, 1);
pow(X, N) when is_integer(N) -> 1 / pow(X, -N, 1);
pow(X, N) when is_float(N) -> math:pow(X, N).

pow(_, 0, P) -> P;
pow(X, N, A) when N rem 2 =:= 0 ->
    pow(X * X, N div 2, A);
pow(X, N, A) -> pow(X, N - 1, A * X).
