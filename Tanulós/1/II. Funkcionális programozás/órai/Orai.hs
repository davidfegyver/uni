module Test1 where --fejléc
import Data.Char

(|:|) :: Bool -> Bool -> Bool
False |:| False = False
_    |:| _    = True


not' :: Bool -> Bool
not' True = False
not' False = True


xor :: Bool -> Bool -> Bool
True  `xor` True = False -- xor True True  = False
False `xor` False = False
_     `xor` _ = True


and' :: Bool -> Bool -> Bool

True `and'` True = True
_    `and'` _ = False



replaceNewline :: Char -> Char

replaceNewline  '\n' = ' '
replaceNewline  a = a


isNewline :: Char -> Bool


isNewline '\n' = True
isNewline _ = False

