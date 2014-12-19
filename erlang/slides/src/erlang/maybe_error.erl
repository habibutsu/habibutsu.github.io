-module(maybe_error).

-compile({parse_transform, erlmonads_expr_do}).

-export([
    main/0
]).

main() ->
    R1 = do([erlmonads_maybe ||
        return(2)
    ]),
    io:format("~p~n", [R1]),
    ok.
