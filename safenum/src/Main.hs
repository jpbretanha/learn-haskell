module Main where

-- Problema a ser resolvido

-- 4 `div` 0
-- (maxBound :: Int) + 1

data SafeNum a = NaN | NegInf | PosInf | SafeNum a deriving (Show)

safeAdd :: Int -> Int -> SafeNum Int
safeAdd x y
  | signum x /= signum y = SafeNum z
  | signum z /= signum x = if signum x > 0 then PosInf else NegInf
  | otherwise = SafeNum z
  where
    z = x + y

-- $> safeAdd maxBound 1

safeDiv :: Int -> Int -> SafeNum Int
safeDiv 0 0 = NaN
safeDiv x 0
  | x > 0 = PosInf
  | otherwise = NegInf
safeDiv x y = SafeNum (x `div` y)

-- $> safeDiv 0 0

boxedCoerce :: SafeNum a -> SafeNum b
boxedCoerce NaN = NaN
boxedCoerce PosInf = PosInf
boxedCoerce NegInf = NegInf
boxedCoerce _ = error "deu ruim"

instance Functor SafeNum where
  fmap f (SafeNum x) = SafeNum (f x)
  fmap _ x = boxedCoerce x

flatten :: SafeNum (SafeNum a) -> SafeNum a
flatten (SafeNum sn) = sn
flatten v = boxedCoerce v

f1 :: Int -> Int -> SafeNum Int
f1 x y =
  let xy = safeDiv x y
      yx = safeDiv y x
      safeAddXY = fmap safeAdd xy
      safeXYPlusYX = fmap (<$> yx) safeAddXY
   in (flatten . flatten) safeXYPlusYX

main :: IO ()
main = do
  putStrLn "hello world"
