#!/usr/bin/env runhaskell

import Control.Monad.State
import Text.Printf

fact_rec :: Int -> State Int Int
fact_rec 0 = do
    acc <- get
    return acc
fact_rec n = do
    acc <- get
    put (acc * n)
    fact_rec (n - 1)

{-fact_rec :: Int -> State Int Int
fact_rec 0 =
    get >>= \acc ->
        return acc
fact_rec n = 
    get >>= \acc ->
        put (acc * n) >>
            fact_rec (n - 1)-}

fact :: Int -> Int
fact n = evalState (fact_rec n) 1

main = do
    putStrLn "Factorial:"
    printf "fact(6) = %d\n" (fact 6)
