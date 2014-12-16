#!/usr/bin/env escript
%% -*- erlang -*-
%%! -pz ./erlmonads/ebin

-compile({parse_transform, erlmonads_expr_do}).

%code:add_pathz("./erlmonads/ebin").
%code:add_pathz("./erlmonads/src/").

% case_one() ->
%     io:format("Case 1:~n"),
%     Data = {[
%         {<<"key1">>, <<"value1">>},
%         {<<"key2">>, {[
%             {<<"key2.1">>, <<"value2.1">>},
%             {<<"key2.2">>, <<"value2.2">>}
%         ]}},
%         {<<"key3">>, <<"value3">>}
%     ]},
%     V21 = ej:get([<<"key2">>, <<"key2.1">>], Data),
%     V21upd = <<"Updated1 ", V21/binary>>,

%     V22 = ej:get([<<"key2">>, <<"key2.2">>], Data),
%     V22upd = <<"Updated2 ", V22/binary>>,

%     DataUpd = ej:set([<<"key2">>, <<"key2.1">>],
%             ej:set([<<"key2">>, <<"key2.2">>], Data, V22upd),
%         V21upd),

%     % --------------

%     Upd1 = fun(Data) -> 
%         V = ej:get([<<"key2">>, <<"key2.1">>], Data),
%         Vupd = <<"Updated1 ", V/binary>>,
%         ej:set([<<"key2">>, <<"key2.1">>], Data, Vupd)
%     end,

%     Upd2 = fun(Data) -> 
%         V = ej:get([<<"key2">>, <<"key2.2">>], Data),
%         Vupd = <<"Updated2 ", V/binary>>,
%         ej:set([<<"key2">>, <<"key2.2">>], Data, Vupd)
%     end,

%     io:format("~p~n", [DataUpd]),
%     io:format("~p~n", [Upd1(Upd2(Data))]),
%     ok.

% case_one_with_monad() ->
%     io:format("Case 1 (with monad):~n"),
%     State = erlmonads_state_t:new(erlmonads_identity),
%     ok.


%% Example 1

% fact_rec :: Int -> State Int Int
% fact_rec 0 = do
%     acc <- get
%     return acc
% fact_rec n = do
%     acc <- get
%     put (acc * n)
%     fact_rec (n - 1)

% fact :: Int -> Int
% fact n = fst $ runState (fact_rec n) 1

fib_m_step(State) ->
    State:modify(fun ({X, Y}) -> {Y, X+Y} end).

fib_v1(N) ->
    State = erlmonads_state_t:new(erlmonads_identity),
    {_, R} = State:exec(
        erlmonads:sequence(
            State,
            lists:duplicate(N, fib_m_step(State))
        ),
        {0, 1}
    ),
    R.

example1() ->
    io:format("Example 1~n"),
    N = fib_v1(3),
    io:format("~w~n",[N]).


main(_) ->
    example1(),
    ok.