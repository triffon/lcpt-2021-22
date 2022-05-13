import Prelude hiding (pred)

data N = O  | S N deriving (Eq, Ord, Show, Read)
data B = Tt | Ff  deriving (Eq, Ord, Show, Read)

split (s, t) f = f s t

cases Tt s t = s
cases Ff s t = t

r O s t     = s
r (S n) s t = t n (r n s t)

toN :: Integer -> N
toN 0 = O
toN n = S $ toN $ n - 1

fromN :: N -> Integer
fromN O     = 0
fromN (S n) = 1 + fromN n 

toB True  = Tt
toB False = Ff

fromB Tt = True
fromB Ff = False

-----------------------------------------------

plus m n  = r n m  (\_-> S)
plus' m n = r m n  (\_-> S)
plus'' m  = r m id (\_ p -> S . p)

pred n = r n O const

mult  m n = r m O (\_ p -> plus p n)
mult' m   = r m (const O) (\_ p n -> plus (p n) n)

fact n = r n (S O) (mult . S)

notB b = cases b Ff Tt
eqB b1 b2 = cases b1 b2 (notB b2)
eqB' b1 = cases b1 id notB

eqO n = r n Tt (\_ _ -> Ff)

eqN m = r m eqO (\_ p n -> cases (eqO n) Ff (p $ pred n))
eqN' m = r m eqO (\_ p n -> r n Ff (\n' _ -> p n'))
