module Homework12 where
import Data.List 

applyOnNeighbours :: (a -> a -> a) -> [a] -> [a]
-- applyOnNeighbours f xs = zipWith f xs (tail xs)
-- applyOnNeighbours f xs = [f x y | (x,y) <- zip xs (tail xs)]
applyOnNeighbours f [] = []
applyOnNeighbours f [_] = []
applyOnNeighbours f (x:y:xs) = f x y : applyOnNeighbours f (y:xs)

compress :: Eq a => [a] -> [(a, Int)]
-- compress xs = map (\ys -> (head ys, length ys)) (group xs)
-- compress xs = [(head ys, length ys) | ys <- group xs]
compress xs = map helper (group xs) 
    where
        helper xs = (head xs, length xs)

decompress :: Eq a => [(a, Int)] -> [a]
-- decompress xs = concatMap (\(x,n) -> replicate n x) xs
decompress xs = [ x | (x,n) <- xs, _ <- [1..n] ]
-- decompress xs = concat [replicate n x | (x,n) <- xs]


myCurry :: ((a, b) -> c) -> (a -> b -> c)
myCurry f x y = f (x, y)

myUncurry :: (a -> b -> c) -> ((a, b) -> c) 
myUncurry f (x, y) = f x y

pascalTriangle :: [[Integer]]

pascalTriangle = iterate next [1]
    where
        next row = zipWith (+) (0:row) (row++[0])