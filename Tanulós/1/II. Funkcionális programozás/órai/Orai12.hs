count :: (a -> Bool) -> [a] -> Int
count p xs = length [x | x <- xs, p x]

myAll :: (a -> Bool) -> [a] -> Bool

-- myAll p xs = length xs == count p xs 
-- myAll p xs = null [x | x <- xs, not (p x)]
myAll p xs = and [p x | x <- xs]
{-
myAll _ [] = True
myAll p (x:xs) = p x && myAll p xs
-}


filters :: Eq a => [a] -> [a] -> [a]
filters ys xs = [x | x <- xs, x `notElem` ys]

applyOnNeighbours :: (a -> a -> a) -> [a] -> [a]
--applyOnNeighbours f xs = [f x y | (x,y) <- zip xs (tail xs)]
--applyOnNeighbours f xs = zipWith f xs (tail xs)
applyOnNeighbours f [] = [] 
applyOnNeighbours f [_] = []
applyOnNeighbours f (x:y:xs) = f x y : applyOnNeighbours f (y:xs)