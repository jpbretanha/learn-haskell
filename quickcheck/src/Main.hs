module Main where

import Data.List (sort)
import Test.QuickCheck (Property, (==>))

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x : xs) = qsort lhs ++ [x] ++ qsort rhs
  where
    lhs = [e | e <- xs, e <= x]
    rhs = [e | e <- xs, e > x]

prop_idempotencia :: Ord a => [a] -> Bool
prop_idempotencia xs = qsort (qsort xs) == qsort xs

prop_length :: Ord a => [a] -> Bool
prop_length xs = length (qsort xs) == length xs

prop_minimun :: Ord a => [a] -> Property
prop_minimun xs = not (null xs) ==> head (qsort xs) == minimum xs

prop_model :: Ord a => [a] -> Bool
prop_model xs = qsort xs == sort xs

-- * Paridade

par :: Integral a => a -> Bool
par = even

impar :: Integral a => a -> Bool
impar x = x `mod` 2 == 1

prop_alternanciaParImpar :: Integral a => a -> Bool
prop_alternanciaParImpar n = par n /= par (n + 1)

prop_seImparNaoPar :: Integral a => a -> Property
prop_seImparNaoPar n = par n ==> not (impar n)

-- $> quickCheck prop_seImparNaoPar

-- * Fatorial

fatorial :: (Eq p, Num p) => p -> p
fatorial n
  | n == 0 = 1
  | n == 1 = 1
  | otherwise = n * fatorial (n - 1)

prop_fatorialNFatorialNMaisUm :: (Ord p, Num p) => p -> Property
prop_fatorialNFatorialNMaisUm n = n >= 1 ==> fatorial n * (n + 1) == fatorial (n + 1)

-- * Collatz

collatz :: (Num p, Integral a) => a -> p
collatz 1 = 1
collatz n
  | par n = collatz (n `div` 2)
  | otherwise = collatz (3 * n + 1)

prop_collatz :: Integral a => a -> Property
prop_collatz n = n > 0 ==> collatz n == 1

--  quickCheck stdArgs {maxSuccess = 15000} prop_collatz

somaQuadPares :: Integral a => [a] -> a
-- somaQuadPares xs = sum [x ^ 2 | x <- xs, even x]
somaQuadPares xs =
  sum $
    map (^ 2) $
      filter even xs

-- $> all even [2,4,6,8]

-- $> any odd [2,4,6,8]

-- $> takeWhile even [2,4,6,7,8]

-- $> dropWhile even [2,4,6,7,8]

tamanho' :: Num a => [a] -> a
tamanho' = foldl (\n _ -> n + 1) 0

reverso' :: [a] -> [a]
reverso' = foldl (flip (:)) []

somaDosQuadradosImpares :: Integer
somaDosQuadradosImpares =
  sum (takeWhile (< 1000) (filter odd (map (^ 2) [1 ..])))

somaDosQuadradosImpares' :: Integer
somaDosQuadradosImpares' =
  sum $
    takeWhile (< 10000) $
      filter odd $
        map (^ 2) [1 ..]

somaDosQuadradosImpares'' :: Integer
somaDosQuadradosImpares'' =
  sum . takeWhile (< 10000) . filter odd . map (^ 2) $ [1 ..]

somaDosQuadradosImpares''' :: Integer
somaDosQuadradosImpares''' =
  let oddSquares = (filter odd . map (^ 2)) [1 ..]
      bellowLimit = takeWhile (< 10000) oddSquares
   in sum bellowLimit

main :: IO ()
main = do
  putStrLn "hello world"
