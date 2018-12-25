module NA.APISpec (spec) where

import Servant.Aeson.GenericSpecs
import Test.Hspec

import NA.Types.Arbitrary ()
import NA.API

spec :: Spec
spec = describe "NA.API" $ do
  apiRoundtripSpecs dynamicAPI
