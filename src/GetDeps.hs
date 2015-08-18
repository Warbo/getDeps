module GetDeps where

import Types
import Data.Aeson
import           Data.Stringable


--getDeps :: TreeOf String -> [TreeOf String]
getDeps (Node [Node [Leaf "name", Leaf n],
               Node [Leaf "mod",  Leaf m],
               Node [Leaf "pkg",  Leaf p]]) = [Out n m p]
getDeps (Node xs)                           = concatMap getDeps xs
getDeps _ = []


makeJson :: [Out] -> String
makeJson  = toString . encode . toJSON
