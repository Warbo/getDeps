module SexprHelper where

import qualified Data.AttoLisp                 as L
import qualified Data.Attoparsec.ByteString    as AB
import qualified Data.ByteString.Char8         as C
import qualified Data.Stringable               as S
import           GetDeps
import Types
import           Text.ParserCombinators.Parsec

parseLisp = AB.maybeResult . AB.parse L.lisp

parseSexpr :: String -> TreeOf String
parseSexpr s = case parseLisp (S.fromString s) of
                Nothing -> error ("Failed to parse: " ++ s)
                Just x  -> lispToTree x

lispToTree (L.List   xs) = Node (map lispToTree xs)
lispToTree (L.String s)  = Leaf (S.toString s)
