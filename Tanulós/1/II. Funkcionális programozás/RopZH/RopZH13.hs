module RopZH13 where

myLookup :: Eq a => a -> [(a, b)] -> Maybe b
myLookup _ [] = Nothing
myLookup key ((k,v):xs)
  | key == k  = Just v
  | otherwise = myLookup key xs