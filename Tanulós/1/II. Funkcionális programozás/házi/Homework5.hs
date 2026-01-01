module Homework5 where
    mountain :: Integer -> [Integer]
    mountain n  | n <= 0    = []
                | otherwise = [1..n] ++ [n-1,n-2..1]

    wave :: Integer -> [Integer]
    wave n  | n < 0     = []
            | otherwise = [0..n] ++ [n-1,n-2..0] ++ [(-1),(-2)..(-n)] ++ [(-n+1)..0]

    sumDivisibleBy :: [Integer] -> Integer -> Bool
    sumDivisibleBy xs n | n == 0    = False
                        | otherwise = sum xs `mod` n == 0

    signOfHead :: [Integer] -> Integer
    signOfHead (x:_) | x < 0     = -1
                     | x > 0     = 1
                     | otherwise = 0

    range :: [Integer] -> [Integer]
    range [] = []
    range [x] = [x..]
    range [x,y] = [x, y ..]
    range (x:y:z:_) = [x, y .. z]