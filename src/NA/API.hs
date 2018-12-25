module NA.API where

import Servant
import Servant.Yaml
import qualified Data.Text as T

import NA.Types

api :: Proxy API
api = Proxy

type API = DynamicAPI :<|> StaticAPI

dynamicAPI :: Proxy DynamicAPI
dynamicAPI = Proxy

type DynamicAPI
  = "policy" :>  PolicyAPI

type PolicyAPI
  =    Get '[JSON, YAML] [T.Text]
  :<|> Capture "name" T.Text :>
       ( Get '[JSON, YAML] Policy
    :<|> ReqBody '[YAML] Policy :> PostNoContent '[JSON, YAML] NoContent
       )

type StaticAPI
  = "static" :> Raw :<|> Raw
