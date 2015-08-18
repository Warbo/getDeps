{-# LANGUAGE OverloadedStrings  #-}
module Types where


import Data.Foldable
import Data.Aeson



data TreeOf a = Leaf a
                | Node [TreeOf a]
                deriving (Eq, Show)


instance Functor TreeOf where
    fmap f (Leaf x)  = Leaf (f x)
    fmap f (Node ts) = Node (map (fmap f) ts)


instance Foldable TreeOf where
    foldMap f (Node xs) = mconcat $ map (foldMap f) xs
    foldMap f (Leaf a) = f a


data Out   = Out {
    outName :: String
  , outModule  :: String
  , outPackage    :: String
  } deriving (Eq, Show)

instance ToJSON Out where
  toJSON o = object [
      "name" .=                     outName o
    , "module"  .=                     outModule  o
    , "package"    .=                     outPackage    o
    ]
