module Main where

import           Test.Tasty (defaultMain, testGroup)
import           Test.Tasty.QuickCheck
import           GetDeps
import           SexprHelper
import           Types

main = defaultMain $ testGroup "All tests" [
    testProperty "Get an ID"   getAnId
  , testProperty "Get all IDs" getAllIds
  ]

getAnId n m p = getDeps tree == [Out n m p]
  where tree = mkId (n, m, p)

getAllIds ids = all (`elem` output)   expected &&
                all (`elem` expected) output
  where output   = getDeps tree
        tree     = treeOf (map mkId ids)
        expected = map (\(n, m, p) -> Out n m p) ids

mkId (n, m, p) = Node [Node [Leaf "name", Leaf n],
                       Node [Leaf "mod",  Leaf m],
                       Node [Leaf "pkg",  Leaf p]]

-- | Combine the arguments into one big tree
--   To make things more interesting, we introduce some (deterministic)
--   variability to the construction.
treeOf :: [TreeOf String] -> TreeOf String
treeOf []     = Node []
treeOf (x:xs) = let Node rest = treeOf xs
                 in Node $ case length xs `mod` 2 of
                                0 -> [x, Node rest]
                                1 -> [Node rest, x]
                                2 -> [x]  ++ rest
                                3 -> rest ++ [x]
