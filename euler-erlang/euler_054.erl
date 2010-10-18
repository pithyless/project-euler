-module(euler_054).
-compile(export_all).

main([]) ->
    {S1, S2} = euler:for_each_line_in_file("data/poker.txt",
                  fun liner/2, [read], {0,0}),
    io:format("p1:~w  p2:~w~n", [S1, S2]).


liner(X, {S1, S2}) ->
    [A,B,C,D,E,F,G,H,I,J] = string:tokens(
                              string:strip(X, right, $\n), " "),
    P1 = hand([A,B,C,D,E]),
    P2 = hand([F,G,H,I,J]),
    case winner(P1, P2) of
        {p1, _}  -> {S1+1, S2};
        {p2, _}  -> {S1, S2+1};
        {tie, _} -> {S1, S2}
    end.


points({[{14,T}, {13,T}, {12,T}, {11,T}, {10,T}], _}) -> % s-flush
    {10, {14,T}};
points({[{A,T}, {B,T}, {C,T}, {D,T}, {E,T}], _}) 
  when B == A-1, C == A-2, D == A-3, E == A-4 -> % s-flush
    {9, {A,T}};
points({_, [{A,T}, {A,_}, {A,_}, {A,_}, {_,_}]}) -> % 4 of a kind
    {8, {A,T}};
points({_, [{A,T}, {A,_}, {A,_}, {B,_}, {B,_}]}) -> % full house
    {7, {A,T}};
points({[{C,T}, {_,T}, {_,T}, {_,T}, {_,T}], _}) -> % flush
    {6, {C,T}};
points({[{A,T}, {B,_}, {C,_}, {D,_}, {E,_}], _}) 
  when B == A-1, C == A-2, D == A-3, E == A-4 -> % straight
    {5, {A,T}};
points({_, [{A,T}, {A,_}, {A,_} | _]}) ->
    {4, {A,T}};
points({_, [{A,T}, {A,_}, {B,_}, {B,_} | _]}) ->
    {3, {A,T}};
points({_, [{A,T}, {A,_} | _]}) ->
    {2, {A,T}};
points({[X|_XS], _}) ->
    {1, X}.

winner(P1, P2) ->
    {S1, A} = points(sort_hand(P1)),
    {S2, B} = points(sort_hand(P2)),
    case {cmp(S1, S2), cmp(fst(A), fst(B))} of
        {1,  _} -> {p1, S1};
        {-1, _} -> {p2, S2};
        {0,  1} -> {p1, S1};
        {0, -1} -> {p2, S2};
        {0,  0} -> io:format("~w~n", [[P1, P2]]),   %% lazy
                   {tie, S1}                        %% hack :)
    end.

cmp(A,B) when A < B -> -1;
cmp(A,B) when A > B -> 1;
cmp(A,B) when A =:= B -> 0.

order_cards(Deck) ->
    rsort(Deck).

group_cards(Deck) ->
    Sorted = lists:sort(Deck),
    Grouped = euler:group_by(fun({A,_}, {C,_}) ->
                                     A == C end, Sorted),
    X = lists:sort(fun(A,B) -> length(A) > length(B) end, Grouped),
    lists:flatten(lists:map(fun rsort/1, X)).
    
sort_hand(X) -> {order_cards(X), group_cards(X)}.

rsort(X) ->
    lists:reverse(lists:sort(X)).

fst({A,_}) -> A.
snd({_,B}) -> B.

hand([]) -> [];
hand([X|XS]) -> [parse(X) | hand(XS)].

parse([$A,T]) -> {14, T};
parse([$K,T]) -> {13, T};
parse([$Q,T]) -> {12, T};
parse([$J,T]) -> {11, T};
parse([$T,T]) -> {10, T};
parse([X,T]) ->  {list_to_integer([X]),  T}.
