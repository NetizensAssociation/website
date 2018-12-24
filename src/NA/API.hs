module NA.API where

import Servant
import Servant.Yaml
import qualified Data.Text as T

import NA.Types

api :: Proxy API
api = Proxy

type API
  = "policy" :> Capture "name" T.Text :> PolicyAPI

type PolicyAPI
  =    Get '[JSON, YAML] Policy
  :<|> ReqBody '[JSON, YAML] Policy :> PostNoContent '[JSON, YAML] NoContent
