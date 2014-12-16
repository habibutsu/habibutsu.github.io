#!/usr/bin/env runhaskell

import Control.Monad.State
import Data.List

{-
Определение State-монады на основе трансформера
https://github.com/ghc/packages-transformers/blob/master/Control/Monad/Trans/State/Strict.hs#L85


https://github.com/ghc/ghc/blob/master/libraries/base/Control/Monad.hs
-}

-- Example 1 (factorial)

fact_rec :: Int -> State Int Int
fact_rec 0 = do
    acc <- get
    return acc
fact_rec n = do
    acc <- get
    put (acc * n)
    fact_rec (n - 1)

fact :: Int -> Int
fact n = evalState (fact_rec n) 1
-- fact n = fst $ runState (fact_rec n) 1

example1 = do
    putStrLn "Example1 (factorial):"
    print (fact 3)


-- Example 2 (fibonacci)

fib_step :: Int -> State (Int, Int) ()
fib_step n = do 
    (a,b) <- get
    put (b,a+b)

fib_v1 :: Int -> Int
fib_v1 n = flip evalState (0,1) $ do 
    forM [0..(n-1)] $ fib_step
    (a,b) <- get
    return a

fib_m_step :: State (Int, Int) ()
fib_m_step = 
    modify $ \(a,b) -> (b,a+b)

fib_v2 :: Int -> Int
fib_v2 n = flip evalState (0,1) $ do
    replicateM n fib_m_step
    gets fst

fib_v3 :: Int -> Int
fib_v3 n = flip evalState (0,1) $ do
    sequence (Data.List.replicate n fib_m_step)
    gets fst

example2 = do
    putStrLn "Example2 (fibonacci):"
    print (fib_v1 4)
    print (fib_v2 4)
    print (fib_v3 4)



main = do
    example1
    example2