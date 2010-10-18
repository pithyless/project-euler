-module(euler).

-export([group/1, group_by/2, pow/2, for_each_line_in_file/4]).

group(XS) ->
    group_by(fun(A,B) -> A =:= B end, XS).

group_by(_, []) ->
    [];
group_by(F, [X|XS]) ->
    group_by(F, XS, [[X]]).

group_by(_, [], Acc) ->
    lists:reverse(Acc);
group_by(F, [X|XS], [[Y|YS]|ZS]) ->
    case F(X, Y) of
        true  -> 
            group_by(F, XS, [[X,Y|YS]|ZS]);
        false ->
            group_by(F, XS, [[X], lists:reverse([Y|YS]) | ZS])
    end.

pow(X, N) when is_integer(N), N >= 0 -> pow(X, N, 1);
pow(X, N) when is_integer(N) -> 1 / pow(X, -N, 1);
pow(X, N) when is_float(N) -> math:pow(X, N).

pow(_, 0, P) -> P;
pow(X, N, A) when N rem 2 =:= 0 ->
    pow(X * X, N div 2, A);
pow(X, N, A) -> pow(X, N - 1, A * X).


for_each_line_in_file(Name, Proc, Mode, Accum0) ->
    {ok, Device} = file:open(Name, Mode),
    for_each_line(Device, Proc, Accum0).

for_each_line(Device, Proc, Accum) ->
    case io:get_line(Device, "") of
        eof  -> file:close(Device), Accum;
        Line -> NewAccum = Proc(Line, Accum),
                    for_each_line(Device, Proc, NewAccum)
    end.
