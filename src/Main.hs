import           GetDeps
import           SexprHelper
import Data.List

main = do
    input <- getContents
    print (nub . getDeps . parseSexpr $ input)
