module Vizsga where
import Data.Char
import Data.Maybe 
import Data.List
import Data.Function


-- Van egymás után két nagybetű a szövegben?
doubleUpper :: String -> Bool
doubleUpper (x:y:xs) 
    | isUpper x && isUpper y = True
    | otherwise = doubleUpper (y:xs)

doubleUpper (x:_) = False
doubleUpper (_) = False

-- Páratlan számokat duplázzuk meg a listában
duplicateOdds :: Integral a => [a] -> [a]
duplicateOdds (x:xs) 
    | odd x = (x:x:duplicateOdds(xs))
    | even x = (x:duplicateOdds(xs))
duplicateOdds [] = []

-- Cseréljük meg a lista minden belső listájának első két elemét
changeFirsts :: [[a]] -> [[a]]
changeFirsts xss = map f xss
    where 
        f (x:y:xs) = (y:x:xs)
        f x = x 

-- Maybe Bool párokból álló listán végezzünk logikai ÉS műveletet
andMaybePairs hmms = map f hmms 
    where 
        f (_,Nothing) = Nothing
        f (Nothing,_) = Nothing
        f (Just first,Just second) = Just (first && second)

-- Két lista elemeiből képezzünk párokat, ha az egyik elem megfelel a predikátumnak

selectFilter :: (a -> Bool) -> [a] -> [a] -> [(a,a)]
selectFilter pred xs ys = filter f (zip xs ys)
    where 
        f (x,y) = pred x || pred y

-- Alkalmazzuk a függvényt az elemekre, ha az eredmény kisebb, mint a megadott érték
evalIfLower :: Ord a => a -> (a -> a) -> [a] -> [a]
evalIfLower lt f xs = map helper xs 
    where 
    helper x 
        | f x < lt = f x 
        | otherwise = x

-- Hozzuk létre a Transaction típust a Income és Expense konstruktorokkal, Show, Eq, Ord példányokkal
data Transaction = Income Integer | Expense Integer deriving (Show, Eq, Ord)

-- Keressük meg a legnagyobb Income értéket a tranzakciók között
largestIncome :: [Transaction] -> Maybe Integer


largestIncome ts
    | meow == [] = Nothing
    | otherwise = Just (maximum meow)
    where 
        meow = (map fromJust (filter isJust (map helper ts)))
        helper (Income x) = Just x
        helper (Expense x) = Nothing


largestNeighbors :: (Num a, Ord a) => [a] -> Maybe (a,a)

-- Egy számokat tartalmazó listában keressük meg az egymás melletti elempárok közül azt a párt, amelynek az összege a legnagyobb
largestNeighbors [] = Nothing
largestNeighbors [_] = Nothing

largestNeighbors xs = Just (fst (maximumBy (compare `on` snd) ( reverse (meow xs))))
    
    where 
        zipped (x:xs) = zip (x:xs) xs
        zipped [] = []
        zippedSums (x:xs) = zipWith (+) (x:xs) xs
        zippedSums [] = []

        meow xs = zip (zipped xs) (zippedSums xs)        