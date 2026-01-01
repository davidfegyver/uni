module Homework3 where

indexOfArg :: Integer -> Integer -> Integer -> Integer
indexOfArg 0 x y = 1
indexOfArg x 0 y = 2
indexOfArg x y 0 = 3
indexOfArg _ _ _ = -1

evenSum :: Integer -> Integer -> Integer -> Bool
evenSum x y z = (x + y + z) `mod` 2 == 0

multiply :: Integer -> Integer -> Integer

multiply 0 b = 0
multiply a 0 = 0
multiply a b = multiply (a - 1) b + b
