module ZHGYak where
import Data.Char

{-
    Definiáljuk azt a függvényt, amely eldönti egy listáról
    hogy adott elemszámnál több elemet tartalmaz-e.
    A megoldásban használjunk mintaillesztést és rekurziót,
    de véletlenül se használjuk a length függvényt.
-}


isLongerThan :: [a] -> Integer -> Bool

isLongerThan _ n | n < 0     = True
isLongerThan [] _ = False
isLongerThan (_:xs) n = isLongerThan xs (n-1)




{-
isLongerThan [1] 0
isLongerThan [1,2] 1
isLongerThan [1,2,3,4,5] 2
isLongerThan [1..] 100
isLongerThan [] (-1)
isLongerThan [1..] (-10)
not (isLongerThan [1] 2)
not (isLongerThan [] 2)
not (isLongerThan [1..29] 30)
-}
------------------------------------------------------------------------------------

{-
    Definiáljuk azt a függvényt, ami egy szövegből csak a nagybetűket tartja meg.
    A megoldást a szöveg/lista rekurzív bejárásával adjuk meg.
    Megjegyzés: A megoldásban szükség lehet a Data.Char modul isUpper függvényére.
-}


onlyUppers :: String -> String
onlyUppers "" = ""
onlyUppers (x:xs)   | isUpper x = (x:onlyUppers xs)
                    | otherwise = onlyUppers xs


{-
onlyUppers "" == []
onlyUppers "fox" == []
onlyUppers "fOX" == "OX"
onlyUppers "FOX" == "FOX"
onlyUppers "The quiCk brown fOX jumPS OveR tHe Lazy dog" == "TCOXPSORHL"
onlyUppers "The Quick Brown Fox Jumps oVer The Lazy DOG" == "TQBFJVTLDOG"
-}
------------------------------------------------------------------------------------

{-
    Definiáljuk azt a függvényt, amely egy listában megadja egy
    keresett elem pozícióit/indexeit. Az indexelést 0-tól kezdjük.
    Segítség: A feladatot egy segédfüggvénnyel tudjuk megoldani,
    ami a lista bejárása során számon tartja az aktuális elem indexét.
    Megjegyzés: Az Eq a azt jelenti, hogy a paraméterül kapott értékek egyenlősége vizsgálható (==).
-}


elemIds :: Eq a => a -> [a] -> [Int]
elemIds _ [] = []
elemIds e xs = elemIdsHelper e xs 0
  where
    elemIdsHelper _ [] _ = []
    elemIdsHelper e (y:ys) index
      | e == y    = index : elemIdsHelper e ys (index + 1)
      | otherwise = elemIdsHelper e ys (index + 1)





{-
elemIds 2 [] == []
elemIds 1 [1] == [0]
elemIds 1 [1,1,1,1] == [0, 1, 2, 3]
elemIds 2 [1,2,1,1,0,1,2,32,1,2,42,2] == [1, 6, 9, 11]
elemIds 'a' "The quick brown fox jumps over the lazy dog" == [36]
elemIds 'o' "The quick brown fox jumps over the lazy dog" == [12, 17, 26, 41]
-}
------------------------------------------------------------------------------------

{-
    Definiáljuk azt a függvényt, ami egy lista elemei közé tűzdel egy adott elemet.
    Például: inject 0 [1,2,3,4] esetén, az elvárt működés: [1,0,2,0,3,0,4]
    Ügyeljünk arra, csak az eredeti lista elemei közé kerüljön az új elem. Azaz, sem az elejére, sem pedig a végére ne kerüljön ebből!
-}


injectElem :: Eq a => a -> [a] -> [a]

injectElem _ [] = []
injectElem e (x:xs) 
    | xs == [] = [x]
    | otherwise = x : e : injectElem e xs


