module RopZH11 where
    data TriEither a b c = 
        
        LeftT a | 
        MiddleT b | 
        RightT c 

        deriving Show 


    instance (Eq a, Eq b, Eq c) => Eq (TriEither a b c) where
        (LeftT x) == (LeftT y) = x == y
        (MiddleT x) == (MiddleT y) = x == y
        (RightT x) == (RightT y) = x == y
        _ == _ = False
