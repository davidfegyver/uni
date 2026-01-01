module Homework2 where
import Data.Char

xor :: Bool -> Bool -> Bool
xor a b = a /= b

xnor :: Bool -> Bool -> Bool

xnor a b = 
    not (a `xor` b)

xor3 :: Bool -> Bool -> Bool -> Bool
xor3 a b c = 
    (a `xor` b) `xor` c

allSame :: Bool -> Bool -> Bool -> Bool
allSame a b c = 
    a == b && b == c

exactlyOneTrue :: Bool -> Bool -> Bool -> Bool
exactlyOneTrue a b c = 
    if a then (not b && not c) else (b `xor` c)


deleteIf :: Char -> Bool -> Char
-- Ha a második paraméter True, akor szóközt adjunk eredményül, különben adjuk vissza a bemeneti karaktert változatlanul!

deleteIf a True = ' '
deleteIf a False = a


swapTabSpace :: Char -> Char
-- Tab helyett szóközt, szóköz helyett tabot, különben ugyanazt a karaktert adjuk vissza!

swapTabSpace '\t' = ' '
swapTabSpace ' ' = '\t'
swapTabSpace a = a


--Szorgalmi:

kinda :: Bool -> Bool -> Bool -> Bool
kinda a b c = 
    if a then (b || c) else (b && c)

notReally :: Bool -> Bool -> Bool -> Bool
notReally a b c = 
    not (kinda a b c)

replaceIf :: Char -> Bool -> Char -> Char
-- Hamis esetén az első, igaz esetén a második karaktert adjuk vissza!
replaceIf a False b = a
replaceIf a True b = b