{-
injectElem 0 [] == []
injectElem 0 [1] == [1]
injectElem 0 [1,2] == [1, 0, 2]
injectElem (-1) [1,2,3,4] == [1, -1, 2, -1, 3, -1, 4]
injectElem 'a' "The quick brown fox jumps over the lazy dog" == "Tahaea aqauaiacaka abaraoawana afaoaxa ajauamapasa aoavaeara atahaea alaaazaya adaoag"
-}
------------------------------------------------------------------------------------

{-
    Definiáljuk azt a függvényt, ami egy elem beszúrását teszi lehetővé egy rendezett listába úgy,
    hogy a lista rendezettsége továbbra is megmaradjon.
    Feltehetjük, hogy a paraméterül kapott lista rendezett.
    Megjegyzés: Az Ord a azt jelenti, hogy a paraméterül kapott értékek összehasonlíthatók: (>), (<), (>=), (<=), (==)
-}


ordInsert :: Ord a => a -> [a] -> [a]

ordInsert e [] = [e]
ordInsert e (x:xs) 
    | e < x = (e:x:xs)
    | otherwise = (x:ordInsert e xs)


{-
ordInsert 10 [] == [10]
ordInsert 3 [5,7,8,9] == [3, 5, 7, 8, 9]
ordInsert 10 [5,7,8,9] == [5, 7, 8, 9, 10]
ordInsert 8 [5,7,9,10] == [5, 7, 8, 9, 10]
-}
------------------------------------------------------------------------------------

{-
    Definiáljuk azt a függvényt, amely két rendezett listát összefésül olyan módon,
    hogy megtartja az elemek rendezettségét.
    A két listában monoton növekvő módon szerepelnek az elemek.
-}


sortedMerge :: Ord a => [a] -> [a] -> [a]
sortedMerge [] [] = []
sortedMerge xs [] = []
sortedMerge [] xs = []

sortedMerge (x:xs) (y:ys) 
    | x < y = (x:y:sortedMerge xs ys)
    | otherwise = (y:x:sortedMerge xs ys)


{-
sortedMerge [] [] == []
sortedMerge [1,2,3] [] == [1, 2, 3]
sortedMerge [] [1,2,3] == [1, 2, 3]
sortedMerge [0,2..10] [1,3..10] == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
sortedMerge [0,4..25] [1,3..20] == [0, 1, 3, 4, 5, 7, 8, 9, 11, 12, 13, 15, 16, 17, 19, 20, 24]
-}
------------------------------------------------------------------------------------

{-
    Definiáljuk azt a függvényt, ami egy lista összes szuffixumát megadja.
    Egy [1,2,3,4] lista szuffixumai: [1,2,3,4], [2,3,4], [3,4], [4], []
-}


--suffixes :: [a] -> [[a]]


{-
suffixes [] == [[]]
suffixes [1] == [[1], []]
suffixes [3,2,1] == [[3, 2, 1], [2, 1], [1], []]
suffixes [1..10] == [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [2, 3, 4, 5, 6, 7, 8, 9, 10], [3, 4, 5, 6, 7, 8, 9, 10], [4, 5, 6, 7, 8, 9, 10], [5, 6, 7, 8, 9, 10], [6, 7, 8, 9, 10], [7, 8, 9, 10], [8, 9, 10], [9, 10], [10], []]
-}
------------------------------------------------------------------------------------

{-
    Definiáljuk azt a függvényt, ami egy adott “szabásminta” alapján adott hosszúságú részekre darabolja a listát.
    Megjegyzés: Használhatjuk a take és drop függvényeket.
-}


-- slice :: [Int] -> [a] -> [[a]]


{-
slice [] [] == []
slice [2] [] == [[]]
slice [2,3,2] [] == [[], [], []]
slice [3,2,3] [1..10] == [[1, 2, 3], [4, 5], [6, 7, 8]]
slice [3,2,3,4,2] [1..10] == [[1, 2, 3], [4, 5], [6, 7, 8], [9, 10], []]
slice [1..5] [1..15] == [[1], [2, 3], [4, 5, 6], [7, 8, 9, 10], [11, 12, 13, 14, 15]]
-}
------------------------------------------------------------------------------------

