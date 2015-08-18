module GetDeps where

import Data.Foldable
import Types



getDeps :: TreeOf String -> [TreeOf String]
getDeps (Node ((Leaf "Var") : xs))  = case xs of
                                    ((Leaf "Var") : ys) -> ys
                                    (t:ts) -> (t:ts)
getDeps (Node ((Leaf "TyCon") : xs))  = xs
getDeps (Node ((Leaf "DataCon") : xs))  = xs
getDeps (Node xs) = (concatMap getDeps xs)
getDeps _ = []
