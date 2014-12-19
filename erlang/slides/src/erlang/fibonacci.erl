-module(fibonacci).

-compile({parse_transform, erlmonads_expr_do}).

-export([
    fib/1
]).

-import(erlmonads_state, [
    eval/2,
    modify/1,
    sequence/1,
    exec/2
]).

fib_m_step() ->
    modify(fun ({X, Y}) -> {Y, X+Y} end).

fib(N) ->
    {A, _} = exec(
        sequence(
            lists:duplicate(N, fib_m_step())
        ),
        {0, 1}
    ),
    A.
