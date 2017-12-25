
import Data.List.Split
import Data.List
import Data.Ord (comparing)

input = [
        "48/5",
        "25/10",
        "35/49",
        "34/41",
        "35/35",
        "47/35",
        "34/46",
        "47/23",
        "28/8",
        "27/21",
        "40/11",
        "22/50",
        "48/42",
        "38/17",
        "50/33",
        "13/13",
        "22/33",
        "17/29",
        "50/0",
        "20/47",
        "28/0",
        "42/4",
        "46/22",
        "19/35",
        "17/22",
        "33/37",
        "47/7",
        "35/20",
        "8/36",
        "24/34",
        "6/7",
        "7/43",
        "45/37",
        "21/31",
        "37/26",
        "16/5",
        "11/14",
        "7/23",
        "2/23",
        "3/25",
        "20/20",
        "18/20",
        "19/34",
        "25/46",
        "41/24",
        "0/33",
        "3/7",
        "49/38",
        "47/22",
        "44/15",
        "24/21",
        "10/35",
        "6/21",
        "14/50"]

testinput = [
    "0/2",
    "2/2",
    "2/3",
    "3/4",
    "3/5",
    "0/1",
    "10/1",
    "9/10"]

parseRow::String -> (Int, Int)
parseRow row = (read left::Int, read right::Int)
    where [left, right] = splitOn "/" row

prepInput::[String] -> [(Int, Int)]
prepInput input = map parseRow input

poolWithout::(Int, Int) -> [(Int, Int)] -> [(Int, Int)]
poolWithout link pool = filter (\x -> link /= x) pool

-- This is basically a recursive A* implementation

-- find next link in bridge and which port to use for next next link
findNext::Int -> [(Int, Int)] -> (Int, (Int, Int))
findNext port [] = (port, (-1,-1))
findNext port pool
    | port == left = (right, (left, right))
    | port == right = (left, (left, right))
    | otherwise = findNext port (tail pool)
    where (left, right) = head pool

-- find all possible candidates for next link
candidates::Int -> [(Int, Int)] -> [(Int, (Int, Int))] -> [(Int, (Int, Int))]
candidates port [] acc = acc
candidates port pool acc
    | (-1, -1) == link = acc
    | otherwise = acc ++ [(nextPort, link)] ++ (candidates port nextPool acc)
    where (nextPort, link) = findNext port pool
          nextPool = poolWithout link pool

-- build bridge with maximum score
-- this is basically A*
buildBridge::Int -> [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)]
buildBridge port [] bridge = bridge
buildBridge port pool bridge
    | length opts > 0 = maximumBy (comparing heuristic) $ map (\(nextPort, link) -> 
        buildBridge nextPort (poolWithout link pool) (bridge ++ [link])) opts
    | otherwise = bridge
    where opts = candidates port pool []

heuristic::[(Int, Int)] -> Int
heuristic links = sum [a+b | (a, b) <- links]

-- build longest bridge with highest score
buildLongestBridge::Int -> [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)]
buildLongestBridge port [] bridge = bridge
buildLongestBridge port pool bridge
    | length opts > 0 = maximumBy heuristic2 $ map (\(nextPort, link) -> 
        buildLongestBridge nextPort (poolWithout link pool) (bridge ++ [link])) opts
    | otherwise = bridge
    where opts = candidates port pool []

heuristic2::[(Int, Int)] -> [(Int, Int)] -> Ordering
heuristic2 a b
        | la < lb = LT
        | la > lb = GT
        | la == lb = compare (heuristic a) (heuristic b)
        where la = length a
              lb = length b


-- star1
--main = print $ heuristic $ buildBridge 0 (prepInput input) []

main = print $ heuristic $ buildLongestBridge 0 (prepInput input) []