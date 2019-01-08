module Main where

import qualified Data.AttoLisp   as L
import           Data.Char
import qualified Data.Stringable as S
import           GetDeps
import           SexprHelper
import           Test.Tasty (defaultMain, testGroup)
import           Test.Tasty.QuickCheck
import           Types

main = defaultMain $ testGroup "All tests" [
    testProperty "Get an ID"               getAnId
  , testProperty "Get all IDs"             getAllIds
  , testProperty "Can parse s-expressions" canParseSexprs
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
                                2 -> x    :  rest
                                3 -> rest ++ [x]

canParseSexprs x = parseSexpr (show x) == lispToTree x

instance Arbitrary L.Lisp where
  arbitrary = choose (0, 200) >>= boundedLisp

boundedList :: (Int -> Gen a) -> Int -> Gen [a]
boundedList f n | n < 2 = return []
boundedList f n         = do i  <- choose (1, n)
                             x  <- f i
                             xs <- boundedList f (n - i)
                             return (x:xs)

boundedLisp n = oneof [saneString,
                       L.List <$> boundedList boundedLisp n]

-- | Stick to printable characters, to avoid bugs in AttoLisp
saneString = L.String . S.fromString . filter keep <$> arbitrary
  where keep c = isAlphaNum c && isAscii c
