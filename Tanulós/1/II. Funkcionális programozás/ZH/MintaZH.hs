import Data.Char   


doubleTriple :: [a] -> [a]
doubleTriple [] = []
doubleTriple [a] = [a,a,a]
doubleTriple [a,b] = [a,a,b,b]
doubleTriple xs = xs

lengthOfShorterHelper :: [a] -> [b] -> Integer -> Integer
lengthOfShorterHelper [] _ c = c
lengthOfShorterHelper _ [] c = c
lengthOfShorterHelper (a:as) (b:bs) c = lengthOfShorterHelper as bs c+1

lengthOfShorter :: [a] -> [b] -> Integer
lengthOfShorter as bs = lengthOfShorterHelper as bs 0


compressLetters :: String -> String

compressLetters "" = ""
compressLetters (c1:c2:cs)  
                            | c1 == c2 && (not (isUpper c1))  &&  (isAlpha c1) = (toUpper c1) : compressLetters cs
                            | otherwise = c1 : compressLetters (c2 :cs)
compressLetters c = c
