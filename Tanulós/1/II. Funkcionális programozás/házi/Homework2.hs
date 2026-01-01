module Homework2 where
import Data.Char

-- Ez így nem annyira cuki : (

xor :: Bool -> Bool -> Bool
xor True  True = False
xor False False = False
xor _     _ = True

xnor :: Bool -> Bool -> Bool

xnor True True = True
xnor False False = True
xnor _ _ = False

xor3 :: Bool -> Bool -> Bool -> Bool
xor3 True True True = True
xor3 True False False = True
xor3 False True False = True
xor3 False False True = True
xor3 _ _ _ = False

allSame :: Bool -> Bool -> Bool -> Bool
allSame True True True = True
allSame False False False = True
allSame _ _ _ = False

exactlyOneTrue :: Bool -> Bool -> Bool -> Bool
exactlyOneTrue True False False = True
exactlyOneTrue False True False = True
exactlyOneTrue False False True = True
exactlyOneTrue _ _ _ = False


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
kinda True True True = True
kinda True True False = True
kinda True False True = True
kinda False True True = True
kinda _ _ _ = False


notReally :: Bool -> Bool -> Bool -> Bool
notReally False False False = True
notReally True False False = True
notReally False True False = True
notReally False False True = True
notReally _ _ _ = False

replaceIf :: Char -> Bool -> Char -> Char
-- Hamis esetén az első, igaz esetén a második karaktert adjuk vissza!
replaceIf a False b = a
replaceIf a True b = b