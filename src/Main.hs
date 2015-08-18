import           GetDeps
import           SexprHelper
import           Data.List

main = do
    input <- getContents
    print (makeJson . nub . getDeps . parseSexpr $ input)
