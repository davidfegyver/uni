module RopZH12 where

sndOfBig  :: [(Integer, Integer)] -> [Integer]

-- sndOfBig xs = [y | (x,y) <- xs, x + y >= 100]

sndOfBig xs = map snd (filter helper xs)
  where
    helper (x,y) = x + y >= 100