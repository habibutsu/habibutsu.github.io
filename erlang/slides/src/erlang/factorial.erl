-module(factorial).

-compile({parse_transform, erlmonads_expr_do}).
-compile({no_auto_import,[get/0]}).

-export([
    fact/1
]).

-import(erlmonads_state, [
    get/0,
    put/1
]).


fact_rec(0) ->
    do([erlmonads_state ||
        Acc <- get(),
        return(Acc)
    ]);
fact_rec(N) ->
    do([erlmonads_state ||
        Acc <- get(),
        put(Acc * N),
        fact_rec(N - 1)
    ]).

fact(N) ->
    R = erlmonads_state:eval(
        fact_rec(N),
        1
    ),
    R.
