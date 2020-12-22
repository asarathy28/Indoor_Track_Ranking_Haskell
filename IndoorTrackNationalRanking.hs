module IndoorTrackNationalRanking (Event(..), TrackType(..), getConvertedList, getNameRanking, convertedTime, initRunner, initList, addList, addRunner, getEventRanking) where

type Performance = (TrackType, RawTime, Event)
data TrackType = Flat | Banked deriving Show
type Runner = (String, Performance)
data EventRanking = Event Event [Runner] deriving Show{--has the full details--}
type FullList = [Runner]
type RawTime = Time
type Time = (Int,Int,Int) {--(minute,second,decimals)--}
data Event = Mens3k | Womens3k | Mens5k | Womens5k deriving Show
instance Eq Event where
  Mens3k == Mens3k = True
  Womens3k == Womens3k = True
  Mens5k == Mens5k = True
  Womens5k == Womens5k = True
  x == y = False

initRunner :: String -> TrackType -> Event -> Time -> Runner
initRunner s Flat e t = (s,(Flat,t,e))
initRunner s Banked e t = (s,(Banked,t,e))

initList :: Runner -> FullList
initList r = [r]

addRunner :: Runner -> FullList -> FullList
addRunner r fl = fl++[r]

addList :: [Runner] -> FullList -> FullList
addList x fl = fl++x

-- retruns the ranking of a specified event
getEventRanking :: FullList -> Event -> EventRanking
getEventRanking fl e = Event e (mySort (filter (checkEvent e) fl))

-- returns a list of all times convert to flat track
getConvertedList :: FullList -> FullList
getConvertedList fl = map convertList fl

--returns the only the names of the runners for the national ranking of a specified event
getNameRanking :: FullList -> Event -> [String]
getNameRanking fl e = map name (mySort (filter (checkEvent e) fl))

name :: Runner -> String
name (s,p)  = s

convertList :: Runner -> Runner
convertList (s,(x,t,e)) = (s,(Flat,(convertedTime (x,t,e)), e))

checkEvent :: Event -> Runner -> Bool
checkEvent e (s,(t,p,er))
  | e == er = True
  | otherwise = False

--sort function is same as one made in Q2
mySort :: [Runner]->[Runner]
mySort list = foldr sortFunc [] list

sortFunc :: Runner -> [Runner] -> [Runner]
sortFunc z xs = foldr condition [] (xs++[z])

condition :: Runner -> [Runner] -> [Runner]
condition (sk,(pk)) ((s2,(p2)):xs)
  | (toCenti (convertedTime pk)) < (toCenti (convertedTime p2)) = ((sk,(pk)):(s2,(p2)):xs)
  | (toCenti (convertedTime pk)) > (toCenti (convertedTime p2)) = ((s2,(p2)):(sk,(pk)):xs)
  | (toCenti (convertedTime pk)) == (toCenti (convertedTime p2)) = ((sk,(pk)):(s2,(p2)):xs)
condition key [] = [key]

convertedTime :: Performance -> Time
convertedTime (Flat,t,e) = t
convertedTime (Banked,t,e) = ((minutes e t), (seconds e t), (decimals e t))

toCenti :: Time -> Double  --centiseconds
toCenti (m,s,d) = fromIntegral ((m*6000)+(s*100)+d)

decimals :: Event -> Time -> Int
decimals e t = (mod(round((toCenti t)*(bankedToFlat e))) 6000) - ((seconds e t)*100)

seconds :: Event -> Time -> Int
seconds e t = div (mod(round((toCenti t)*(bankedToFlat e))) 6000) 100

minutes :: Event -> Time -> Int
minutes e t = div (round((toCenti t)*(bankedToFlat e))) 6000

--converstion from banked track to flat track (banked tracks are "faster")
bankedToFlat :: Event -> Double
bankedToFlat (Mens3k) = 1.0116
bankedToFlat (Womens3k) = 1.0086
bankedToFlat (Mens5k) = 1.0107
bankedToFlat (Womens5k) = 1.0077
