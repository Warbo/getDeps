module Types where


import Data.Foldable



data TreeOf a = Leaf a
                | Node [TreeOf a]
                deriving (Eq, Show)

-- instance Show a => Show (TreeOf a) where
--     show (Leaf x)  = show x
--     show (Node xs) = unwords (map show xs)



instance Functor TreeOf where
    fmap f (Leaf x)  = Leaf (f x)
    fmap f (Node ts) = Node (map (fmap f) ts)


instance Foldable TreeOf where
    foldMap f (Node xs) = mconcat $ map (foldMap f) xs
    foldMap f (Leaf a) = f a