-- lásd: http://lambda.inf.elte.hu/ListsExtraTasks.xml#polinom-ki%C3%A9rt%C3%A9kel%C3%A9se


-- polinom :: Num a => [a] -> a -> a


{-
polinom [] 3 == 0
polinom [1] 3 == 1
polinom [0,2] 2 == 4
polinom [1,0,2] 4 == 33
polinom [3,1,2,7] 4 == 487
polinom [1,3,1,4,7] 5 == 4916
-}
------------------------------------------------------------------------------------

{-
    Definiáljuk azt a függvényt, ami egy pozitív egész számnak megadja a kettes számrendszerbeli megfelelőjét.
    A listában a számjegyeit fordított sorrendben legyenek, azaz a legkisebb helyi érték a lista elején, a legnagyobb a végén
    Lásd: http://lambda.inf.elte.hu/ListsExtraTasks.xml#kettes-sz%C3%A1mrendszerbe-val%C3%B3-alak%C3%ADt%C3%A1s
-}


-- toBin :: Integer -> [Integer]

{-
toBin 0 == []
toBin 1 == [1]
toBin 2 == [0, 1]
toBin 10 == [0, 1, 0, 1]
toBin 42 == [0, 1, 0, 1, 0, 1]
toBin 12102 == [0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1]
-}
------------------------------------------------------------------------------------

{-
    Definiáljuk azt a függvényt, ami egy kettes számrendszerbeli számot tízes számrendszerbeli számmá alakít.
    A reprezentációban a legkisebb helyi értéke a lista elején, a legnagyobb pedig a lista végén található.
-}


-- fromBin :: [Integer] -> Integer

{-
fromBin [] == 0
fromBin [1] == 1
fromBin [0,1] == 2
fromBin [1,1] == 3
fromBin [0,0,1] == 4
fromBin [0,1,1] == 6
fromBin [1,1,1] == 7
fromBin [1,0,1,0,1,1,1,1,1] == 501
-}
------------------------------------------------------------------------------------

{-
    Bontsunk fel egy listát a leghosszabb lehetséges szigorúan monoton csükkenő részlistáira.
     Pl:           [3,2,1,5,7,5,3,3,2]              listára
     az eredmény:  [[3,2,1], [5], [7,5,3], [3,2]]
-}


-- descendingSubLists :: Ord a => [a] -> [[a]]


{-
descendingSubLists [3,2,1,5,7,5,3,3,2] == [[3,2,1],[5],[7,5,3],[3,2]]
descendingSubLists [1..10] == [[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]]
descendingSubLists [20,18..0] == [[20,18,16,14,12,10,8,6,4,2,0]]
descendingSubLists (replicate 6 'a') == ["a","a","a","a","a","a"]
descendingSubLists [3,2,1,5,4,3,2,66,8,6,2] == [[3,2,1],[5,4,3,2],[66,8,6,2]]
descendingSubLists [] == []
-}
------------------------------------------------------------------------------------

{-
    Töröljük a listából azokat az elemekat, amik NEM SZIGORÚAN KISEBBEK mint az ÖSSZES előtte lévő elem.
    Az eredmény az így kapott szigorúan monoton csökkenő lista. Az elemek sorrendjét nem változtatjuk.

     Pl:           [10,11,3,2,2,3,1,5,3,0,3,2]
     az eredmény   [10,   3,2,    1,    0    ]
-}

-- elimNonDescending :: Ord a => [a] -> [a]


{-
elimNonDescending [10,11,3,2,2,3,1,5,3,0,3,2] == [10,3,2,1,0]
elimNonDescending [5,4,2,1,0] == [5,4,2,1,0]
elimNonDescending [1..100] == [1]
elimNonDescending (replicate 42 'a') == "a"
elimNonDescending [3,2,1,5,4,3,3,2,1] == [3,2,1]
elimNonDescending [] == []
-}