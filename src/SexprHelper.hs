module SexprHelper where

import qualified Data.AttoLisp                 as L
import qualified Data.Attoparsec.ByteString    as AB
import qualified Data.ByteString.Char8         as C
import           Data.List
import qualified Data.Stringable               as S
import           GetDeps
import           Text.ParserCombinators.Parsec
import           Types

parseLisp = AB.maybeResult . AB.parse L.lisp

parseSexpr :: String -> TreeOf String
parseSexpr s = case parseLisp (S.fromString s) of
                Nothing -> error ("Failed to parse: " ++ s)
                Just x  -> lispToTree x

lispToTree (L.List   xs) = Node (map lispToTree xs)
lispToTree (L.String s)  = Leaf (S.toString s)
lispToTree (L.Symbol x)  = Leaf ("mysim" ++ S.toString x)
