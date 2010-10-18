-module(lib145).
-export([numbers/1, numbers/5]).

numbers(Max) ->
    {ok, RE} = regexp:parse("[24680]"),
    spawn(lib145, numbers, [self(), RE, Max, 0, 1]),
    spawn(lib145, numbers, [self(), RE, Max, 0, 2]),
    spawn(lib145, numbers, [self(), RE, Max, 0, 3]),
    spawn(lib145, numbers, [self(), RE, Max, 0, 4]),
    receive
        {_, Msg1} -> Msg1
    end,
    receive
        {_, Msg2} -> Msg2
    end,
    receive
        {_, Msg3} -> Msg3
    end,
    receive
        {_, Msg4} -> Msg4
    end,
    Msg1 + Msg2 + Msg3 + Msg4.

numbers(From,_RE,Max,Acc,N) when N >= Max ->
    From ! {self(), Acc};
numbers(From,RE,Max,Acc,N) ->
    P = integer_to_list(N),
    R = lists:reverse(P),
    case hd(R) == $0 of
        true ->
            numbers(From, RE,Max, Acc, N+4);
        _ ->
            case regexp:first_match(integer_to_list(N + list_to_integer(R)), RE) of
                nomatch -> 
                    numbers(From, RE,Max, Acc+1, N+4);
                _ ->
                    numbers(From, RE,Max, Acc, N+4)
            end
    end.
