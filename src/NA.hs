module NA where

import Servant
import Network.Wai.Handler.Warp
import Control.Logger.Simple (withGlobalLogging, LogConfig(..), logInfo)

import NA.Handler
import NA.API

main :: IO ()
main =
  let logCfg = LogConfig Nothing True
  in withGlobalLogging logCfg $ do
    logInfo "Starting server"
    run 8000 $ serve api server

server :: Server API
server = policyHandlers :<|> staticHandlers
