module Homework10 where

data Triple a b c = T a b c

instance (Show a, Show b, Show c) => Show (Triple a b c) where
  show (T a b c) = "<" ++ show a ++ "|" ++ show b ++ "|" ++ show c ++ ">"

instance (Eq a, Eq b) => Eq (Triple a b c) where
  (T a1 b1 _) == (T a2 b2 _) = a1 == a2 && b1 == b2

instance (Ord a, Ord b, Ord c) => Ord (Triple a b c) where
  (T a1 b1 c1) <= (T a2 b2 c2) = countTrue [a1 <= a2, b1 <= b2, c1 <= c2] >= 2
    where
      countTrue :: [Bool] -> Int
      countTrue [] = 0
      countTrue (x : xs)
        | x = 1 + countTrue xs
        | otherwise = countTrue xs

data MyList a = Nil | Cons a (MyList a)

instance (Show a) => Show (MyList a) where
  show lst = "[" ++ showHelper lst ++ "]"
    where
      showHelper Nil = ""
      showHelper (Cons x Nil) = show x
      showHelper (Cons x xs) = show x ++ "|" ++ showHelper xs
