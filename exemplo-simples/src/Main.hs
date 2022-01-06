module Main where

tamanho :: Num p => [a] -> p
tamanho [] = 0
tamanho (_ : xs) = 1 + tamanho xs

main :: IO ()
main = do
  let x = 4
  putStrLn "hello world"
