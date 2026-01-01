module Homework6 where
    merge :: [a] -> [a] -> [a]
    merge [] ys = ys
    merge xs [] = xs
    merge (x:xs) (y:ys) = x:y:merge xs ys   

    elimElem :: Eq a => a -> [a] -> [a]
    elimElem _ [] = []
    elimElem e (x:xs)
        | e == x    = elimElem e xs
        | otherwise = x : elimElem e xs

    myNub :: Eq a => [a] -> [a]
    myNub [] = []
    myNub (x:xs) = x : myNub (elimElem x xs)

    runs :: Int -> [a] -> [[a]]
    runs _ [] = []
    runs n xs = take n xs : runs n (drop n xs)
    