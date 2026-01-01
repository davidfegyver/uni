module Homework11 where

fromBin :: [Integer] -> Integer
fromBin xs = helper xs 1 0
  where
    helper [] helyiertek acc = acc
    helper (x:xs) helyiertek acc = helper xs (helyiertek * 2) (acc + x * helyiertek)

elemIds :: Eq a => a -> [a] -> [Int]
elemIds x xs = seged xs 0 []
  where
    seged [] _ acc = acc
    seged (y:ys) index acc
      | x == y    = seged ys (index + 1) (acc ++ [index])
      | otherwise = seged ys (index + 1) acc

myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile _ [] = []
myTakeWhile feltetel (x:xs)
  | feltetel x = x : myTakeWhile feltetel xs
  | otherwise = []

myDropWhile :: (a -> Bool) -> [a] -> [a]
myDropWhile _ [] = []
myDropWhile feltetel (x:xs)
  | feltetel x = myDropWhile feltetel xs
  | otherwise = x:xs

maybeAdd :: Num a => (Maybe a) -> [a] -> [a]
maybeAdd Nothing xs  = xs
maybeAdd (Just x) xs = map (+x) xs

floorOfPos :: RealFrac a => [a] -> [Integer]
floorOfPos xs = map floor (filter (>0) xs)

countLetter :: Char -> [String] -> [Integer]
countLetter char strs = map seged strs
  where
    seged str = fromIntegral (length (filter (== char) str))