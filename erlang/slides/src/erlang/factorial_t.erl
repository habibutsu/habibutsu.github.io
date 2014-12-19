-module(factorial_t).

-compile({parse_transform, erlmonads_expr_do}).

-export([
    fact/1
]).


fact_rec(State, 0) ->
    do([State ||
        Acc <- State:get(),
        return(Acc)
    ]);
fact_rec(State, N) ->
    do([State ||
        Acc <- State:get(),
        State:put(Acc * N),
        fact_rec(State, N - 1)
    ]).


fact(N) ->
    State = erlmonads_state_t:new(erlmonads_identity),
    io:format("~p~n", [State]),
    R = State:eval(
        fact_rec(State, N),
        1
    ),
    R.
