module Gyak where

myDrop :: Int -> [a] -> [a]
myDrop 0 xs = xs
myDrop _ [] = []
myDrop n (_:xs) | n < 0     = xs
                | otherwise = myDrop (n-1) xs