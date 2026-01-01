sortedMerge :: Ord a => [a] -> [a] -> [a]

sortedMerge [] [] = []
sortedMerge [] a = a
sortedMerge a [] = a

sortedMerge (x:xs) (y:ys) 
    | x < y = x : sortedMerge xs (y:ys)
    | otherwise = y : sortedMerge (x:xs) ys

--

suffixes :: [a] -> [[a]]

suffixes [] = [[]]
suffixes (x:xs) = (x:xs) : suffixes xs

--

toBin :: Integer -> [Integer]

toBin 0 = []
toBin n =  (n `mod` 2) : toBin (n `div` 2)

--

fromBin :: [Integer] -> Integer

fromBin [] = 0
fromBin xs = sum [ b * 2 ^ i | (b, i) <- zip xs [0..] ]