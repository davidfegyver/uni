import Data.Char

module Gyak4 where 
    
    
    sphereVolume :: Double -> Double 

    sphereVolume r = (4/3) * pi * r^3

    myAbs :: Int -> Int
    myAbs x 
            | x < 0     = -x
            | otherwise = x

    signum :: Int -> Int
    signum x 
            | x < 0     = -1
            | x == 0    = 0
            | otherwise = 1

    swapUpperLower :: Char -> Char 
    swapUpperLower c 
            | isLower c = toUpper c
            | isUpper c = toLower c
            | otherwise = c


    fact :: Int -> Int
    fact 0 = 1
    fact n 
        | n > 0 = n * fact (n-1)
        | otherwise = 0

    sumTo :: Int -> Int
    sumTo n 
        | n > 0 = n + sumTo (n-1)
        | otherwise = 0

    sumBetween :: Int -> Int -> Int
    sumBetween m n 
        | m == n    = n
        | m > n     = m + sumBetween (m-1) n
        | m < n     = m + sumBetween (m+1) n