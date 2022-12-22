import Data.List (nub)

type Point = (Int, Int)

toMotion :: String -> Point
toMotion val = case val of
    "R" -> (1, 0)
    "L" -> (-1, 0)
    "D" -> (0, 1)
    "U" -> (0, -1)
    _ -> (0, 0)

toMotions :: (String, String) -> [Point]
toMotions (a, b) = replicate (read b) (toMotion a)

add :: Point -> Point -> Point
add (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

getMotion :: Point -> Point -> Point
getMotion (fx, fy) (tx, ty) = do
    if abs(fx - tx) > 1 || abs(fy - ty) > 1 
        then (signum (tx - fx), signum (ty - fy))
        else (0, 0)

step :: [Point] -> Point -> [Point] 
step state (0, 0) = state
step [knot] motion = [add knot motion] 
step (knot:xx) motion = do
    let nextHead = add knot motion
    nextHead : (step xx $ getMotion (head xx) nextHead)

simMotions :: [Point] -> [Point] -> [Point]
simMotions [] _ = []
simMotions (motion:xx) state = do
    let nextState = step state motion
    (last nextState) : (simMotions xx nextState)

main :: IO ()
main = do
  input <- readFile "input.txt"
  let motions = concat $ map (toMotions . (break (== ' '))) $ lines input

  let part1 = length . nub $ simMotions motions (replicate 2 (0, 0))
  let part2 = length . nub $ simMotions motions (replicate 10 (0, 0))
  print(part1)
  print(part2)