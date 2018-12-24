{-# OPTIONS_GHC -fno-warn-orphans #-}
module NA.Types.Arbitrary where

import Test.QuickCheck
import GHC.Exts (fromString)
import qualified Data.Text as T

import NA.Types

instance Arbitrary Policy where
  arbitrary = Policy <$> arbitrary <*> arbitrary <*> arbitrary

instance Arbitrary Rule where
  arbitrary = Rule <$> arbitrary <*> arbitrary

instance Arbitrary Action where
  arbitrary = Action <$> arbitrary <*> arbitrary

instance Arbitrary Reason where
  arbitrary = fromString <$> arbitrary

instance Arbitrary T.Text where
  arbitrary = fromString <$> arbitrary

instance Arbitrary ActionType where
  arbitrary = arbitraryBoundedEnum
