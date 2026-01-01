
module MintaVizsga where

points :: Integral a => [(String, a, a)] -> [(String, a)]
points xs = filter (\(_, p) -> p > 0) $ map calculate xs
    where
        calculate (nev, ido, hibapont) = (nev, 100 - (ido `div` 2 + hibapont))
        pointFilter (nev,pont) = pont < 0


type Apple = (Bool, Int)
type Tree = [Apple]
type Garden = [Tree]


ryuksApples :: Garden -> Int

ryuksApples  = sum . map (length . filter canPick)
    where canPick (ripe, h) = ripe && h <= 3


doesContain :: String -> String -> Bool
doesContain needles haystack = all (\needle -> elem needle haystack) needles

--doesContain needles haystack = all (\needle -> any (== needle) haystack) needles

barbie :: [String] -> String


barbie szoknyak = barbieHelper szoknyak 1
    where 
        barbieHelper [] _ = "farmer"

        barbieHelper (szoknya:szoknyak) i 
            | szoknya == "rozsaszin" = szoknya
            | szoknya == "fekete" || i `mod` 2 == 1 = barbieHelper szoknyak (i+1)
            | otherwise = szoknya


firstValid :: [a -> Bool] -> a -> Maybe Int
firstValid preds val = firstValidHelper preds val 0
    where 
        firstValidHelper [] _ _ = Nothing
        firstValidHelper (pred:preds) val i 
            | pred val       = Just i
            | otherwise = firstValidHelper preds val (i+1)


combineListsIf :: (a -> b -> Bool) -> (a -> b -> c) -> [a] -> [b] -> [c]

combineListsIf _ _ [] _ = []
combineListsIf _ _ _ [] = []
combineListsIf pred f (x:xs) (y:ys)
    | pred x y = f x y : combineListsIf pred f xs ys
    | otherwise = []

--combineListsIf pred f (x:xs) (y:ys) = [f x y | (x,y) <- zip (x:xs) (y:ys), pred x y]

data Line =
    Tram Integer [String] | Bus Integer [String]
    deriving (Eq, Show)

whichBusStop :: String -> [Line] -> [Integer]
whichBusStop stop lines = [num | Bus num stops <- lines, stop `elem` stops]
