module Main where

import           Data.List
import           GetDeps
import           SexprHelper

main = do
    input <- getContents
    putStrLn (process input)
