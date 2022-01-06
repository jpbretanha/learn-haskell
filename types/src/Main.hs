module Main where

type Produto = (Integer, String, Double)

type Cliente = (Integer, String, Double)

preco :: Produto -> Double
preco (_, _, p) = p

pago :: Cliente -> Double
pago (_, _, p) = p

atualizaPreco :: Produto -> Double -> Produto
atualizaPreco (idProd, nome, preco) inflacao = (idProd, nome, preco * (1 + inflacao))

troco :: Produto -> Cliente -> Double
troco p c = pago c - preco p

type Assoc k v = [(k, v)]

find :: Eq k => k -> Assoc k v -> v
find k t = head [v | (k', v) <- t, k' == k]

-- > find 2 [(1,3), (5,4), (2,3)]

-- Tipo soma

data Dir = Norte | Sul | Leste | Oeste
  deriving (Show)

type Coord = (Int, Int)

type Passo = Coord -> Coord

para :: Dir -> Passo
para Norte (x, y) = (x, y + 1)
para Sul (x, y) = (x, y -1)
para Leste (x, y) = (x + 1, y)
para Oeste (x, y) = (x -1, y)

-- > para Norte (1, 2)

caminhar :: [Dir] -> Passo
caminhar ds coord = foldl (flip para) coord ds

-- Tipo Produto

data Ponto = MkPonto Double Double
  deriving (Show)

dist :: Ponto -> Ponto -> Double
dist (MkPonto x y) (MkPonto x' y') = sqrt $ (x - x') ^ 2 + (y - y') ^ 2

-- > dist (MkPonto 3 4) (MkPonto 2 2)

data Forma
  = Circulo Ponto Double
  | Retangulo Ponto Double Double

quadrado :: Ponto -> Double -> Forma
quadrado p l = Retangulo p l l

-- Tipos parametrizados

-- data Maybe' a = Nothing | Just a

maybeDiv :: Int -> Int -> Maybe Int
maybeDiv _ 0 = Nothing
maybeDiv x y = Just (x `div` y)

maybeHead :: [a] -> Maybe a
maybeHead [] = Nothing
maybeHead (x : xs) = Just x

divComErro :: Int -> Int -> Int
divComErro m n =
  case maybeDiv m n of
    Nothing -> error $ show m ++ " dividido por " ++ show n ++ " nao existe"
    Just x -> x

-- > divComErro 4 0

-- data Either a b = Left a | Right b

eitherDiv :: Int -> Int -> Either String Int
eitherDiv _ 0 = Left "divisao por 0"
eitherDiv m n = Right (m `div` n)

-- Fuzzy = Verdadeiro, Falso, Pertinencia Double
-- fuzzyfica = Falso se <= 0, Verdadeiro => 1, Pertinencia valor caso contrario

data Fuzzy = Verdadeiro | Falso | Pertinencia Double
  deriving (Show)

fuzzyfica :: Double -> Fuzzy
fuzzyfica n
  | n <= 0 = Falso
  | n >= 1 = Verdadeiro
  | otherwise = Pertinencia n

newtype Identidade = Id Int

-- Melhor modo é fazer com newtype, consome menos memoria, mais performatico. Problema é que não é possível
-- utilizar o tipo soma junto. Por isso, tem algumas limitações

-- Tipo recursivo

data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving (Show)

t :: Tree Int
t = Node t1 5 t2

t1 :: Tree Int
t1 = Node (Leaf 1) 3 (Leaf 4)

t2 :: Tree Int
t2 = Node (Leaf 6) 7 (Leaf 9)

contem :: Ord a => Tree a -> a -> Bool
contem (Leaf y) x = x == y
contem (Node l y r) x
  | x == y = True
  | x < y = l `contem` x
  | otherwise = r `contem` x

-- > t `contem` 2

-- Record Type

data Ponto3D = Ponto
  { coordX :: Double,
    coordY :: Double,
    coordZ :: Double
  }
  deriving (Show)

-- Algebra dos tipos

-- data Void
-- data () = ()

-- absurdo :: Void -> a
-- absurdo x = undefined

-- Tipo: coleção de valores relacionados
-- Classe: coleção de tipos
-- Métodos: funções de uma classe
-- Instância: a definição dos métodos de uma classe pra um tipo
main :: IO ()
main = do
  putStrLn "hello world"
