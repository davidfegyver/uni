module Vizsga where
import Data.Char


doubleUpper :: String -> Bool
doubleUpper (x:y:xs)
    | isUpper x && isUpper y = True
    | otherwise = doubleUpper (y:xs)
doubleUpper _ = False


duplicateOdds :: Integral a => [a] -> [a]
duplicateOdds [] = []
duplicateOdds (x:xs)
    | x `mod` 2 == 1 = x : x : duplicateOdds xs
    | otherwise = x : duplicateOdds xs


changeFirsts :: [[a]] -> [[a]]
changeFirsts [] = []
changeFirsts [[]] = [[]]
changeFirsts (x:xs) = changeFirsts' x : changeFirsts xs
    where
        changeFirsts' [] = []
        changeFirsts' (x:[]) = (x:[])
        changeFirsts' (x:y:xs) = (y:x:xs)


andMaybePairs :: [(Maybe Bool, Maybe Bool)] -> [Maybe Bool]
andMaybePairs [] = []
andMaybePairs ((Nothing,_):rest) = Nothing : andMaybePairs rest
andMaybePairs ((_,Nothing):rest) = Nothing : andMaybePairs rest
andMaybePairs ((Just x,Just y):rest) = (Just (x && y)) : andMaybePairs rest


selectFilter :: (a -> Bool) -> [a] -> [a] -> [(a,a)]
selectFilter _ [] _ = []
selectFilter _ _ [] = []
selectFilter fv (x:xs) (y:ys)
    | fv x || fv y = (x,y) : selectFilter fv xs ys 
    | otherwise = selectFilter fv xs ys


evalIfLower :: Ord a => a -> (a -> a) -> [a] -> [a]
evalIfLower _ _ [] = []
evalIfLower n fv (x:xs)
    | (fv x) < n = (fv x) : evalIfLower n fv xs
    | otherwise = x : evalIfLower n fv xs


data Transaction = Income Integer | Expense Integer deriving(Show,Eq,Ord)

largestIncome :: [Transaction] -> Maybe Integer
largestIncome xs = largestIncome' xs 0
    where
        largestIncome' [] 0 = Nothing
        largestIncome' [] max = Just max
        largestIncome' (Income x : xs) max
            | x > max || max == 0 = largestIncome' xs x
            | otherwise = largestIncome' xs max
        largestIncome' (Expense x : xs) max = largestIncome' xs max


largestNeighbors :: (Num a, Ord a) => [a] -> Maybe (a,a)
largestNeighbors [] = Nothing
largestNeighbors (x:[]) = Nothing
largestNeighbors (x:y:xs) = largestNeighbors' (x:y:xs) (x,y)
    where
        largestNeighbors' (x:y:xs) (max1,max2)
            | x + y > max1 + max2 = largestNeighbors' (y:xs) (x,y)
            | otherwise = largestNeighbors' (y:xs) (max1,max2)
        largestNeighbors' (x:[]) (max1,max2) = Just (max1,max2)