module GetDeps where

import           Data.Aeson
import           Data.Stringable
import           Types

getDeps :: TreeOf String -> [Out]
getDeps (Node [Node [Leaf "name", Leaf n],
               Node [Leaf "mod",  Leaf m],
               Node [Leaf "pkg",  Leaf p]]) = [Out n m p]
getDeps (Node xs)                           = concatMap getDeps xs
getDeps _ = []

makeJson :: [Out] -> String
makeJson  = toString . encode . toJSON
