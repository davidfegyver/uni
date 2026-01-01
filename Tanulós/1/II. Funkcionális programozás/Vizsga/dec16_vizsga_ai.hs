module Vizsga_with_AI where

import Data.Char (isUpper)
import Data.Maybe (mapMaybe, listToMaybe)
import Data.List (maximumBy)
import Data.Function (on)
import Control.Applicative (liftA2)

doubleUpper :: String -> Bool
doubleUpper xs = any (\(a, b) -> isUpper a && isUpper b) (zip xs (tail xs))

duplicateOdds :: Integral a => [a] -> [a]
duplicateOdds = concatMap (\x -> if odd x then [x, x] else [x])

changeFirsts :: [[a]] -> [[a]]
changeFirsts = map swapHead
  where
    swapHead (x:y:xs) = y:x:xs
    swapHead list     = list

andMaybePairs :: [(Maybe Bool, Maybe Bool)] -> [Maybe Bool]
andMaybePairs = map (uncurry (liftA2 (&&)))

selectFilter :: (a -> Bool) -> [a] -> [a] -> [(a,a)]
selectFilter p xs ys = filter (\(a, b) -> p a || p b) (zip xs ys)

evalIfLower :: Ord a => a -> (a -> a) -> [a] -> [a]
evalIfLower limit f xs = map check xs
  where
    check x = let val = f x 
              in if val < limit then val else x

data Transaction = Income Integer | Expense Integer 
    deriving (Show, Eq, Ord)

largestIncome :: [Transaction] -> Maybe Integer
largestIncome ts = 
    case mapMaybe getIncome ts of
        [] -> Nothing
        incomes -> Just (maximum incomes)
  where
    getIncome (Income x) = Just x
    getIncome _          = Nothing

largestNeighbors :: (Num a, Ord a) => [a] -> Maybe (a,a)
largestNeighbors xs 
    | length xs < 2 = Nothing
    | otherwise     = Just (maximumBy (compare `on` uncurry (+)) pairs)
  where
    pairs = zip xs (tail xs)