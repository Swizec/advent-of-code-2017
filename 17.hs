
import Data.List
import Data.Maybe

spinlock::[Int] -> Int -> Int -> Int -> Int -> (Int, [Int])
spinlock buffer steps pos i iterations
    | i < iterations = spinlock (left ++ [i] ++ right) steps nextPos (i+1) iterations
    | otherwise = (nextPos, buffer)
    where spinPos = mod (pos+steps) (length buffer)
          (left, right) = splitAt (spinPos+1) buffer
          nextPos = spinPos+1

star1::Int -> Int
star1 steps = buffer!!pos
    where (pos, buffer) = spinlock [0] steps 0 1 2017

star2::Int -> Int
star2 steps = buffer!!(zeroAt+1)
    where (pos, buffer) = spinlock [0] steps 0 1 50000000
          zeroAt = Data.Maybe.fromJust $ elemIndex 0 buffer 

--main = print $ star1 301
main = print $ star2 301