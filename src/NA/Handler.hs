module NA.Handler where

import Servant
import Data.Yaml
import Data.Text.Lens
import Control.Lens
import Control.Logger.Simple
import Control.Monad.IO.Class (liftIO)
import qualified Data.Text as T
import System.Directory (getDirectoryContents)

import NA.Types
import NA.API

-- * Policy handlers

getPolicy :: T.Text -> Handler Policy
getPolicy policyName = do
  logDebug $ "Getting policy: " <> policyName
  res <- liftIO $ decodeFileEither (dataDir <> policyName ^. unpacked)
  case res of
    Left _ -> do
      logWarn $ "Could not find policy: " <> policyName
      throwError err500
    Right v -> do
      logDebug $ "Found policy: " <> policyName
      return v

postPolicy :: T.Text -> Policy -> Handler NoContent
postPolicy pname policy = do
  logDebug $ "Received new policy: " <> pname
  liftIO $ encodeFile (T.unpack pname) policy
  return NoContent

listPolicies :: Handler [T.Text]
listPolicies = do
  logDebug "Listing policies"
  files <- liftIO $ getDirectoryContents dataDir
  return $ filter (\x -> not $ "." `T.isPrefixOf` x) $ T.pack <$> files

policyHandlers :: Server PolicyAPI
policyHandlers = listPolicies :<|> \x -> (getPolicy x :<|> postPolicy x)


-- * Static handlers

staticHandlers :: Server StaticAPI
staticHandlers = staticHandler :<|> indexHandler

staticHandler :: Server Raw
staticHandler = serveDirectoryWebApp staticDir

indexHandler :: Server Raw
indexHandler = serveDirectoryFileServer staticDir

dataDir :: FilePath
dataDir = "./data/"

staticDir :: FilePath
staticDir = "./static/"
