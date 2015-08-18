module GetDeps where

import Types
import Data.Aeson
import           Data.Stringable

-- getDeps :: TreeOf String -> [TreeOf String]
-- getDeps (Node ((Leaf "Var") : xs))  = case xs of
--                                     ((Node ((Node ((Leaf "Var"):zs)):ls)):ys) -> zs ++ ls ++ ys
--                                     _ -> xs
-- getDeps (Node ((Leaf "TyCon") : xs))  = xs
-- getDeps (Node ((Leaf "DataCon") : xs))  = xs
-- getDeps (Node xs) = (concatMap getDeps xs)
-- getDeps _ = []

--getDeps :: TreeOf String -> [TreeOf String]
getDeps (Node [Node [Leaf "name", Leaf n],
               Node [Leaf "mod",  Leaf m],
               Node [Leaf "pkg",  Leaf p]]) = [Out n m p]
getDeps (Node xs)                           = concatMap getDeps xs
getDeps _ = []


makeJson :: [Out] -> String
makeJson  = toString . encode . toJSON
